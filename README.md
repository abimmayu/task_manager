# Task Manager

A Flutter application designed with key features like Authentication, Task Management, Search and Filter functionalities, Offline Mode, and Unit Testing.

---

## **How ​​to Run Application**

1. **Clone Repository**:

```bash
git clone <repository_url>
cd <repository_folder>
```

2. **Install Dependencies**:\
Run the following command to install all required dependencies:

```bash
flutter pub get
```

3. **Run the App**:\
Use the following command to run the app on an emulator or physical device:

```bash
flutter run
```

4. **Testing**:\
To run unit tests:

```bash
flutter test
```

---

## **Architecture Used**

This application uses the **Clean Architecture** approach combined with **Bloc ( Business Logic Component)** for state management.

### **Architecture Layer**:

1. **Presentation Layer**:

- Consists of widgets and Blocks to handle presentation logic.

2. **Domain Layer**:

- Contains Use Cases and entities that define the application's business rules .

3. **Data Layer**:

- Manage data from mock API (example: [Reqres](https://reqres.in)) or local storage like SQLite or Hive.

4. **Core Layer**:

- Contains common functions and utilities such as validation, dependency injection, and services for local storage.

---

## **Key Features**

### **Authentication**

- Login using email and password.
- Login form validation:
- Email must be valid.
- Password must be at least 8 characters.
- Using mock API from [Reqres](https://reqres.in) for login endpoint.

### **Task Management**

- The task list is displayed in ListView form.
- CRUD feature for tasks, with the following attributes:
- **Title**: String, max 50 characters.
- **Description**: String, optional.
- **Due Date**: Date, required.
- ** Status**: Enum (Pending, In Progress, Completed).
- Data is stored using SQLite or Hive to support offline mode.

### **Search and Filter**

- Search by title.
- Filter the task list by status (Pending, In Progress, Completed).

### **Offline Mode**

- The application can still be used without an internet connection.
- Data will be synced to the mock API when an internet connection is available again.

### **UI/UX**

- Using Material Design.
- Basic animations like page transitions and button click effects.

### **Unit Testing**

- Unit tests for:
- Login form validation.
- Task status manipulation.

### **Dependency Injection**

- Implementation of dependency injection to facilitate service and repository management.

### **JSON Serializable**

- Used to facilitate serialization and deserialization of JSON data.

---

## **Third Party Libraries* *

1. **Bloc**: State management.

```yaml
bloc: ^8.1.4
flutter_bloc: ^8.1.6
```

2. **SQFLite: Local data storage
```yaml
sqflite: ^2.4.1 ```

3. **Flutter ScreenUtil**: UI adjustment for different screen sizes.

```yaml
flutter_screenutil: ^5.9.3
```

4. **GoRouter**: Navigation.

```yaml
go_router: ^14.6.2
```

5. **Mocktail**: Mock testing.

```yaml
mocktail: ^1.0.4
```

6. **Dio**: HTTP client for API requests .

```yaml
dio: ^5.7.0
```

7. **Equatable**: Helps implement comparability on objects.

```yaml
equatable: ^2.0.7
```

8. **Flutter Secure Storage** : For secure data storage.

```yaml
flutter_secure_storage: ^9.2.2
```

9. **Shared Preferences**: Simple data storage.

```yaml
shared_preferences: ^2.3.4
```

10. **Logger**: Logging for debugging.

```yaml
logger: ^2.5.0
```

11. **Internet Connection Checker**: Checking the connection internet.

```yaml
internet_connection_checker: ^3.0.1
```

12. **Google Fonts**: Fonts from Google.

```yaml
google_fonts: ^6.2.1
```

13. **Permission Handler**: To manage application permissions.

```yaml
permission_handler: ^11.3.1
```

14. **Timezone**: Time zone management.

```yaml
timezone: ^0.10.0
```

15. **Flutter Local Notifications**: Show local notifications.

```yaml
flutter_local_notifications: ^18.0.1
```

16. **Get It**: Dependency Injection.

```yaml
get_it: ^8.0.3
```

17. **Dartz**: Supports functional programming patterns.

```yaml
dartz: ^0.10.1
```

---

## **Bonus ( Optional)**

1. **Push Notification**:

- Remind users about tasks approaching Due Date.
- Use Firebase Cloud Messaging (FCM).

2. **Dark Mode / Light Mode**:

- Implement dark and light themes which can be changed by the user through the application settings.
