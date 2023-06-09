# chatter

A small chat server and application designed to be easily self-hostable by
anyone using any free serverless hosting service (e.g., Vercel and Netlify).

## Deploying

You will need a PostgreSQL database instance. We use ElephantSQL for a
free-tier PostgreSQL database instance, but you can use any PostgreSQL
instance you want.

### Netlify

chatter officially supports Netlify out of the box. To deploy to Netlify, simply
click the button below.

[![Deploy to Netlify Button](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/diamondburned/chatter)

## Developing

Before any development, you must have a `.env` or `.envrc` file in the root
directory of the project. This file must contain these environment variables:

```sh
DATABASE_URL="postgres://..."
```

If you're not in my group (you probably aren't), then you will also need
to migrate your database prior to running it:

```sh
npm run prisma-reset-prod
```

**BEWARE** that this will wipe your database and replace it with the
production database. If you're not in my group, you probably don't want to
do this.

### Running

Do

```sh
npm run prisma # only need to run this the first time
npm run dev
```

### Testing

You need `npm run dev` running on one terminal. On the other, do:

```sh
npm run test
```

### Folder Structure

```
- src
  - components/       -- frontend components
  - pages/
    - api/            -- backend api implementation
    - login/
      - +page.svelte  -- login page
    - register/
      - +page.svelte  -- registration page
    - +layout.svelte  -- layout for all pages
    - +page.svelte    -- main app page for chats
```
