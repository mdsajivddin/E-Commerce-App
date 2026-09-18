const https = require('https');
const fs = require('fs');

https.get('https://shop-web-kohl.vercel.app/', res => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    console.log('HTML retrieved:', data.length);
    // Find JS asset
    const jsMatch = data.match(/src="(\/assets\/index-[^"]+\.js)"/);
    if (jsMatch) {
      console.log('Fetching JS:', jsMatch[1]);
      https.get('https://shop-web-kohl.vercel.app' + jsMatch[1], jsRes => {
        let jsCode = '';
        jsRes.on('data', c => jsCode += c);
        jsRes.on('end', () => {
          console.log('JS length:', jsCode.length);
          fs.writeFileSync('temp_inspect.js', jsCode);
          analyzeApp(jsCode);
        });
      });
    }
  });
});

function analyzeApp(code) {
  // Check main navigation items in the web app
  // Look for bottom navigation or top navigation links
  const navMatches = code.match(/["'](Home|Shop|Categories|Scan|Wishlist|Cart|Profile|Orders|Explore)["']/g);
  console.log('Nav terms:', [...new Set(navMatches)]);

  // Check how the App layout is structured
  // Search for the Main component or App component
  const views = code.match(/activeTab|currentView|view\s*===/g);
  console.log('Tab/view logic:', views);

  // Search for header buttons and layout
  const headerIdx = code.indexOf('ShopMate');
  console.log('Header context near ShopMate:');
  const idxs = [];
  let pos = 0;
  while ((pos = code.indexOf('ShopMate', pos)) !== -1) {
    idxs.push(pos);
    pos += 8;
  }
  console.log(`Total ShopMate mentions: ${idxs.length}`);
}
