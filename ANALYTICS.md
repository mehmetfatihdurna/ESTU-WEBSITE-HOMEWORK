# Vercel Web Analytics Configuration

This document describes the Vercel Web Analytics integration for the ESTU Website.

## Implementation Details

**Type:** Static HTML Website Integration  
**Date Implemented:** April 3, 2026  
**Documentation Source:** https://vercel.com/docs/analytics/quickstart

## What Was Added

Vercel Web Analytics has been integrated into all 7 HTML pages:

1. `index.html` - Home page
2. `academics.html` - Academics page
3. `campuslife.html` - Campus Life page
4. `documents.html` - Documents page
5. `login.html` - Login page
6. `students.html` - Students page
7. `universty.html` - University page

## Integration Method

For static HTML sites, the following script code was added to the `<head>` section of each page:

```html
<script>
    window.va = window.va || function () { (window.vaq = window.vaq || []).push(arguments); };
</script>
<script defer src="/_vercel/insights/script.js"></script>
```

This approach:
- Initializes the Vercel Analytics queue
- Loads the analytics script asynchronously
- Automatically tracks page views
- Works seamlessly with Vercel's deployment infrastructure

## How It Works

When the site is deployed to Vercel:
1. The `/_vercel/insights/script.js` endpoint is automatically served by Vercel
2. Page views are tracked automatically
3. Analytics data appears in the Vercel dashboard after deployment
4. No build step or package installation is required for static HTML sites

## Verification

After deployment, you can verify the integration by:

1. Opening browser DevTools (Network tab)
2. Filtering for XHR/Fetch requests
3. Looking for requests to `/_vercel/insights/` endpoints
4. Checking the Vercel dashboard's Analytics section

## Additional Features

Vercel Web Analytics provides:
- **Automatic page view tracking** - No additional code needed
- **Privacy-focused** - No cookies, GDPR compliant
- **Real-time data** - View traffic as it happens
- **Custom events** (Pro/Enterprise plans) - Track specific user interactions

## Documentation

For more information, visit:
- Quickstart Guide: https://vercel.com/docs/analytics/quickstart
- Analytics Dashboard: Access through your Vercel project settings

## Notes

- Analytics only work when deployed to Vercel
- Local development will not send analytics data
- The script path `/_vercel/insights/script.js` is handled by Vercel's infrastructure
- No package dependencies are required for this static site implementation
