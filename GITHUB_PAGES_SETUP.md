# GitHub Pages Setup Guide

## ✅ Files Created and Pushed

The following legal documents have been created and pushed to your GitHub repository:

1. **Landing Page**: `docs/index.html`
2. **Privacy Policy**: `docs/privacy-policy.html`
3. **Terms & Conditions**: `docs/terms-and-conditions.html`

Repository: `https://github.com/Nurullah-Sadekin/countdown.git`

---

## 🚀 How to Enable GitHub Pages

To make these pages live, follow these steps:

### Step 1: Go to Repository Settings
1. Open your browser and go to: `https://github.com/Nurullah-Sadekin/countdown`
2. Click on **Settings** tab (top right of the repository page)

### Step 2: Navigate to Pages Section
1. In the left sidebar, scroll down and click on **Pages** (under "Code and automation")

### Step 3: Configure GitHub Pages
1. Under **Source**, select **Deploy from a branch**
2. Under **Branch**:
   - Select **main** from the dropdown
   - Select **/docs** from the folder dropdown
   - Click **Save**

### Step 4: Wait for Deployment
1. GitHub will start building your site (this takes 1-2 minutes)
2. Refresh the page after a minute
3. You'll see a message: "Your site is live at https://nurullah-sadekin.github.io/countdown/"

---

## 🌐 Your Live URLs

Once GitHub Pages is enabled, your legal documents will be available at:

### Main Landing Page
```
https://nurullah-sadekin.github.io/countdown/
```

### Privacy Policy
```
https://nurullah-sadekin.github.io/countdown/privacy-policy.html
```

### Terms & Conditions
```
https://nurullah-sadekin.github.io/countdown/terms-and-conditions.html
```

---

## 📱 Using These URLs in Your App

### For Google Play Store
When submitting your app to Google Play Store, you'll need to provide:

1. **Privacy Policy URL**: 
   - Use: `https://nurullah-sadekin.github.io/countdown/privacy-policy.html`
   - This is required in the "Store Presence" > "Privacy Policy" section

2. **Terms & Conditions URL** (optional but recommended):
   - Use: `https://nurullah-sadekin.github.io/countdown/terms-and-conditions.html`

### In Your App Code
You can add links to these pages in your Flutter app:

```dart
// Example: Add to your app's About or Settings screen
const String privacyPolicyUrl = 'https://nurullah-sadekin.github.io/countdown/privacy-policy.html';
const String termsUrl = 'https://nurullah-sadekin.github.io/countdown/terms-and-conditions.html';
```

---

## ✅ Verification Checklist

After enabling GitHub Pages:

- [ ] Visit the main page: `https://nurullah-sadekin.github.io/countdown/`
- [ ] Click on "Privacy Policy" link and verify it loads
- [ ] Click on "Terms & Conditions" link and verify it loads
- [ ] Test all pages on mobile browser
- [ ] Save the URLs for your Play Store submission

---

## 🔄 Updating the Pages

If you need to update these pages in the future:

1. Edit the HTML files in the `docs/` folder
2. Commit the changes: `git add docs/ && git commit -m "Update legal pages"`
3. Push to GitHub: `git push origin main`
4. GitHub Pages will automatically rebuild (takes 1-2 minutes)

---

## 🎨 Customization

The pages use a gradient purple theme matching modern app design. If you want to customize:

1. **Colors**: Edit the CSS in each HTML file (look for `#667eea` and `#764ba2`)
2. **Contact Email**: Update `support@countdowntimer.app` with your actual email
3. **Content**: Modify any text to match your specific needs

---

## 📋 Important Notes

1. **Privacy Policy**: The current policy states that:
   - All data is stored locally on the device
   - No data is collected or transmitted to servers
   - No third-party services are integrated
   - **Update this if you add analytics, ads, or cloud features**

2. **Terms & Conditions**: These are standard terms for a mobile app
   - Review them to ensure they match your app's functionality
   - Consult with a lawyer if you need legal advice

3. **GitHub Pages**: 
   - Pages are public by default
   - Updates take 1-2 minutes to deploy
   - Custom domains can be added if needed

---

## 🆘 Troubleshooting

### Pages Not Loading
- Wait 2-3 minutes after enabling GitHub Pages
- Check that branch is set to "main" and folder to "/docs"
- Verify files are in the `docs/` folder in your repository

### 404 Error
- Ensure file names are exactly: `index.html`, `privacy-policy.html`, `terms-and-conditions.html`
- Check that files were pushed successfully
- Verify the branch and folder settings in GitHub Pages configuration

### Need to Change Repository Name
If you rename your repository, your URLs will change to:
`https://nurullah-sadekin.github.io/[new-repo-name]/`

---

## Date Created
December 31, 2025

---

## Quick Start Command Reference

```bash
# To update legal pages
cd "/Users/nurullahsadekeen/Desktop/Sheba fontend/countdown"
# Edit files in docs/ folder
git add docs/
git commit -m "Update legal documentation"
git push origin main
```

**Your pages are ready to go live! Just enable GitHub Pages in your repository settings.** 🎉

