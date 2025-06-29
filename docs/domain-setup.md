# Custom Domain Setup Guide

## 🌐 Setting up rentalyze.datachakra.net

This guide walks you through connecting your Rentalyze app to a custom subdomain using your existing datachakra.net/.org domains from Squarespace.

## 📋 Prerequisites

- Access to your Squarespace account
- Firebase project set up for Rentalyze
- GitHub repository with CI/CD configured

## 🔧 Step-by-Step Setup

### Step 1: Firebase Hosting Configuration

1. **Access Firebase Console:**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Select your Rentalyze project
   - Navigate to "Hosting" in the left sidebar

2. **Add Custom Domain:**
   - Click "Add custom domain"
   - Enter your chosen subdomain: `rentalyze.datachakra.net`
   - Click "Continue"

3. **Domain Verification:**
   - Firebase will provide verification steps
   - You'll get DNS records to add to Squarespace

### Step 2: Squarespace DNS Configuration

1. **Access DNS Settings:**
   - Log into your Squarespace account
   - Go to Settings → Domains
   - Find datachakra.net and click "Manage"
   - Click "DNS Settings"

2. **Add CNAME Record:**
   ```
   Type: CNAME
   Host: rentalyze
   Points to: [Firebase hosting URL from step 1]
   TTL: 3600 (or Auto)
   ```

3. **Verification Record (if required):**
   ```
   Type: TXT
   Host: rentalyze
   Value: [Verification string from Firebase]
   TTL: 3600
   ```

### Step 3: SSL Certificate Setup

Firebase automatically provisions SSL certificates for custom domains:

- **Timeline:** 24-48 hours for full activation
- **Status:** Check in Firebase Console → Hosting → Domains
- **Troubleshooting:** Ensure DNS records are correct

### Step 4: Update Application Configuration

Update your app's base URL configuration:

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String webUrl = 'https://rentalyze.datachakra.net';
  static const String apiUrl = 'https://rentalyze.datachakra.net/api';
}
```

## 🎯 Recommended Subdomain Options

### Primary Recommendation: `rentalyze.datachakra.net`
- **Pros:** Clear, brandable, easy to remember
- **URL:** https://rentalyze.datachakra.net
- **Marketing:** Easy to promote and share

### Alternative Options:

1. **`app.datachakra.net`**
   - Generic app subdomain
   - Future-proof for other applications
   - URL: https://app.datachakra.net

2. **`dashboard.datachakra.net`**
   - Emphasizes the dashboard nature
   - Professional sounding
   - URL: https://dashboard.datachakra.net

3. **`portfolio.datachakra.net`**
   - Descriptive of the app's purpose
   - SEO-friendly
   - URL: https://portfolio.datachakra.net

## 🔄 DNS Propagation and Testing

### Check DNS Propagation:
```bash
# Check CNAME record
dig rentalyze.datachakra.net CNAME

# Check from multiple locations
nslookup rentalyze.datachakra.net 8.8.8.8
```

### Online Tools:
- [DNS Checker](https://dnschecker.org)
- [What's My DNS](https://www.whatsmydns.net)
- [DNS Propagation Checker](https://www.dnswatch.info)

## 📱 Mobile App Deep Linking

Configure deep linking for mobile apps to work with your custom domain:

```dart
// pubspec.yaml
flutter:
  assets:
    - assets/
  deep_linking:
    - scheme: https
      host: rentalyze.datachakra.net
```

## 🛡️ Security Considerations

### HTTPS Enforcement:
```json
// firebase.json
{
  "hosting": {
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**",
        "headers": [
          {
            "key": "Strict-Transport-Security",
            "value": "max-age=31536000; includeSubDomains; preload"
          }
        ]
      }
    ]
  }
}
```

### Content Security Policy:
```html
<!-- In web/index.html -->
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; 
               script-src 'self' 'unsafe-inline' 'unsafe-eval' https://apis.google.com; 
               style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
               font-src 'self' https://fonts.gstatic.com;">
```

## 📊 Analytics and Monitoring

### Google Analytics Setup:
```html
<!-- In web/index.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### Firebase Analytics:
```dart
// lib/core/services/analytics_service.dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }
}
```

## 🔧 Troubleshooting Common Issues

### Issue 1: DNS Not Propagating
**Solution:**
- Wait 24-48 hours
- Clear DNS cache: `sudo dscacheutil -flushcache` (macOS)
- Try different DNS servers

### Issue 2: SSL Certificate Pending
**Solution:**
- Verify DNS records are correct
- Wait for full DNS propagation
- Check Firebase Console status

### Issue 3: 404 Errors on Direct URLs
**Solution:**
- Ensure rewrites are configured in firebase.json
- Check that build/web/index.html exists
- Verify routing configuration

## 📋 Final Checklist

- [ ] Firebase project created and configured
- [ ] Custom domain added in Firebase Console
- [ ] CNAME record added in Squarespace DNS
- [ ] TXT verification record added (if required)
- [ ] DNS propagation confirmed (24-48 hours)
- [ ] SSL certificate active
- [ ] App configuration updated with new domain
- [ ] Deep linking configured
- [ ] Analytics tracking set up
- [ ] Security headers configured
- [ ] Testing completed on all devices

## 🎉 Go Live

Once everything is configured:

1. **Push to Main Branch:**
   ```bash
   git add .
   git commit -m "feat: configure custom domain and deployment"
   git push origin main
   ```

2. **Monitor Deployment:**
   - Check GitHub Actions
   - Verify Firebase deployment
   - Test the live site

3. **Share Your App:**
   - **Primary URL:** https://rentalyze.datachakra.net
   - **QR Code:** Generate for easy mobile access
   - **Social Media:** Share with your network

## 📞 Support Resources

- **Firebase Support:** https://support.google.com/firebase
- **Squarespace DNS Help:** https://support.squarespace.com/hc/en-us/articles/360002101512
- **GitHub Actions:** https://docs.github.com/en/actions
- **Flutter Web:** https://docs.flutter.dev/deployment/web