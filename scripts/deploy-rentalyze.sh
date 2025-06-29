#!/bin/bash

# Rentalyze.app Deployment Script
# This script builds and deploys the Rentalyze app to rentalyze.app

set -e  # Exit on any error

echo "🚀 Starting Rentalyze.app deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are installed
check_dependencies() {
    print_status "Checking dependencies..."
    
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    
    if ! command -v firebase &> /dev/null; then
        print_error "Firebase CLI is not installed. Install with: npm install -g firebase-tools"
        exit 1
    fi
    
    print_success "All dependencies are available"
}

# Clean and get dependencies
prepare_project() {
    print_status "Preparing project..."
    
    flutter clean
    flutter pub get
    
    print_success "Project prepared"
}

# Build the web app
build_web() {
    print_status "Building web app for rentalyze.app..."
    
    flutter config --enable-web
    flutter build web --release --web-renderer html --base-href "https://rentalyze.app/"
    
    if [ $? -eq 0 ]; then
        print_success "Web app built successfully"
    else
        print_error "Failed to build web app"
        exit 1
    fi
}

# Deploy to Firebase
deploy_firebase() {
    print_status "Deploying to Firebase Hosting..."
    
    # Check if user is logged in to Firebase
    if ! firebase projects:list &> /dev/null; then
        print_warning "Not logged in to Firebase. Please run 'firebase login' first."
        exit 1
    fi
    
    # Deploy to Firebase
    firebase deploy --only hosting
    
    if [ $? -eq 0 ]; then
        print_success "Deployed to Firebase Hosting successfully"
    else
        print_error "Failed to deploy to Firebase"
        exit 1
    fi
}

# Verify deployment
verify_deployment() {
    print_status "Verifying deployment..."
    
    # Check if the site is accessible
    if curl -s --head https://rentalyze.app | head -n 1 | grep -q "200 OK"; then
        print_success "Site is accessible at https://rentalyze.app"
    else
        print_warning "Site might not be accessible yet. DNS propagation can take up to 24-48 hours."
    fi
}

# Main deployment process
main() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                     Rentalyze.app Deployment                 ║"
    echo "║              Real Estate Portfolio Management                ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo
    
    check_dependencies
    prepare_project
    build_web
    deploy_firebase
    verify_deployment
    
    echo
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Deployment Complete! 🎉                   ║"
    echo "║                                                              ║"
    echo "║  Your app is now live at: https://rentalyze.app              ║"
    echo "║                                                              ║"
    echo "║  Next steps:                                                 ║"
    echo "║  1. Register the rentalyze.app domain                       ║"
    echo "║  2. Configure DNS to point to Firebase Hosting              ║"
    echo "║  3. Add custom domain in Firebase Console                   ║"
    echo "║  4. Wait for SSL certificate provisioning (24-48 hrs)       ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
}

# Run the main function
main