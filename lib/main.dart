import 'package:flutter/material.dart';
import 'package:prof_work/DB/JWTDatabase.dart';
import 'package:prof_work/Pages/Desktop_View/login_page.dart';
import 'package:prof_work/Pages/Mobile_View/login_page.dart';
import 'package:prof_work/Pages/Tablet_View/login_page.dart';
import 'package:prof_work/Utils/Responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await JWTDatabase.deleteIsarDB();
  await JWTDatabase.initDB();
  // TODO: use Provider in the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ResponsiveLayout(
        MobileScaffold: const MobileLoginPage(),
        TabletScaffold: const TabletLoginPage(),
        DesktopScaffold: const DesktopLoginPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}













// 1. High-Level Architecture

// Your architecture will need to support:

// Offline data entry: Users can make changes when no internet is available.

// Sync mechanism: Changes are synced with the server when online.

// Durability & reliability: No data loss, even if app crashes or device restarts.

// Cross-platform support: Windows and Android.

// Here’s a conceptual architecture:

// ┌───────────────┐           ┌───────────────┐
// │   Flutter     │  <----->  │  Local DB     │
// │   App (UI)    │           │ (SQLite/Drift)│
// └───────────────┘           └───────────────┘
//          │                           │
//          │ Sync API                  │ Offline Storage
//          │                           │
//          ▼                           ▼
//     ┌───────────────┐         ┌───────────────┐
//     │ Django REST   │         │ Queue/Worker  │
//     │ Framework     │ <-----> │ for sync      │
//     └───────────────┘         └───────────────┘
//          │
//          ▼
//     ┌───────────────┐
//     │ SQL Database  │
//     │ (PostgreSQL   │
//     │  or MySQL)    │
//     └───────────────┘

// 2. Flutter (Frontend) Recommendations

// Since your app must work offline-first:

// Local Database:

// SQLite with Drift (formerly Moor) – works well for structured data, easy queries, strong offline support.

// Alternatively, Hive – key-value, very fast, good for caching.

// State Management:

// Riverpod or Provider – helps in syncing UI state with local DB changes.

// Offline Sync:

// Maintain a queue table in local DB for operations (insert/update/delete).

// Once internet is available, process the queue to sync with the server.

// Connectivity Check:

// Use connectivity_plus package to detect online/offline status.

// Error Handling & Retry:

// Implement exponential backoff for failed sync attempts.

// Background Sync:

// On Android, use WorkManager.

// On Windows, use isolates + periodic timers or background service.

// 3. Backend (Django) Recommendations

// REST API:

// Use Django REST Framework (DRF) for APIs.

// Endpoints must support CRUD with timestamps, e.g., created_at, updated_at, last_modified.

// Conflict Resolution:

// When syncing, the backend must handle conflicts:

// Last-write-wins, or

// Merge strategies if multiple users can edit the same data.

// Authentication & Security:

// JWT Tokens for stateless authentication.

// HTTPS mandatory.

// Optional: refresh tokens to avoid login issues.

// Database:

// PostgreSQL preferred over MySQL for reliability and better concurrency handling.

// Ensure all tables have unique IDs (UUID) to handle offline inserts safely.

// API Design for Syncing:

// Each record should have:

// id (UUID)
// created_at
// updated_at
// is_deleted (for soft delete)
// version (optional, for conflict resolution)


// API endpoints:

// GET /sync?last_synced=<timestamp> → returns updates since last sync

// POST /sync → push local changes to server

// Optional Queue for Scalability:

// Use Celery + Redis to process heavy sync tasks asynchronously.

// 4. Offline-First Sync Strategy

// User adds/updates/deletes a record locally.

// Record is stored in local DB with a sync_status flag.

// When the device is online:

// Flutter app reads unsynced entries.

// Sends them to the server API (POST /sync).

// Server updates database, resolves conflicts, returns latest version.

// Flutter updates local DB with server-confirmed data.

// Tips:

// Use timestamps + UUIDs to avoid duplicate entries.

// Avoid blocking UI during sync → make it background task.

// Log failures for debugging.

// 5. Key Technologies Summary
// Layer	Technology/Library	Why
// Frontend	Flutter + Drift/SQLite	Offline-first, cross-platform
// State mgmt	Riverpod / Provider	Reactive UI updates
// Sync	Connectivity_plus, WorkManager	Detect online, background sync
// Backend	Django REST Framework	API support
// DB	PostgreSQL	ACID, reliability, UUID support
// Async	Celery + Redis	Heavy tasks, scalable sync
// Auth	JWT Tokens	Stateless, secure
// 6. Things You Must Not Forget

// Offline support is not just UI – everything must work without network.

// Conflict resolution – think about edge cases.

// Background sync – do not block the UI.

// Durability – commit to local DB first before sending to server.

// Logging – log sync failures, retries, and errors.

// Versioning – API versioning to avoid breaking clients.

// Testing on weak/no internet – simulate offline scenarios.

// Data size considerations – don’t download too much at once.

// Encryption – sensitive data must be encrypted locally and in transit.