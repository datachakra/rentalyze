/**
 * Virtual Domain Masking for Rentalyze
 * Creates the illusion of rentalyze.io while using datachakra.net infrastructure
 */

class VirtualDomainManager {
  constructor() {
    this.virtualDomain = 'rentalyze.io';
    this.realDomain = 'datachakra.net';
    this.subdomain = 'rentalyze.datachakra.net';
    this.init();
  }

  init() {
    // Only run on the actual subdomain
    if (window.location.hostname === 'rentalyze.datachakra.net') {
      this.setupVirtualDomain();
      this.updateBranding();
      this.handleNavigation();
      this.setupSharing();
      this.trackAnalytics();
    }
  }

  setupVirtualDomain() {
    // Update the page title and meta tags
    document.title = document.title.replace('rentalyze', 'Rentalyze');
    
    // Update canonical URL
    let canonical = document.querySelector('link[rel="canonical"]');
    if (canonical) {
      canonical.href = canonical.href.replace(this.subdomain, this.virtualDomain);
    }

    // Update Open Graph tags
    this.updateMetaTag('property', 'og:url', this.virtualDomain);
    this.updateMetaTag('property', 'og:site_name', 'Rentalyze');
    
    // Update Twitter Card tags
    this.updateMetaTag('name', 'twitter:domain', this.virtualDomain);
    
    console.log('🎭 Virtual domain masking active: ' + this.virtualDomain);
  }

  updateMetaTag(attribute, value, replacement) {
    const meta = document.querySelector(`meta[${attribute}="${value}"]`);
    if (meta) {
      meta.content = meta.content.replace(this.subdomain, this.virtualDomain);
    }
  }

  updateBranding() {
    // Update any visible domain references
    document.addEventListener('DOMContentLoaded', () => {
      // Replace domain text in elements with data-domain attribute
      document.querySelectorAll('[data-domain]').forEach(el => {
        el.textContent = el.textContent.replace(this.subdomain, this.virtualDomain);
      });

      // Add virtual domain indicator to footer
      this.addVirtualDomainIndicator();
    });
  }

  addVirtualDomainIndicator() {
    // Add a subtle indicator that this is powered by DataChakra
    const indicator = document.createElement('div');
    indicator.innerHTML = `
      <style>
        .virtual-domain-indicator {
          position: fixed;
          bottom: 10px;
          right: 10px;
          background: rgba(0,0,0,0.8);
          color: white;
          padding: 5px 10px;
          border-radius: 15px;
          font-size: 11px;
          z-index: 1000;
          opacity: 0.7;
          transition: opacity 0.3s;
        }
        .virtual-domain-indicator:hover {
          opacity: 1;
        }
        .virtual-domain-indicator a {
          color: #4FC3F7;
          text-decoration: none;
        }
      </style>
      <div class="virtual-domain-indicator">
        Powered by <a href="https://datachakra.net" target="_blank">DataChakra</a>
      </div>
    `;
    document.body.appendChild(indicator);
  }

  handleNavigation() {
    // Intercept navigation to maintain virtual domain experience
    document.addEventListener('click', (e) => {
      const link = e.target.closest('a');
      if (link && link.hostname === this.subdomain) {
        // Update href to show virtual domain
        const virtualHref = link.href.replace(this.subdomain, this.virtualDomain);
        link.setAttribute('data-virtual-href', virtualHref);
      }
    });

    // Handle form submissions
    document.addEventListener('submit', (e) => {
      const form = e.target;
      if (form.action && form.action.includes(this.subdomain)) {
        // Maintain virtual domain in form actions
        console.log('📝 Form submission maintaining virtual domain context');
      }
    });
  }

  setupSharing() {
    // Custom sharing function that uses virtual domain
    window.shareRentalyze = () => {
      const shareData = {
        title: 'Rentalyze - Real Estate Portfolio Management',
        text: 'Check out Rentalyze - the ultimate real estate portfolio management app!',
        url: `https://${this.virtualDomain}`
      };

      if (navigator.share) {
        navigator.share(shareData);
      } else {
        // Fallback sharing
        this.fallbackShare(shareData);
      }
    };
  }

  fallbackShare(shareData) {
    const shareText = `${shareData.text}\n${shareData.url}`;
    
    // Try to copy to clipboard
    if (navigator.clipboard) {
      navigator.clipboard.writeText(shareText).then(() => {
        this.showNotification('Share link copied to clipboard!');
      });
    } else {
      // Show share modal
      this.showShareModal(shareData);
    }
  }

  showShareModal(shareData) {
    const modal = document.createElement('div');
    modal.innerHTML = `
      <style>
        .share-modal {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(0,0,0,0.8);
          display: flex;
          justify-content: center;
          align-items: center;
          z-index: 10000;
        }
        .share-content {
          background: white;
          padding: 30px;
          border-radius: 10px;
          max-width: 400px;
          text-align: center;
        }
        .share-url {
          background: #f5f5f5;
          padding: 10px;
          border-radius: 5px;
          margin: 15px 0;
          word-break: break-all;
        }
        .share-buttons button {
          margin: 5px;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
        }
        .close-btn {
          background: #f44336;
          color: white;
        }
        .copy-btn {
          background: #2196F3;
          color: white;
        }
      </style>
      <div class="share-modal" onclick="this.remove()">
        <div class="share-content" onclick="event.stopPropagation()">
          <h3>Share Rentalyze</h3>
          <p>${shareData.text}</p>
          <div class="share-url">${shareData.url}</div>
          <div class="share-buttons">
            <button class="copy-btn" onclick="navigator.clipboard.writeText('${shareData.url}'); this.textContent='Copied!'; setTimeout(() => this.closest('.share-modal').remove(), 1000)">Copy Link</button>
            <button class="close-btn" onclick="this.closest('.share-modal').remove()">Close</button>
          </div>
        </div>
      </div>
    `;
    document.body.appendChild(modal);
  }

  showNotification(message) {
    const notification = document.createElement('div');
    notification.innerHTML = `
      <style>
        .virtual-notification {
          position: fixed;
          top: 20px;
          right: 20px;
          background: #4CAF50;
          color: white;
          padding: 15px 20px;
          border-radius: 5px;
          z-index: 10000;
          animation: slideIn 0.3s ease-out;
        }
        @keyframes slideIn {
          from { transform: translateX(100%); }
          to { transform: translateX(0); }
        }
      </style>
      <div class="virtual-notification">${message}</div>
    `;
    document.body.appendChild(notification);
    
    setTimeout(() => notification.remove(), 3000);
  }

  trackAnalytics() {
    // Track virtual domain usage
    if (typeof gtag !== 'undefined') {
      gtag('event', 'virtual_domain_visit', {
        'virtual_domain': this.virtualDomain,
        'real_domain': this.subdomain,
        'page_path': window.location.pathname,
        'user_agent': navigator.userAgent
      });
    }

    // Track virtual domain performance
    window.addEventListener('load', () => {
      const loadTime = performance.now();
      console.log(`🚀 Virtual domain loaded in ${loadTime.toFixed(2)}ms`);
      
      if (typeof gtag !== 'undefined') {
        gtag('event', 'virtual_domain_performance', {
          'load_time': Math.round(loadTime),
          'domain_type': 'virtual'
        });
      }
    });
  }
}

// Initialize virtual domain management
document.addEventListener('DOMContentLoaded', () => {
  window.virtualDomain = new VirtualDomainManager();
});

// Export for external use
window.VirtualDomainManager = VirtualDomainManager;