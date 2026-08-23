---
name: job-search
description: Search for job postings on LinkedIn, Indeed, and other boards with firecrawl, and summarize matching roles. Use when the user asks to find jobs, check postings, compare roles, or prepare for applications.
---

# Job Search

Search job boards with firecrawl and summarize the results. This skill works with the Firecrawl MCP tools. It does not apply to jobs.

## When to use

Use this skill when the user asks any of these:

- Find job postings for a role or stack.
- Check a specific posting or company.
- Gather salary, requirements, or stack details for a role.
- Prepare for an application or tailor a resume (see atsmodify if present).

## Procedure

Follow these steps in order.

### 1. Build the search query

Use the user's role, stack, and location. Examples:

- `junior software engineer jobs in austin tx`
- `next.js react developer remote jobs`

If the user gives a location or salary range, put it in the query. If not, ask for a location. If the user does not know, use their profile or omit the location. Do not guess a location.

### 2. Run one search per board

Call `firecrawl_search` once per board. Use `includeDomains` with one domain per call:

- `["www.linkedin.com"]` for LinkedIn.
- `["www.indeed.com"]` for Indeed.
- `["www.builtinnyc.com"]`, `["www.greenhouse.io"]`, or `["www.lever.co"]` for other boards.

Rules:

- Use `www.` in the domain. Without it, results come back empty.
- One domain per call. Multiple domains in one call return nothing.
- Use `limit: 5` or lower to save credits.

### 3. Verify the results returned pages

If `data.web` is empty or the call fails, do both:

- Re-run the search without `includeDomains`.
- Confirm you used `www.` in the domain.

Retry once before you report failure.

### 4. Scrape the top postings

For the top 3 postings, call `firecrawl_scrape` on the posting URL:

- Use `formats: ["markdown"]`.
- Use `onlyMainContent: true` to drop page chrome.
- Do not scrape more than 3 postings per request. This saves credits.

Some postings block scrapers, especially LinkedIn job view pages. If a scrape fails, use the search result description instead. Note the limitation in your summary.

### 5. Summarize

Report the results in a compact list. For each posting, include:

- Title and company.
- Location and work mode (remote, hybrid, on-site).
- Salary range, when present.
- Key requirements and stack.
- The posting URL.

Keep the summary short. Do not invent salary or requirement data. If a run used many credits, note the remaining budget.

### 6. Offer next steps

Offer to do one of these:

- Tailor the user's resume to a posting (use atsmodify when available).
- Prepare questions or talking points for an application.
- Watch the board for new postings.

## Credits

The keyless Firecrawl tier allows 1000 credits per month. One search costs about 2 credits. One scrape costs about 1-2 credits. Keep runs small. Warn the user when searches are large or repeated.