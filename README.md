# 🍽️ Recipe App

A modern Flutter application demonstrating **Clean Architecture**, **BLoC**, **Repository Pattern**, **Dependency Injection**, **Offline Caching**, and **JWT Authentication**.

The project is built with scalability, maintainability, and production-ready practices in mind.

---

# 📱 Features

- 🔐 JWT Authentication
- 🔄 Automatic Token Refresh
- 🍽️ Recipe Listing
- 🔍 Search Recipes
- 📄 Recipe Details
- ♾️ Infinite Pagination
- 📦 Offline Caching (Hive)
- 🔄 Pull to Refresh
- 🌙 Dark / Light Theme
- 🧩 Dependency Injection (GetIt)
- 🏗️ Clean Architecture
- ⚡ Optimized API Handling

---

# 🏛️ Architecture

The project follows **Clean Architecture**.

```
                   Presentation
                (UI + Bloc/Cubit)
                       │
                       ▼
                    UseCases
                       │
                       ▼
                  Repository
               (Domain Contract)
               ┌────────┴────────┐
               ▼                 ▼
        Remote Data         Local Data
          Source              Source
         (REST API)            (Hive)
               │                 │
               └────────┬────────┘
                        ▼
                     Domain
                    (Entities)
```

### Layers

### Presentation

Responsible for:

- UI
- BLoC/Cubit
- User Interaction
- Navigation

---

### Domain

Responsible for:

- Business Logic
- Entities
- Repository Contracts
- Use Cases

---

### Data

Responsible for:

- API Calls
- Local Database
- Model Mapping
- Repository Implementation

---

# 🧠 State Management

The application uses **flutter_bloc**.

Each feature owns its own BLoC.

## AuthBloc

Responsible for

- Login
- Logout
- Session Validation
- Authentication State

---

## RecipeBloc

Responsible for

- Initial Loading
- Pagination
- Pull to Refresh
- Search
- Offline Cache Loading

---

## RecipeDetailBloc

Responsible for

- Fetching Recipe Detail
- Error Handling
- Loading State

---

## ThemeCubit

Responsible for

- Theme Switching
- Persisting User Preference

---

# 🔄 Application Flow

```
UI

↓

Bloc

↓

UseCase

↓

Repository

↓

Remote API / Local Database

↓

Repository

↓

UseCase

↓

Bloc

↓

UI
```

---

# 🔐 Authentication Flow

```
Login

↓

Access Token
Refresh Token

↓

Flutter Secure Storage

↓

Every API Request

↓

Auth Interceptor

↓

Token Added Automatically
```

---

# 🔄 Token Refresh Strategy

Every authenticated request goes through an **AuthInterceptor**.

If the access token expires:

```
API Request

↓

401 Unauthorized

↓

Refresh Token API

↓

Save New Tokens

↓

Retry Original Request
```

If refresh token also expires:

```
Logout User

↓

Clear Secure Storage

↓

Navigate to Login Screen
```

This process is completely automatic.

---

# 📦 Offline Caching Strategy

Hive is used as the local database.

### First Launch

```
API

↓

Fetch Recipes

↓

Store in Hive

↓

Display UI
```

---

### Offline

```
No Internet

↓

Read Recipes From Hive

↓

Display Cached Data
```

### Refresh

```
Pull To Refresh

↓

Clear Old Cache

↓

Fetch Latest Recipes

↓

Update Hive
```

Only the **first page refresh** clears the cache, preventing duplicate records during pagination.

---

# ♾️ Pagination Strategy

The API uses

```
skip
limit
```

Flow

```
Initial Load

↓

30 Recipes

↓

Scroll 80%

↓

Load Next Page

↓

Append New Recipes

↓

Update List
```

Duplicate recipes are removed using their unique IDs before appending.

---

# 🔍 Search Strategy

Recipe search uses the DummyJSON search endpoint.

Flow

```
User Types

↓

Debounce

↓

Search API

↓

Display Results
```

When the search field becomes empty:

```
Restore Original Recipe List
```

---

# 💾 Local Storage

### Hive

- Recipe List
- Recipe Details

---

### Flutter Secure Storage

- Access Token
- Refresh Token
- Login Status

---

### SharedPreferences

- Theme Preference

---

# 🌐 Networking

Networking is implemented using **Dio**.

Includes

- API Client
- Logging Interceptor
- Authentication Interceptor
- Refresh Token Interceptor

---

# 📂 Project Structure

```
lib
│
├── app
│   ├── di
│   ├── routes
│   └── app.dart
│
├── core
│   ├── constants
│   ├── network
│   ├── storage
│   ├── theme
│   └── services
│
├── feature
│   │
│   ├── auth
│   │   ├── data
│   │   ├── domain
│   │   └── presentation
│   │
│   └── recipe
│       ├── data
│       ├── domain
│       └── presentation
│
└── main.dart
```

---

# 📚 Packages

| Package | Purpose |
|----------|---------|
| flutter_bloc | State Management |
| dio | Networking |
| hive | Offline Storage |
| flutter_secure_storage | Secure Token Storage |
| shared_preferences | Theme Persistence |
| get_it | Dependency Injection |
| go_router | Navigation |
| equatable | Value Equality |
| logger | API Logging |
| shimmer | Loading Animation |
| cached_network_image | Image Caching |

---

# 🚀 Future Improvements

- Favorite Recipes
- Recipe Categories
- Tag Filters
- Connectivity Banner
- Unit Testing
- Widget Testing
- Integration Testing
- CI/CD Pipeline
- Flavor Configuration

---

# 🛠️ Tech Stack

- Flutter
- Dart
- Clean Architecture
- BLoC
- Dio
- Hive
- GetIt
- GoRouter
- Secure Storage

---

# 👨‍💻 Author

**Abhishek Panchal**

Flutter Developer focused on building scalable, maintainable, and production-ready mobile applications using modern Flutter architecture and best practices.