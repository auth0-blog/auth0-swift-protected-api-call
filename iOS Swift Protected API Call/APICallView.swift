//
//  APICallView.swift
//  iOS Swift Protected API Call
//
//  Created by Auth0 on 3/27/24.
//  Companion project for the Auth0 Blog
//  “Calling a protected API from an iOS Swift App”
//

import SwiftUI
import Auth0

struct Event: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService: Codable {
    func credentials() async throws -> Credentials {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        
        return try await withCheckedThrowingContinuation { continuation in
            credentialsManager.credentials { result in
                switch result {
                case .success(let credentials):
                    continuation.resume(returning: credentials)
                    break

                case .failure(let reason):
                    continuation.resume(throwing: reason)
                    break
                }
            }
        }
    }
    
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            var request = URLRequest(url: url)
            let credentials = try await credentials();
            
            /* Convention is for an Access Token to be supplied as Authorization Bearer in the header of an HTTP request. Apple's documentation is somewhat ambiguious when it comes to how do this, so for the purpose of this example I'll follow the advice suggested at https://ampersandsoftworks.com/posts/bearer-authentication-nsurlsession/
             */
            request.setValue("Bearer \(credentials.accessToken)", forHTTPHeaderField: "Authorization")
            
            let (data, result) = try await URLSession.shared.data(for: request)
            guard let response = result as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
}

class EventViewModel: ObservableObject {
    @Published var eventData = [Event]()
    
    func fetchData() async {
        guard let downloadedEvents: [Event] = await WebService().downloadData(fromURL: "** Put your API path here. **") else {return}
        DispatchQueue.main.async {
            self.eventData = downloadedEvents
        }
    }
}

struct APICallView: View {
    @StateObject var vm = EventViewModel()
    
    var body: some View {
        List(vm.eventData) { event in
            HStack {
                Text("\(event.id)")
                    .padding()
                    .overlay(Circle().stroke(.blue))
                
                VStack(alignment: .leading) {
                    Text(event.title)
                        .bold()
                        .lineLimit(1)
                    
                    Text(event.body)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
        }
        .onAppear {
            if vm.eventData.isEmpty {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }
}

#Preview {
    APICallView()
}
