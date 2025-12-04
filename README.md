GitHub User Search – iOS App

A simple UIKit-based iOS application that fetches and displays GitHub user details using the public GitHub API.

⸻

 Build & Run Instructions
	1.	Requirements
	•	Xcode 15 or later
	•	iOS 15+ deployment target
	•	Swift (latest stable)
	2.	Steps
	1.	Clone or download the project.
	2.	Open the .xcodeproj in Xcode.
	3.	No third-party dependencies → no additional setup required.
	4.	Select a simulator or device.
	5.	Build & run using Cmd + R.

⸻

 Architecture & Design Notes
	•	UIKit + Auto Layout
Uses UIKit views with Storyboard. Layout supports all iPhone sizes.
	•	Presentation Flow
	•	A single text field for entering a GitHub username
	•	“Search” button or return-key triggers the API call
	•	Result screen shows:
	•	Avatar image (avatar_url)
	•	Display name (name)
	•	Public repository count (public_repos)
	•	Networking
	•	Uses URLSession with completion handlers.
	•	No third-party networking frameworks per constraints.
	•	Simple APIService handles the request and decodes JSON into a Swift GitHubUser struct.
	•	Error Handling
	•	404 user not found → inline message or alert
	•	All UI updates occur on the main thread
	•	Image Loading
	•	Avatar image loaded via URLSession
