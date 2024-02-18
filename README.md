# City Properties App Documentation

## Overview

The City Properties App is a SwiftUI-based application that facilitates the display of a list of city properties and provides detailed information about each property. The core components of the application include:

1. **PropertiesViewModel:** A Swift class responsible for managing properties data and handling network interactions. It is designed to work with SwiftUI views and is essential for fetching and updating both a list of city properties and detailed property information.

2. **PropertyListScrollView:** A SwiftUI view that utilizes the `PropertiesViewModel` to display a scrollable list of city properties. Each property is represented by a customizable cell (`PropertiesCellView`) within a `LazyVStack`, ensuring efficient rendering for large property lists.

3. **PropertyDetailScreen:** A SwiftUI view for presenting detailed information about a specific property. This view uses the `PropertiesViewModel` to fetch and manage property details, including images, ratings, descriptions, location, and payment methods. The UI is structured with various subviews for each section of information.

## PropertiesViewModel

### Features

- **City Properties Retrieval:** Asynchronously fetches a list of city properties and updates the `properties` variable.
- **Property Details Retrieval:** Asynchronously fetches detailed information about a specific property and updates the `property` variable.
- **Loading State:** Utilizes the `isLoading` property to track and communicate the loading state to the UI.
- **Image Handling:** Manages an array of property images through the `images` property.
- **Realm Integration:** Utilizes the `HWRealmManager` to store and retrieve data persistently.

### Usage

To integrate the `PropertiesViewModel` into your SwiftUI views, create an instance and use its methods for fetching city properties and property details.

```swift
@StateObject private var viewModel = PropertiesViewModel()

// Fetch city properties
await viewModel.getProperties()

// Fetch property details by providing property ID
await viewModel.getProperty(id: "your_property_id_here")
PropertyListScrollView
Features
Efficient Lazy Loading: Uses LazyVStack for efficient rendering of a scrollable list of city properties.
ViewModel Integration: Utilizes the PropertiesViewModel to handle data fetching and loading states.
Responsive UI: Customizable property cell (PropertiesCellView) for a seamless and responsive user interface.
Navigation Integration: Implements NavigationLink for navigating to property details.
Usage
Embed PropertyListScrollView within a ScrollView in your SwiftUI views, providing an array of CityProperty to the properties parameter.

swift
Copy code
ScrollView {
    PropertyListScrollView(properties: yourPropertiesArray)
}
PropertyDetailScreen
Features
Detailed Property Information: Displays images, ratings, descriptions, location, and payment methods.
Asynchronous Loading: Uses PropertiesViewModel for asynchronous fetching of property details.
Error Handling: Includes an alert for data retrieval issues.
Responsive UI: Structured with various subviews for different sections of information.
Usage
Embed PropertyDetailScreen within a NavigationView in your SwiftUI views, providing the property ID to the id parameter.

swift
Copy code
NavigationView {
    PropertyDetailScreen(id: yourPropertyID)
}
Examples
City Properties List View
swift
Copy code
struct PropertyListScrollView: View {
    @StateObject private var viewModel = PropertiesViewModel()
    let yourPropertiesArray: [CityProperty]

    var body: some View {
        ScrollView {
            PropertyListScrollView(properties: yourPropertiesArray)
        }
    }
}
Property Detail View
swift
Copy code
struct PropertyDetailScreen: View {
    @StateObject private var viewModel = PropertiesViewModel()
    let yourPropertyID: String

    var body: some View {
        NavigationView {
            PropertyDetailScreen(id: yourPropertyID)
        }
    }
}
```

## Testing

### PropertyListViewModelTest

The `PropertyListViewModelTest` class contains unit tests for validating the behaviour of the `PropertiesViewModel` class under various scenarios.

### Test Initialization

- Method: `testInitialization`
- Description: Tests the initialization of the `PropertiesViewModel` class and verifies that its properties are initialized to nil.

### Test Fetching City Properties (Success)

- Method: `testgetCityPropertiesSuccess`
- Description: Tests the asynchronous fetching of city properties when the request is successful. It simulates a network response with expected data and asserts that the fetched properties match the expected count and have no errors.

### Test Fetching City Properties (Failure)

- Method: `testgetCityPropertiesFailed`
- Description: Tests the asynchronous fetching of city properties when the request fails. It verifies that the error is not nil and the properties array is empty.

### Test Fetching Property Details (Success)

- Method: `testgetPropertySuccessFul`
- Description: Tests the asynchronous fetching of property details when the request is successful. It simulates a network response with expected data and asserts that the fetched property details match the expected values.

### Test Fetching Property Details (Failure)

- Method: `testgetPropertyFailed`
- Description: Tests the asynchronous fetching of property details when the request fails. It verifies that the error is not nil and that the fetched property details do not match the expected values.

### Test Fetching Property Details (ID Not Provided)

- Method: `testgetPropertyFailedWhenIdisNotProvided`
- Description: Tests the asynchronous fetching of property details when the ID is not provided. It verifies that the error is not nil and that the fetched property details do not match the expected values.

