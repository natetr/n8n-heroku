#!/usr/bin/env node

const puppeteer = require('puppeteer');

(async () => {
  try {
    const url = process.argv[2];
    if (!url) {
      console.error("No URL provided");
      process.exit(1);
    }

    // Launch Puppeteer with the typical headless flags.
    // Remember to add --no-sandbox, especially on Heroku/Alpine.
    const browser = await puppeteer.launch({
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
      ],
      headless: 'new' // or `true` if your puppeteer version doesn't use 'new'
    });

    const page = await browser.newPage();
    await page.goto(url, { waitUntil: 'networkidle0' });

    // For a basic approach, just extract page text:
    const content = await page.evaluate(() => document.body.innerText);

    console.log(content);

    await browser.close();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();
