//
//  ContentView.swift
//  ShazamTokenGen
//
//  Created by Cédric Bahirwe on 16/12/2024.
//

import SwiftUI
import SwiftJWT

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

        }
        .padding()
        .task {
            generateJWT()
        }
    }

    func generateJWT() {
        let teamID = #"teamID"# // Your team ID from https://developer.apple.com/account
        let keyID = #"keyID"# // The Id of the Media ID you created
        let privateKey = #"privateKey"# // Text content from your .p8 file

        let header = Header(kid: keyID)
        // Set expiration to 5 months (150 days)
        let claims = ClaimsStandardJWT(iss: teamID, exp: Date() + (60 * 60 * 24 * 150), iat: .now)

        let jwt = SwiftJWT.JWT(header: header, claims: claims)

        guard let privateKeyData = privateKey.data(using: .utf8) else {
            fatalError("Private key must be UTF8 encoded")
        }

        do {
            let jwtSigner = JWTSigner.es256(privateKey: privateKeyData)
            let jwtEncoder = JWTEncoder.init(jwtSigner: jwtSigner)
            let token = try jwtEncoder.encodeToString(jwt)

            print("JWT Token:")
            print(token)
        } catch {
            print("Error generating JWT token : \(error.localizedDescription)")
        }

    }
}

#Preview {
    ContentView()
}
