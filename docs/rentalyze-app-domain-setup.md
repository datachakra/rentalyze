# 🚀 Rentalyze.app Domain Setup Guide

## 🎯 Why rentalyze.app is Perfect

Using `rentalyze.app` instead of a subdomain offers several advantages:
- **Professional Branding**: Clean, memorable URL
- **App Store Alignment**: Perfect for mobile app marketing
- **SEO Benefits**: Direct brand association
- **No Dependency**: Independent of other domains

## 💰 Domain Registration Options & Costs

### Recommended Registrars for .app Domains (2024)

#### 1. **Cloudflare Registrar** (Recommended)
- **Cost**: At-cost pricing (typically $12-15/year)
- **Benefits**: 
  - No markup fees
  - Free SSL certificate
  - Excellent DNS management
  - DDoS protection included
  - Best security features

#### 2. **Namecheap**
- **Cost**: ~$10-13/year (first year often discounted)
- **Benefits**:
  - User-friendly interface
  - Good customer support
  - Free privacy protection

#### 3. **Google Domains** (Now Squarespace)
- **Cost**: ~$12-15/year
- **Benefits**:
  - Integrated with Google services
  - Simple management

#### 4. **GoDaddy**
- **Cost**: ~$15-20/year (higher renewal rates)
- **Benefits**:
  - Wide availability
  - Many additional services

## 🔧 Step-by-Step Setup Process

### Step 1: Check Domain Availability

Visit your preferred registrar and search for `rentalyze.app`:

```bash
# You can also check via command line tools
whois rentalyze.app
```

### Step 2: Register the Domain

**Recommended: Cloudflare Registrar**

1. Go to [Cloudflare Registrar](https://www.cloudflare.com/products/registrar/)
2. Create a Cloudflare account
3. Search for "rentalyze.app"
4. Complete registration (~$12-15/year)
5. Enable Cloudflare services (free tier)

### Step 3: Configure DNS for Firebase Hosting

#### A. In Cloudflare Dashboard:
```
Type: CNAME
Name: @ (or leave blank for root domain)
Target: rentalyze-app.web.app (your Firebase hosting URL)
TTL: Auto

Type: CNAME  
Name: www
Target: rentalyze-app.web.app
TTL: Auto
```

#### B. Alternative DNS Records:
```
Type: A
Name: @
IPv4 address: 199.36.158.100
TTL: Auto

Type: A
Name: @  
IPv4 address: 199.36.158.101
TTL: Auto

Type: CNAME
Name: www
Target: rentalyze.app
TTL: Auto
```

### Step 4: Update Firebase Configuration

Update your Firebase project to use the new domain:

1. **Firebase Console:**
   - Go to Hosting → Add custom domain
   - Enter: `rentalyze.app`
   - Follow verification steps

2. **Update .firebaserc:**
```json
{
  "projects": {
    "default": "rentalyze-app"
  },
  "targets": {
    "rentalyze-app": {
      "hosting": {
        "production": [
          "rentalyze-app"
        ]
      }
    }
  }
}
```

### Step 5: Update Application Configuration

Update your app's configuration files:

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String webUrl = 'https://rentalyze.app';
  static const String apiUrl = 'https://rentalyze.app/api';
  static const String appName = 'Rentalyze';
  static const String domain = 'rentalyze.app';
}
```

## 🌐 DNS Forwarding Smart Hack Options

### Option 1: Cloudflare Universal SSL + Page Rules
```
Page Rule: http://rentalyze.app/*
Settings: Always Use HTTPS
Forward to: https://rentalyze.app/$1
```

### Option 2: Subdomain Strategy (Future Expansion)
```
rentalyze.app           → Main app
api.rentalyze.app       → API endpoints  
admin.rentalyze.app     → Admin dashboard
blog.rentalyze.app      → Blog/marketing
docs.rentalyze.app      → Documentation
```

### Option 3: Redirect Chains (Advanced)
```
www.rentalyze.app       → rentalyze.app
app.rentalyze.app       → rentalyze.app  
portal.rentalyze.app    → rentalyze.app
```

## 🛡️ Security & Performance Setup

### Cloudflare Security Settings:
```
SSL/TLS: Full (Strict)
Security Level: Medium
Browser Integrity Check: ON
Hotlink Protection: ON
```

### Performance Optimization:
```
Caching Level: Standard
Browser Cache TTL: 4 hours
Development Mode: OFF (for production)
Minification: CSS, JS, HTML all ON
```

## 📱 Mobile App Deep Linking Configuration

Update your Flutter app for the new domain:

```yaml
# android/app/src/main/AndroidManifest.xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https"
          android:host="rentalyze.app" />
</intent-filter>
```

```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>rentalyze.app</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
</array>
```

## 📊 Analytics & Monitoring Setup

### Google Analytics Configuration:
```html
<!-- Update web/index.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID', {
    'custom_map': {'dimension1': 'user_type'}
  });
</script>
```

### Firebase Analytics:
```dart
// lib/core/services/analytics_service.dart
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  static Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
  
  static Future<void> logEvent(String name, Map<String, Object> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }
}
```

## 🔄 Migration Checklist

- [ ] Domain availability confirmed
- [ ] Domain registered with preferred registrar
- [ ] Cloudflare account set up (if using)
- [ ] DNS records configured
- [ ] Firebase custom domain added
- [ ] SSL certificate provisioned
- [ ] App configuration updated
- [ ] Mobile deep linking configured
- [ ] Analytics tracking updated
- [ ] Testing completed
- [ ] Documentation updated
- [ ] Team notified of new domain

## 💡 Pro Tips

### 1. **Email Setup**: Consider setting up professional emails
```
hello@rentalyze.app
support@rentalyze.app  
info@rentalyze.app
```

### 2. **Backup Strategy**: Keep your existing domain setup as fallback
```
rentalyze.datachakra.net → redirects to rentalyze.app
```

### 3. **SEO Transition**: Use 301 redirects if migrating from existing domain
```
# In Firebase hosting
"redirects": [
  {
    "source": "**",
    "destination": "https://rentalyze.app",
    "type": 301
  }
]
```

### 4. **Brand Consistency**: Update all marketing materials
- GitHub repository description
- App store listings
- Social media profiles
- Business cards and presentations

## 🎯 Expected Timeline

| Task | Duration | Notes |
|------|----------|--------|
| Domain registration | 5 minutes | Instant if available |
| DNS propagation | 24-48 hours | Global propagation |
| SSL certificate | 24-48 hours | After DNS propagation |
| Firebase setup | 30 minutes | Manual configuration |
| App updates | 1-2 hours | Code changes and testing |
| **Total** | **2-3 days** | Including propagation time |

## 🚀 Going Live

Once everything is configured:

1. **Test the domain**: https://rentalyze.app
2. **Verify SSL**: Check for green lock icon
3. **Test mobile deep links**: Ensure proper app launching
4. **Monitor analytics**: Confirm tracking is working
5. **Share and celebrate**: Your app is live on its own domain! 🎉

## 📞 Support & Troubleshooting

### Common Issues:
- **DNS not propagating**: Wait 24-48 hours, clear DNS cache
- **SSL pending**: Ensure DNS is correct, contact Firebase support
- **Domain not reachable**: Check DNS records and Firebase configuration

### Tools for Testing:
- [DNS Checker](https://dnschecker.org)
- [SSL Labs](https://www.ssllabs.com/ssltest/)
- [Firebase Hosting Status](https://status.firebase.google.com)

Your clean, professional `rentalyze.app` domain will give your real estate portfolio management app the perfect online presence! 🏠✨