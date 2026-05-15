# Filter Try-On

An Android app for AR makeup try-on, powered by the DeepAR SDK. Customers browse and try on virtual makeovers using their phone camera; creators (MUAs) upload and manage their own effects.

---

## Important

Free DeepAR license supports sessions up to 3 minutes. After this time the app needs to be restarted to use the effects. The Galaxy background filter has noticeable latency — this is a known limitation of that specific effect's optimisation, not of the DeepAR integration or the app.

---

## Requirements

### Android

| Property | Value |
|---|---|
| Minimum SDK | **23 (Android 6.0 Marshmallow)** |
| Target / Compile SDK | **36 (Android 16)** |
| Required hardware | Physical camera (front or rear) |
| Supported architectures | arm64-v8a, armeabi-v7a (via DeepAR SDK) |

The app runs on Android 6.0 and above. It will **not** install on devices without a camera (`android.hardware.camera` is marked required in the manifest).

### Development toolchain

| Tool | Version |
|---|---|
| Java | **11** (source and target compatibility) |
| Android Gradle Plugin | **8.13.2** |
| Gradle wrapper | see `gradle/wrapper/gradle-wrapper.properties` |
| DeepAR SDK | **5.6.20** |

### Permissions requested at runtime

| Permission | Reason |
|---|---|
| `CAMERA` | AR camera preview and capture |
| `RECORD_AUDIO` | Video recording with audio |
| `WRITE_EXTERNAL_STORAGE` | Saving screenshots/videos (Android ≤ 12 only) |
| `INTERNET` | API calls and DeepAR license validation |

---

## Backend and file storage

**This repository contains only the Android client.** The backend — the REST API, the database, and the file server — is not included and must be set up separately.

The repo does include three assets to help recreate the backend:

| Folder | Contents | Where it goes |
|---|---|---|
| `dumps/` | MySQL database export | Import into your MySQL server |
| `images/` | Preview images (`.png`) | Upload to your file server |
| `effects/` | DeepAR effect files (`.deepar`) | Upload to your file server |

---

### 1. Database (`dumps/`)

`dumps/Dump20260515.sql` is a full MySQL 8 export of the database. It defines all tables and their relationships:

```
user ──< client          (a user can be a customer)
user ──< mua             (a user can be a creator / MUA)
mua  ──< makeover        (a creator owns makeovers)
makeover ──< images      (a makeover has preview images — filenames only)
makeover ──< makeovertag ──> tag   (many-to-many tags)
client ──< purchase ──> makeover   (purchase history)
client ──< review   ──> makeover   (reviews)
```

The `images.fileName` and `makeover.deeparFile` / `makeover.imagePreview` columns store **filenames only** — not binary data and not full URLs. The actual files live on the file server (see below). The database only records the name so the app can construct the download URL at runtime.

Import the dump into your MySQL server:

```bash
mysql -u <user> -p <database_name> < dumps/Dump20260515.sql
```

The REST API used by this app is **not included** in this repository. You will need to build or host your own API that exposes the endpoints listed in the section below. Update the base URL in `DatabaseManager.java`:

```java
private static final String BASE_URL = "https://<your-api-host>/api/<your-route>/";
```

---

### 2. Preview images (`images/`)

The `images/` folder contains the preview images for the sample makeovers that ship with the app. These files must be hosted on a web-accessible file server at a path the app can download from:

```java
public static final String PREVIEW_URL = "https://<your-file-host>/upload/assets/previews/";
```

The app fetches `PREVIEW_URL + fileName` where `fileName` is the value stored in the database (`makeover.imagePreview` or `images.fileName`). Simply upload all files from `images/` to that directory on your server.

When creators upload new preview images from within the app, the app posts to a PHP upload script:

```
POST https://<your-file-host>/upload_image.php
Content-Type: multipart/form-data
Field name: file
```

You must provide this PHP script. It should save the uploaded file to the previews directory, generate a unique filename to avoid collisions, and return:

```json
{ "status": "success", "filename": "<saved-filename>" }
```

The returned filename is what gets written to the database. On failure, return `{ "status": "error", "message": "..." }`.

---

### 3. DeepAR effects (`effects/`)

The `effects/` folder contains the `.deepar` effect files for the sample makeovers. These are binary files produced by the DeepAR Studio editor. They must be hosted on the same file server at:

```java
public static final String EFFECTS_URL = "https://<your-file-host>/upload/assets/effects/";
```

The app downloads `EFFECTS_URL + deeparFile` on demand (the first time a makeover is tried on) and caches the file in internal storage. Upload all files from `effects/` to that directory on your server.

When creators upload new effect files from within the app, the app posts to a second PHP upload script:

```
POST https://<your-file-host>/upload_deepar.php
Content-Type: multipart/form-data
Field name: file
```

This script works identically to `upload_image.php` — save the file, return a unique filename, same JSON response format. It is a separate endpoint so you can apply different validation (e.g. only accept `.deepar` files) or store effects in a different directory from images.

### API endpoints used

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `check_user/{email}/{hash}` | Authenticate user |
| GET | `check_usertype/{userId}` | Determine customer vs. creator role |
| GET | `get_owned_makeovers/{userId}` | Customer's purchased makeovers |
| GET | `get_shop_items/{userId}` | Shop listing (excludes already owned) |
| GET | `get_creator_makeovers/{userId}` | Creator's uploaded makeovers |
| GET | `get_reviews/{makeoverId}` | Reviews for a makeover |
| GET | `get_creator_reviews/{userId}` | All reviews across a creator's makeovers |
| GET | `get_makeover_tags/{makeoverId}` | Tags on a specific makeover |
| GET | `get_popular_tags` | Tags sorted by usage |
| GET | `get_makeover_images/{makeoverId}` | Secondary preview images |
| GET | `get_latest_makeover_id/{userId}` | ID of most recently created makeover |
| GET | `count_purchase/{makeoverId}` | Purchase/removal count for analytics |
| POST | `add_purchase/{userId}/{makeoverId}` | Purchase a makeover |
| POST | `remove_purchase/{userId}/{makeoverId}` | Remove a purchased makeover |
| POST | `add_review/{makeoverId}/{userId}/{rating}/{comment}` | Leave a review |
| POST | `create_makeover/{userId}/{name}/{price}/{preview}/{effect}` | Create a new makeover |
| POST | `update_makeover/{name}/{price}/{effect}/{preview}/{makeoverId}` | Edit a makeover |
| POST | `add_makeover_tag/{makeoverId}/{tag}` | Add a tag |
| POST | `remove_makeover_tag/{makeoverId}/{tag}` | Remove a tag |
| POST | `clear_makeover_images/{makeoverId}` | Remove all secondary images |
| POST | `add_makeover_image/{fileName}/{makeoverId}` | Link a secondary image |
| GET | `filter_shop.php?clientnb={id}&tags={csv}` | Filtered shop search (PHP script) |

---

## Features

### Customer

- Account creation and login with SHA-256 hashed passwords
- Terms of Use and Privacy Policy acceptance at sign-up
- Home screen showing all owned makeovers with preview images
- AR try-on: apply any owned makeover to live camera feed via DeepAR
- Front and rear camera switching during try-on
- Take a screenshot or record a video with the active makeover applied
- Shop: browse all available makeovers not yet owned
- Filter shop items by one or more tags
- Search makeovers by tag
- Makeover detail card with image gallery, price, and average rating
- Leave a star rating and written review on any owned makeover
- Read all reviews for a makeover
- User profile page

### Creator (MUA)

- Separate home screen listing all uploaded makeovers
- Upload a new makeover: name, price, preview image, additional images, DeepAR effect file, and tags
- Edit an existing makeover's metadata, images, and effect file
- View all customer reviews across all uploaded makeovers
- Analytics dashboard per makeover: purchase count, removal count, average rating, rating distribution chart

### System

- Two distinct user roles: Customer and Creator, resolved at login
- Session persistence across app restarts via SharedPreferences
- DeepAR effect files downloaded on demand and cached in internal storage
- Preview images loaded asynchronously with Glide
- Navigation drawer shared across all screens

---

## Design patterns

1. **Facade / Manager pattern** — `DatabaseManager`, `DeepARManager`, and `CameraManager` each hide a complex subsystem behind a simple interface. Activities never import OkHttp, DeepAR SDK classes, or CameraX — they only call the manager.

2. **Callback / Observer pattern** — Every async operation exposes a typed callback interface: `LoginCallback`, `SimpleCallback`, `APICallback`, `FileCallback`, `DeepARManager.Listener`, `FilterDialogFragment.OnFiltersApplied`.

3. **Template Method pattern** — `DrawerMenu` defines a step (`startDrawer()`) that every subclass must call in `onCreate()`. The base class owns the drawer wiring logic; subclasses just trigger it at the right moment.

4. **Adapter pattern (RecyclerView)** — `MakeoverAdapter` and `ShopAdapter` both implement the standard Android Adapter + ViewHolder pattern, adapting a plain `List<T>` into something RecyclerView can render with view recycling.

5. **Double-buffer pattern** *(from the DeepAR sample project)* — `CameraManager` alternates between two `ByteBuffer`s each frame. While DeepAR processes `buffer[0]`, CameraX writes the next frame into `buffer[1]` and vice versa — a classic producer/consumer double-buffer to avoid frame drops.

---

## Sources and AI usage statement

This project builds upon an example app demonstrating DeepAR SDK usage for Android. The following functionality was taken from the sample:

- Preview of fun face filters
- Take screenshot
- Record video
- Front and back camera support
- Source code demonstrating how to integrate DeepAR for Android

For more information on DeepAR for Android see: https://docs.deepar.ai/deepar-sdk/platforms/android/overview

AI tools were used throughout development to assist mainly with:

- Understanding DeepAR sample code
- Cleaning up unused sample project code
- Suggestions to improve DeepAR performance
- Creating repetitive UI elements
- Debugging persistent issues
- Writing detailed comments
- Explaining documentation
- Recommending best practices for app structure
