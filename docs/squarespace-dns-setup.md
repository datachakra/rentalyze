# 🔧 Squarespace DNS Setup for Virtual rentalyze.app Domain

## 📝 Step-by-Step DNS Configuration

This guide will help you set up the virtual `rentalyze.app` domain using your existing `datachakra.net` domain in Squarespace.

## 🎯 What We're Creating

**User Experience:** When someone types `rentalyze.app` or visits any link, they'll see and experience the Rentalyze app as if it's hosted on its own domain.

**Technical Reality:** The app is actually hosted on `rentalyze.datachakra.net` with clever JavaScript masking.

---

## 🔧 Phase 1: Squarespace DNS Configuration

### Step 1: Access Your Domain Settings

1. **Login to Squarespace:**
   - Go to [squarespace.com](https://squarespace.com)
   - Login to your account
   - Navigate to **Settings** → **Domains**

2. **Select datachakra.net:**
   - Click on `datachakra.net` in your domains list
   - Click **"Manage"** or **"DNS Settings"**

### Step 2: Create the Subdomain

Add this DNS record:

```
Type: CNAME
Host: rentalyze
Points to: rentalyze-app.web.app
TTL: 3600 (1 hour)
```

**Explanation:** This creates `rentalyze.datachakra.net` and points it to your Firebase hosting.

### Step 3: Optional - Create Alternative Subdomains

For additional flexibility, you can also add:

```
Type: CNAME
Host: app
Points to: rentalyze-app.web.app
TTL: 3600

Type: CNAME  
Host: portfolio
Points to: rentalyze-app.web.app
TTL: 3600
```

This gives you multiple entry points:
- `rentalyze.datachakra.net` (primary)
- `app.datachakra.net` (alternative)
- `portfolio.datachakra.net` (descriptive)

---

## 🌐 Phase 2: Firebase Custom Domain Setup

### Step 1: Add Custom Domain in Firebase

1. **Firebase Console:**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Select your Rentalyze project
   - Click **"Hosting"** in the left sidebar

2. **Add Custom Domain:**
   - Click **"Add custom domain"**
   - Enter: `rentalyze.datachakra.net`
   - Click **"Continue"**

3. **Verify Domain:**
   - Firebase will provide verification steps
   - Follow the DNS verification process
   - Wait for verification to complete (can take 24-48 hours)

### Step 2: SSL Certificate

Firebase will automatically provision an SSL certificate for your subdomain. This process typically takes:
- **DNS Propagation:** 24-48 hours
- **SSL Certificate:** Additional 24-48 hours after DNS

---

## 🎭 Phase 3: Domain Masking Strategy

### Option A: JavaScript URL Masking (Implemented)

The `virtual-domain.js` script we created will automatically:
- Detect when users are on `rentalyze.datachakra.net`
- Update meta tags and branding to show `rentalyze.app`
- Handle sharing and navigation seamlessly
- Provide a professional user experience

### Option B: Advanced DNS Forwarding (Optional)

If you want to create an actual redirect from a purchased domain to your subdomain:

1. **Register a Short Domain** (like `rntz.ly` or similar)
2. **Set up URL Forwarding:**
   ```
   Type: URL Redirect
   Source: rntz.ly
   Destination: https://rentalyze.datachakra.net
   Type: 301 Permanent Redirect with Masking
   ```

---

## 📱 Phase 4: Marketing & Social Media Setup

### Update Social Media Profiles

**Bio/Description:**
```
🏠 Real Estate Portfolio Management
📊 Track • Manage • Optimize
🌐 rentalyze.app (powered by DataChakra)
```

**Link in Bio:**
```
https://rentalyze.datachakra.net
```

### Business Cards & Marketing Materials

```
Rentalyze
Real Estate Portfolio Management

🌐 rentalyze.app
📧 hello@datachakra.net
🏢 A DataChakra Product
```

### Email Signatures

```
--
[Your Name]
Real Estate Portfolio Manager

📱 Rentalyze App: rentalyze.app
🌐 DataChakra: datachakra.net
📧 [your-email]@datachakra.net
```

---

## 🔍 Phase 5: Testing & Verification

### DNS Propagation Check

Use these tools to verify your DNS setup:

```bash
# Command line check
dig rentalyze.datachakra.net
nslookup rentalyze.datachakra.net
```

**Online Tools:**
- [DNS Checker](https://dnschecker.org)
- [What's My DNS](https://www.whatsmydns.net)
- [DNS Propagation Checker](https://www.dnswatch.info)

### Testing Checklist

- [ ] `rentalyze.datachakra.net` resolves correctly
- [ ] HTTPS works (SSL certificate active)
- [ ] Virtual domain masking working
- [ ] Social sharing shows correct URLs
- [ ] Mobile app deep linking works
- [ ] Analytics tracking active

---

## 🎨 Phase 6: Branding Customization

### Custom CSS for Virtual Domain

```css
/* Add to your app's CSS */
.virtual-branding {
  --brand-primary: #1976D2;
  --brand-secondary: #FFC107;
  --brand-accent: #4CAF50;
}

.domain-display {
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
  color: var(--brand-primary);
}

.powered-by-indicator {
  opacity: 0.7;
  font-size: 0.8em;
  transition: opacity 0.3s ease;
}

.powered-by-indicator:hover {
  opacity: 1;
}
```

### Logo and Branding

Consider creating:
- **Primary Logo:** "Rentalyze" (standalone)
- **Secondary Logo:** "Rentalyze by DataChakra"
- **Favicon:** R letter or house icon
- **App Icons:** Consistent with virtual domain branding

---

## 📊 Phase 7: Analytics & Performance

### Google Analytics Setup

```javascript
// Track both real and virtual domain performance
gtag('config', 'GA_MEASUREMENT_ID', {
  'custom_map': {
    'dimension1': 'domain_type',
    'dimension2': 'virtual_experience'
  }
});

// Track virtual domain events
gtag('event', 'virtual_domain_usage', {
  'virtual_domain': 'rentalyze.app',
  'real_domain': 'rentalyze.datachakra.net',
  'masking_active': true
});
```

### Performance Monitoring

Monitor these metrics:
- **Load Time:** How fast the virtual domain loads
- **User Experience:** Bounce rate on virtual vs real domain
- **Sharing Effectiveness:** Click-through from social media
- **SEO Performance:** Search engine indexing

---

## 🚀 Phase 8: Go Live Checklist

### Pre-Launch
- [ ] DNS records configured in Squarespace
- [ ] Firebase custom domain verified
- [ ] SSL certificate active
- [ ] Virtual domain script tested
- [ ] Analytics tracking confirmed

### Launch
- [ ] Deploy latest version to Firebase
- [ ] Test all functionality on subdomain
- [ ] Update social media profiles
- [ ] Share launch announcement

### Post-Launch
- [ ] Monitor DNS propagation
- [ ] Check SSL certificate status
- [ ] Verify analytics data
- [ ] Monitor user feedback
- [ ] Optimize performance

---

## 💡 Pro Tips for Virtual Domain Success

### 1. **Consistent Branding**
Always refer to your app as "Rentalyze" and mention "powered by DataChakra" when appropriate.

### 2. **SEO Optimization**
```html
<!-- Use structured data -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebApplication",
  "name": "Rentalyze",
  "url": "https://rentalyze.app",
  "applicationCategory": "BusinessApplication",
  "author": {
    "@type": "Organization", 
    "name": "DataChakra"
  }
}
</script>
```

### 3. **Social Media Strategy**
- Use hashtags: `#Rentalyze #RealEstate #DataChakra`
- Create branded social media graphics
- Share user testimonials and success stories

### 4. **Email Marketing**
```
Subject: Welcome to Rentalyze - Your Real Estate Portfolio Awaits!

Hi [Name],

Welcome to Rentalyze, the ultimate real estate portfolio management platform!

🏠 Get started: rentalyze.app
📊 Track your investments
💰 Optimize your ROI

Built with ❤️ by DataChakra
```

---

## 🔧 Troubleshooting Common Issues

### Issue: DNS Not Propagating
**Solution:**
- Wait 24-48 hours for full propagation
- Clear your DNS cache: `sudo dscacheutil -flushcache` (macOS)
- Try accessing from different networks/devices

### Issue: SSL Certificate Pending  
**Solution:**
- Ensure DNS records are correct
- Wait for full DNS propagation first
- Contact Firebase support if it takes longer than 72 hours

### Issue: Virtual Domain Script Not Working
**Solution:**
- Check browser console for JavaScript errors
- Verify the script is loading correctly
- Test on different browsers and devices

### Issue: Social Sharing Shows Wrong URL
**Solution:**
- Clear social media cache (Facebook Debugger, Twitter Card Validator)
- Update meta tags in index.html
- Test sharing on different platforms

---

## 🎉 Success Metrics

### Traffic Metrics
- **Unique visitors** to rentalyze.datachakra.net
- **Time spent** on the virtual domain
- **Bounce rate** comparison
- **Conversion rates** from virtual domain

### Brand Metrics  
- **Social media mentions** of "rentalyze.app"
- **User feedback** on professional appearance
- **Share rates** of virtual domain links
- **Brand recognition** improvement

### Technical Metrics
- **Page load speed** on virtual domain
- **JavaScript performance** of masking script
- **SSL certificate** uptime
- **DNS resolution** speed

Your virtual `rentalyze.app` domain will provide a professional, branded experience while leveraging your existing `datachakra.net` infrastructure! 🎯✨