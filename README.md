# Mobilet - Clean Architecture Demo

Mobilet is a demonstration project showcasing the implementation of Clean Architecture in iOS development. This project follows the separation of concerns and the dependency rule to create a modular, scalable, and testable codebase.

## Overview

The project focuses on a mobile banking application that displays a list of transactions. It employs the Clean Architecture principles, separating the code into different layers:

- **Entities**: Contains the business models, such as the `Transaction` entity.
- **UseCases**: Manages the business logic, including fetching transactions and transaction details.
- **Repositories**: Handles data retrieval from different sources, such as API calls or local caches.
- **Presenters**: Coordinates the presentation logic, updating the UI based on the data received from the UseCases.
- **ViewControllers**: Implements the UI and interacts with the Presenter.

## Project Structure

The project is organized into several components:

- **TransactionsList**: The main feature module responsible for displaying a list of transactions.
  - **ViewController**: Manages the UI and responds to user interactions.
  - **ViewModel**: Handles the presentation logic and communicates with the UseCases.
  - **Cell**: Represents the custom table view cell for displaying transaction information.
  - **DetailsHolder**: A view that shows additional details of a transaction when expanded.
  - **Extensions**: Additional extensions for UI setup, UITableViewDelegate, and UITableViewDataSource conformance.

## Dependencies

The project relies on the following dependencies:

- **Foundation**: Provides fundamental building blocks for the project.
- **UIKit**: Manages the UI components and interactions.
- **Alamofire**: Used for handling network requests.
- **Kingfisher**: Simplifies image downloading and caching.

## How to Run

To run the project:

1. Clone the repository.
2. Open the `Mobilet.xcodeproj` file using Xcode.
3. Build and run the project.

## Clean Architecture Principles

The project demonstrates the following Clean Architecture principles:

- **Separation of Concerns**: Different components focus on specific tasks, promoting maintainability and readability.
- **Dependency Rule**: Dependencies point inwards, ensuring that the inner layers are independent of the outer layers.
- **Testability**: The architecture allows for easy unit testing of individual components.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Feel free to explore, modify, and use this project as a reference for implementing Clean Architecture in your iOS applications. If you have any questions or suggestions, please open an issue.

Happy coding! 🚀
