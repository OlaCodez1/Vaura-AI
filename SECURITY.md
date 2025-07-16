# Security Policy

## Supported Versions

We currently support the latest version deployed to `gh-pages`.

| Version | Supported |
|---------|-----------|
| Latest  | ✅         |

---

## 🔐 Reporting a Vulnerability

If you discover a security vulnerability in this project, **please do not create a public issue**.

Instead, report it **privately** by emailing:

**📩 olacodez1@proton.me**

We will respond within 48 hours and take necessary action.

---

## 🔒 Security Practices

This project follows the following security measures:

- ✅ **Firebase Authentication** with Google and Email/Password
- ✅ API keys are **public client-side keys** (safe with proper Firebase rules)
- ✅ Only authenticated users can access protected resources
- ✅ GitHub Pages branch (`gh-pages`) is for static UI only
- ✅ No private tokens or backend secrets are committed

---

## ⚠️ Firebase Rules

All Firebase backend access is governed by these security rules:

```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```
