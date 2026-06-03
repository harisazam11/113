# Contributing Guideline

Thank you for considering contributing to this project 🎉
We welcome contributions from everyone (students, developers, and open-source enthusiasts).

---

## How to Contribute

### 1. Fork the Repository

Click the **Fork** button on the top right of the repository page.

### 2. Clone Your Fork

```bash
git clone https://github.com/your-username/BUITEMS_lost_found_app.git
cd BUITEMS_lost_found_app
```

### 3. Create a New Branch

Always create a new branch for your changes:

```bash
git checkout -b feature/your-feature-name
```

Examples:

* `feature/add-dark-mode`
* `fix/login-bug`
* `feature/improve-ui`

---

### 4. Install Dependencies

Make sure Flutter is installed, then run:

```bash
flutter pub get
```

---

### 5. Make Your Changes

* Follow existing project structure
* Keep code clean and readable
* Avoid unnecessary changes to unrelated files

---

### 6. Test Your Changes

Before committing:

```bash
flutter analyze
flutter run
```

---

### 7. Commit Your Changes

Use clear commit messages:

```bash
git commit -m "Add: dark mode support in settings screen"
```

Commit message guidelines:

* `Add:` for new features
* `Fix:` for bug fixes
* `Update:` for improvements
* `Remove:` for deletions

---

### 8. Push Your Branch

```bash
git push origin feature/your-feature-name
```

---

### 9. Open a Pull Request

Go to the original repository and open a Pull Request.

Please include:

* What you changed
* Why you changed it
* Screenshots (if UI is affected)

---

## Code Guidelines

* Follow Dart & Flutter best practices
* Keep widgets modular and reusable
* Avoid hardcoding values (use constants where possible)
* Keep UI consistent with existing design

---

## Testing Guidelines

If your contribution affects functionality:

* Test on Android (required)
* Test on Web (if applicable)
* Ensure no Firebase errors in console

---

## Reporting Issues

If you find bugs or want to suggest features:

* Open an issue in the Issues tab
* Clearly describe the problem or suggestion
* Add screenshots/logs if possible

---

## Suggestions for Contributions

You can contribute by:

* Improving UI/UX
* Fixing bugs
* Adding new features
* Improving documentation
* Optimizing Firebase usage

---

## Thank You

Your contributions help improve this project for all BUITEMS students.
Every contribution, big or small, is appreciated.
