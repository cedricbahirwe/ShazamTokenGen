# ShazamTokenGen

ShazamTokenGen is a sample application showing how to generating JWT (JSON Web Token) tokens using a private key and specific claims. It demonstrates the use of the [SwiftJWT](https://github.com/Kitura/Swift-JWT) library to create tokens for authentication or secure communication.

## Features
- Generates a JWT token with custom claims.
- Configurable team ID, key ID, and private key.

## Requirements
- Xcode 14.0+
- Swift 5+
- SwiftJWT library

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/cedricbahirwe/ShazamTokenGen
   ```
2. Open the `ShazamTokenGen.xcodeproj` file in Xcode.
3. Build and run the project on a compatible simulator or device.

## Usage
1. Open the app.
2. The app will automatically generate a JWT token upon launch and log it to the console. This token can be used for testing API calls, integrating with secure services, or debugging authentication flows. In this example, it was used for `ShazamKit` on Android

## Code Overview
### Core Functionality
The key functionality resides in the `ContentView` file:
- **`generateJWT()`**: Handles the JWT generation process, including:
  - Defining the team ID and key ID.
  - Setting the private key.
  - Creating the JWT header and claims.
  - Signing and encoding the token.

### Example Code Snippet
```swift
func generateJWT() {
    let teamID = #"teamID"# // Your team ID from https://developer.apple.com/account
    let keyID = #"keyID"# // The ID of the Media Key you created
    let privateKey = #"privateKey"# // Text content from your .p8 file

    let header = Header(kid: keyID)
    let claims = ClaimsStandardJWT(iss: teamID, exp: Date() + (60 * 60 * 24 * 150), iat: .now)
    let jwt = SwiftJWT.JWT(header: header, claims: claims)

    guard let privateKeyData = privateKey.data(using: .utf8) else {
        fatalError("Private key must be UTF8 encoded")
    }

    do {
        let jwtSigner = JWTSigner.es256(privateKey: privateKeyData)
        let jwtEncoder = JWTEncoder(jwtSigner: jwtSigner)
        let token = try jwtEncoder.encodeToString(jwt)

        print("JWT Token:")
        print(token)
    } catch {
        print("Error generating JWT token: \(error.localizedDescription)")
    }
}
```

## Customization
To customize the generated JWT token:
1. Replace the `teamID`, `keyID`, and `privateKey` placeholders with your own credentials. You can find your team ID and key ID in your Apple Developer account under Certificates, Identifiers & Profiles. The private key is the text content from the `.p8` file you downloaded when creating the key.
2. Adjust the claims (e.g., `exp`, `iat`) in the `generateJWT()` function as needed.

## Security Notice
- **Do not expose your private key in the source code**. This example includes placeholders for demonstration purposes only. Use secure methods (e.g., environment variables, secure storage) to handle sensitive information in production.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments
- [SwiftJWT](https://github.com/Kitura/Swift-JWT) for JWT handling in Swift.
- Apple for the SwiftUI framework.
