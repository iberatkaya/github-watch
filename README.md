# Git Watch

Git Watch is a GitHub client app for watchOS. It is a SwiftUI app that uses GitHub's [REST API](https://docs.github.com/en/rest) and [OAuth authentication](https://docs.github.com/en/rest/guides/basics-of-authentication).

## Table of contents

- [Installation](#installation)
- [Setup](#setup)
- [Features](#features)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [Authors](#authors)
- [Sources](#sources)

## Installation

- Download from the [App Store](https://apps.apple.com/tr/app/git-watch-github/id1555218889) to check it out.
- Clone this repo and run the app.

## Setup

Create a Swift file with your:

- `clientID`=your_github_app_client_id
- `clientSecret`=your_github_app_client_secret
- `redirectUrl`=your_callback_url (you may use the app's [current callback](https://iberatkaya.github.io/github-watch-web-callback/))

You may find more detailed information at [GitHub's documentation](https://docs.github.com/en/rest/guides/basics-of-authentication#registering-your-app).

## Features

- [x] View user and organization profiles.
- [x] View user and organization repositories.
- [x] View user and organization stats (repo count/followers/following etc.).
- [x] Search for repositories.
- [x] View repository description, stats (stars/forks/issues etc.), and README.
- [x] View a user's organizations.
- [x] Search for users.
- [x] View commits.
- [x] View issues.
- [x] View issue comments.
- [x] View pull requests.

## Screenshots

<p align="center">
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/1.png" width="160" >
        <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/2.png" width="160" >
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/3.png" width="160" >
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/4.png" width="160" >
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/5.png" width="160" >
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/6.png" width="160" >
    <img alt="Screenshot" src="https://raw.githubusercontent.com/iberatkaya/github-watch/main/screenshots/7.png" width="160" >
</p>

## Contributing

Contributions, issues and feature requests are welcome! Feel free to check [issues page](https://github.com/iberatkaya/github-watch/issues).

## Authors

👤 **Ibrahim Berat Kaya**

- GitHub: [@iberatkaya](https://github.com/iberatkaya)
- LinkedIn: [@ibrahim-berat-kaya](https://www.linkedin.com/in/ibrahim-berat-kaya/)

👤 **Selim Ustel**

- GitHub: [@stelselim](https://github.com/stelselim)
- LinkedIn: [@selimustel](https://www.linkedin.com/in/selimustel/)

## Sources

Git Watch was implemented following [@Alexey Naumov](https://github.com/nalexn)'s [Clean Architecture for SwiftUI](https://nalexn.github.io/clean-architecture-swiftui/) article. I highly suggest checking it out.
