# Deployment Guide for Rentalyze

## 🚀 CI/CD Pipeline Setup

The project includes automated CI/CD pipelines using GitHub Actions for testing, building, and deploying the application.

### Workflows Overview

1. **CI Pipeline** (`.github/workflows/ci.yml`)
   - Runs on every push and pull request
   - Tests, linting, and security scanning
   - Builds web and Android versions
   - Uploads build artifacts

2. **Deployment Pipeline** (`.github/workflows/deploy.yml`)
   - Deploys to Firebase Hosting on main branch pushes
   - Creates preview deployments for pull requests
   - Automated deployment with zero downtime

## 🔧 Setup Instructions

### 1. Firebase Project Setup

Create a Firebase project for hosting:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init hosting

# Select your Firebase project or create a new one
# Choose "build/web" as your public directory
# Configure as single-page app: Yes
# Set up automatic builds with GitHub: Yes (optional)
```

### 2. GitHub Secrets Configuration

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

```
FIREBASE_TOKEN=your_firebase_ci_token
```

To get your Firebase token:
```bash
firebase login:ci
```

### 3. Custom Domain Setup for datachakra.net/.org

#### Option A: Firebase Hosting with Custom Domain

1. **In Firebase Console:**
   - Go to Hosting section
   - Click "Add custom domain"
   - Enter: `rentalyze.datachakra.net` or `rentalyze.datachakra.org`
   - Follow Firebase's domain verification steps

2. **In Squarespace DNS Settings:**
   ```
   Type: CNAME
   Host: rentalyze
   Points to: rentalyze-app.web.app (or your Firebase hosting URL)
   TTL: Auto
   ```

3. **SSL Certificate:**
   - Firebase automatically provisions SSL certificates
   - Usually takes 24-48 hours to propagate

#### Option B: Squarespace Integration

1. **Build and Download:**
   ```bash
   flutter build web --release
   ```

2. **Upload to Squarespace:**
   - Use Squarespace's developer platform
   - Upload the `build/web` contents to your subdomain

#### Option C: Netlify Deployment (Alternative)

1. **Connect GitHub to Netlify:**
   - Link your repository
   - Set build command: `flutter build web --release`
   - Set publish directory: `build/web`

2. **Configure Custom Domain:**
   - In Netlify: Settings → Domain management
   - Add custom domain: `rentalyze.datachakra.net`
   - Update DNS in Squarespace

### 4. Environment Configuration

Create environment-specific configurations:

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://rentalyze.datachakra.net',
  );
  
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'production',
  );
}
```

## 🌐 Recommended Subdomain Options

For your datachakra.net/.org domains, consider these subdomains:

- `rentalyze.datachakra.net` (Main app)
- `app.datachakra.net/rentalyze` (Under app subdomain)
- `dashboard.datachakra.net` (Alternative name)
- `portfolio.datachakra.net` (Descriptive name)

## 📱 Mobile App Deployment

### Android (Google Play Store)
```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS (App Store)
```bash
# Build iOS release
flutter build ios --release
```

## 🔄 Deployment Process

### Automatic Deployment
1. Push to `main` branch
2. GitHub Actions automatically:
   - Runs tests
   - Builds web app
   - Deploys to Firebase Hosting
   - Updates your custom domain

### Manual Deployment
```bash
# Build web app
flutter build web --release

# Deploy to Firebase
firebase deploy --only hosting

# Deploy with custom message
firebase deploy --only hosting -m "Release v1.0.0"
```

## 📊 Monitoring and Analytics

### Firebase Analytics
- User engagement tracking
- Performance monitoring
- Crash reporting

### Domain Performance
- Monitor SSL certificate status
- Check DNS propagation
- Performance optimization

## 🛠️ Troubleshooting

### Common Issues

1. **Build Failures:**
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

2. **DNS Issues:**
   - Check DNS propagation: `dig rentalyze.datachakra.net`
   - Wait 24-48 hours for full propagation
   - Verify CNAME records in Squarespace

3. **SSL Certificate Issues:**
   - Ensure domain verification is complete
   - Check Firebase Hosting SSL status
   - Contact Firebase support if needed

## 📈 Performance Optimization

### Web Performance
- Enable gzip compression
- Optimize images and assets
- Use service workers for caching
- Monitor Core Web Vitals

### Monitoring Setup
```yaml
# Add to firebase.json
"hosting": {
  "headers": [
    {
      "source": "**/*.@(js|css)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "max-age=31536000"
        }
      ]
    }
  ]
}
```

## 🔗 Useful Links

- [Firebase Hosting Documentation](https://firebase.google.com/docs/hosting)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Squarespace DNS Management](https://support.squarespace.com/hc/en-us/articles/360002101512)

## 📞 Support

For deployment issues:
1. Check GitHub Actions logs
2. Review Firebase console
3. Verify DNS settings
4. Contact support if needed