# RealmWriter: Discover, Create, and Rewrite Champion Tales

<p align="center">
  <img src="assets/images/logo/realmwriter_circle_logo.png" alt="RealmWriter Logo" width="150"/>
</p>

A Flutter mobile application that allows League of Legends players to craft, organize, and celebrate their own champion stories. This project was created as an **Endterm Requirement** for the course **Mobile Application Development 1** at **Pangasinan State University - Urdaneta City Campus**.

---

## 📖 About

**RealmWriter** provides League of Legends players a space to express their creativity, passion, and love for the game by crafting and organizing their own champion stories. It allows gamers to document personal experiences, reimagine champion lore, and celebrate memorable moments—turning gameplay memories into a personalized storytelling experience.

While most League of Legends apps focus on skills, builds, and in-game strategies, RealmWriter highlights the other side of the game: **the champions' stories and players' personal experiences**.

---

## ✨ Features

### 🏠 Home Screen & Champion List
- View all your created champions in a visually appealing grid layout
- Pre-loaded sample champions with complete lore stories (Talon, Azir, Ezreal, Garen, Irelia, LeBlanc)
- **Search functionality** to quickly find champions by name
- **Filter by champion type**: Assassin, Fighter, Mage, Marksman, Tank
- **Favorites system** to bookmark your favorite champions

### 📝 Champion Creation
- Create custom champions entirely from your imagination
- Add champion details:
  - **Champion Name**
  - **Champion Type** (Assassin, Fighter, Mage, Marksman, Tank)
  - **Short Bio/Quote**
  - **Full Story/Lore** with a dedicated story editor
  - **Champion Image** (optional) - Pick from gallery or use default
  - **World/Region** association

### 🌍 Worlds & Regions
The app features five pre-loaded League of Legends regions, each with unique descriptions:
- **Noxus** - Empire of ambition and strength
- **Piltover & Zaun** - Twin cities of innovation and chaos
- **Demacia** - Kingdom of honor and tradition
- **Shurima** - Ancient empire risen from the sands
- **Ionia** - Land of balance and spiritual harmony

### 📄 Champion Details Page
- View champion image, name, type, and short bio
- **Tabbed interface** for Story and World information
- Edit or delete champions directly from the details page
- Toggle favorites with a single tap

### ✏️ Edit & Delete
- Edit existing champion information anytime
- Delete champions you no longer need
- Confirmation dialogs to prevent accidental deletions

### 🎨 Onboarding Experience
- Beautiful introduction screens for first-time users
- Smooth page transitions with visual indicators

### 📴 Fully Offline
- No internet connection required
- All data stored locally using SQLite database
- Private and personal—your stories stay on your device

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform mobile framework |
| **Dart** | Programming language |
| **SQLite (sqflite)** | Local database for storing champions and worlds |
| **SharedPreferences** | Storing onboarding state |
| **image_picker** | Selecting images from device gallery |
| **QuickAlert** | Beautiful alert dialogs |
| **introduction_screen** | Onboarding experience |
| **smooth_page_indicator** | Page indicators for onboarding |
| **gap** | Spacing widgets |
| **dotted_border** | Decorative borders for UI elements |

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── helpers/
│   └── dbhelper.dart         # Database operations & pre-populated data
├── models/
│   ├── champion.dart         # Champion data model
│   └── world.dart            # World/Region data model
└── screens/
    ├── listing_page/         # Home screen & champion cards
    ├── onboarding_page/      # Introduction screens
    ├── upload_screen/        # Create/Edit champion screens
    └── responsive_spacing/   # Responsive layout utilities
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.10.1)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/EJ-Molina/RealmWriter-Flutter.git
   ```

2. Navigate to the project directory:
   ```bash
   cd realm_writer
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## 🎯 Target Users

- **Gamers** who enjoy creative expression
- **League of Legends players** passionate about champion lore
- **Creative writers** who want to reimagine game stories
- **Fans** who want to document memorable gameplay experiences

---

## 💡 Novelty & Importance

RealmWriter transforms ordinary note-taking and story-writing apps to bring a creative experience for gamers. It extends the enjoyment of the game beyond playing by letting users:

- Craft champion stories
- Record memorable moments
- Express their passion and love for the game

Unlike other League of Legends apps that focus solely on gameplay improvement, RealmWriter celebrates the **narrative** and **personal connection** players have with their favorite champions.

---


## 👨‍💻 Developer

**EJ Molina**  
Mobile Application Development 1  
Pangasinan State University - Urdaneta City Campus

---

## 📄 License

This project is created for educational purposes as part of academic requirements.

---

<p align="center">
  <i>"Discover, Create, and Rewrite Champion Tales"</i>
</p>
