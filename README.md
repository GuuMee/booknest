# booknest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
booknest
├─ .metadata
├─ analysis_options.yaml
├─ android
│  ├─ app
│  │  ├─ build.gradle.kts
│  │  └─ src
│  │     ├─ debug
│  │     │  └─ AndroidManifest.xml
│  │     ├─ main
│  │     │  ├─ AndroidManifest.xml
│  │     │  ├─ java
│  │     │  │  └─ io
│  │     │  │     └─ flutter
│  │     │  │        └─ plugins
│  │     │  │           └─ GeneratedPluginRegistrant.java
│  │     │  ├─ kotlin
│  │     │  │  └─ com
│  │     │  │     └─ book
│  │     │  │        └─ booknest
│  │     │  │           └─ MainActivity.kt
│  │     │  └─ res
│  │     │     ├─ drawable
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable-v21
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ mipmap-hdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-mdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ values
│  │     │     │  └─ styles.xml
│  │     │     └─ values-night
│  │     │        └─ styles.xml
│  │     └─ profile
│  │        └─ AndroidManifest.xml
│  ├─ build.gradle.kts
│  ├─ gradle
│  │  └─ wrapper
│  │     ├─ gradle-wrapper.jar
│  │     └─ gradle-wrapper.properties
│  ├─ gradle.properties
│  ├─ gradlew
│  ├─ gradlew.bat
│  ├─ local.properties
│  └─ settings.gradle.kts
├─ ios
│  ├─ Flutter
│  │  ├─ AppFrameworkInfo.plist
│  │  ├─ Debug.xcconfig
│  │  ├─ ephemeral
│  │  │  ├─ flutter_lldbinit
│  │  │  └─ flutter_lldb_helper.py
│  │  ├─ flutter_export_environment.sh
│  │  ├─ Generated.xcconfig
│  │  └─ Release.xcconfig
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  ├─ AppIcon.appiconset
│  │  │  │  ├─ Contents.json
│  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │  └─ LaunchImage.imageset
│  │  │     ├─ Contents.json
│  │  │     ├─ LaunchImage.png
│  │  │     ├─ LaunchImage@2x.png
│  │  │     ├─ LaunchImage@3x.png
│  │  │     └─ README.md
│  │  ├─ Base.lproj
│  │  │  ├─ LaunchScreen.storyboard
│  │  │  └─ Main.storyboard
│  │  ├─ GeneratedPluginRegistrant.h
│  │  ├─ GeneratedPluginRegistrant.m
│  │  ├─ Info.plist
│  │  ├─ Runner-Bridging-Header.h
│  │  └─ SceneDelegate.swift
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  ├─ contents.xcworkspacedata
│  │  │  └─ xcshareddata
│  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     └─ WorkspaceSettings.xcsettings
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  ├─ Runner.xcworkspace
│  │  ├─ contents.xcworkspacedata
│  │  └─ xcshareddata
│  │     ├─ IDEWorkspaceChecks.plist
│  │     └─ WorkspaceSettings.xcsettings
│  └─ RunnerTests
│     └─ RunnerTests.swift
├─ lib
│  ├─ config
│  │  ├─ app.dart
│  │  ├─ constants
│  │  │  ├─ api_constants.dart
│  │  │  ├─ app_strings.dart
│  │  │  └─ asset_paths.dart
│  │  ├─ routes
│  │  │  ├─ app_router.dart
│  │  │  └─ route_names.dart
│  │  └─ theme
│  │     ├─ app_colors.dart
│  │     ├─ app_theme.dart
│  │     ├─ app_typography.dart
│  │     ├─ dark_theme.dart
│  │     └─ reading_theme_colors.dart
│  ├─ core
│  │  ├─ constants
│  │  ├─ di
│  │  │  ├─ injection.dart
│  │  │  └─ injection_container.dart
│  │  ├─ enums
│  │  ├─ errors
│  │  │  ├─ exceptions.dart
│  │  │  └─ failures.dart
│  │  ├─ extensions
│  │  │  └─ string_extensions.dart
│  │  ├─ network
│  │  │  ├─ api_client.dart
│  │  │  ├─ api_interceptor.dart
│  │  │  └─ network_info.dart
│  │  ├─ usecases
│  │  │  └─ usecase.dart
│  │  └─ utils
│  │     ├─ date_formatter.dart
│  │     ├─ pdf_helper.dart
│  │     ├─ responsive_helper.dart
│  │     └─ validators.dart
│  ├─ data
│  │  ├─ datasources
│  │  │  ├─ local
│  │  │  │  ├─ book_local_source.dart
│  │  │  │  ├─ cache_manager.dart
│  │  │  │  └─ user_local_source.dart
│  │  │  └─ remote
│  │  │     ├─ auth_remote_source.dart
│  │  │     ├─ book_remote_source.dart
│  │  │     └─ subscription_remote_source.dart
│  │  ├─ enums
│  │  │  └─ download_status.dart
│  │  ├─ models
│  │  │  ├─ achievement.dart
│  │  │  ├─ annotation_model.dart
│  │  │  ├─ app_settings.dart
│  │  │  ├─ bookmark_model.dart
│  │  │  ├─ book_model.dart
│  │  │  ├─ category_model.dart
│  │  │  ├─ chapter.dart
│  │  │  ├─ collection_model.dart
│  │  │  ├─ currently_reading_model.dart
│  │  │  ├─ daily_reading.dart
│  │  │  ├─ downloaded_book.dart
│  │  │  ├─ download_progress.dart
│  │  │  ├─ genre_breakdown.dart
│  │  │  ├─ notification_model.dart
│  │  │  ├─ reading_progress.dart
│  │  │  ├─ reading_progress_model.dart
│  │  │  ├─ reading_session.dart
│  │  │  ├─ reading_stats.dart
│  │  │  ├─ review.dart
│  │  │  ├─ review_model.dart
│  │  │  ├─ search_filters.dart
│  │  │  ├─ search_result.dart
│  │  │  ├─ subscription_model.dart
│  │  │  └─ user_model.dart
│  │  ├─ providers
│  │  │  └─ storage_provider.dart
│  │  └─ repositories
│  │     ├─ achievement_repository.dart
│  │     ├─ auth_repository_impl.dart
│  │     ├─ bookmark_repository.dart
│  │     ├─ book_repository_impl.dart
│  │     ├─ reading_progress_repository.dart
│  │     ├─ review_repository.dart
│  │     ├─ search_repository.dart
│  │     ├─ settings_repository.dart
│  │     ├─ stats_repository.dart
│  │     ├─ subscription_repository_impl.dart
│  │     └─ user_repository_impl.dart
│  ├─ di
│  │  └─ injection_container.dart
│  ├─ domain
│  │  ├─ entities
│  │  │  ├─ book.dart
│  │  │  ├─ reading_progress.dart
│  │  │  ├─ subscription.dart
│  │  │  └─ user.dart
│  │  ├─ repositories
│  │  │  ├─ auth_repository.dart
│  │  │  ├─ book_repository.dart
│  │  │  ├─ book_repository_impl.dart
│  │  │  ├─ search_repository.dart
│  │  │  ├─ subscription_repository.dart
│  │  │  └─ user_repository.dart
│  │  └─ usecases
│  │     ├─ download_book.dart
│  │     ├─ get_books.dart
│  │     ├─ manage_subscription.dart
│  │     ├─ search_books.dart
│  │     ├─ toggle_favorite.dart
│  │     └─ update_reading_progress.dart
│  ├─ main.dart
│  ├─ presentation
│  │  ├─ bloc
│  │  │  ├─ auth
│  │  │  │  ├─ auth_bloc.dart
│  │  │  │  ├─ auth_event.dart
│  │  │  │  └─ auth_state.dart
│  │  │  ├─ books
│  │  │  │  ├─ books_bloc.dart
│  │  │  │  ├─ books_event.dart
│  │  │  │  └─ books_state.dart
│  │  │  ├─ book_detail
│  │  │  │  └─ book_detail_bloc.dart
│  │  │  ├─ downloads
│  │  │  │  └─ downloads_bloc.dart
│  │  │  ├─ reader
│  │  │  │  ├─ reader_bloc.dart
│  │  │  │  ├─ reader_event.dart
│  │  │  │  └─ reader_state.dart
│  │  │  ├─ reviews
│  │  │  │  └─ reviews_bloc.dart
│  │  │  ├─ search
│  │  │  │  └─ search_bloc.dart
│  │  │  ├─ settings
│  │  │  │  └─ settings_bloc.dart
│  │  │  ├─ stats
│  │  │  │  ├─ stats_bloc.dart
│  │  │  │  ├─ stats_event.dart
│  │  │  │  └─ stats_state.dart
│  │  │  ├─ subscription
│  │  │  │  ├─ subscription_bloc.dart
│  │  │  │  ├─ subscription_event.dart
│  │  │  │  └─ subscription_state.dart
│  │  │  └─ theme
│  │  │     └─ theme_bloc.dart
│  │  ├─ screens
│  │  │  ├─ auth
│  │  │  │  ├─ forgot_password_screen.dart
│  │  │  │  ├─ login_screen.dart
│  │  │  │  ├─ register_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ auth_form_field.dart
│  │  │  │     └─ social_login_buttons.dart
│  │  │  ├─ book_detail
│  │  │  │  ├─ book_detail_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ book_cover_hero.dart
│  │  │  │     ├─ book_info_section.dart
│  │  │  │     ├─ rating_widget.dart
│  │  │  │     ├─ review_section.dart
│  │  │  │     └─ similar_books.dart
│  │  │  ├─ downloads
│  │  │  │  └─ downloads_screen.dart
│  │  │  ├─ error
│  │  │  │  └─ not_found_screen.dart
│  │  │  ├─ explore
│  │  │  │  ├─ explore_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ book_grid_item.dart
│  │  │  │     ├─ book_list_item.dart
│  │  │  │     ├─ filter_bottom_sheet.dart
│  │  │  │     └─ search_bar_widget.dart
│  │  │  ├─ home
│  │  │  │  ├─ home_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ category_chips.dart
│  │  │  │     ├─ continue_reading_card.dart
│  │  │  │     ├─ greeting_header.dart
│  │  │  │     ├─ new_arrivals_section.dart
│  │  │  │     ├─ recommended_section.dart
│  │  │  │     └─ trending_books_carousel.dart
│  │  │  ├─ kids_mode
│  │  │  │  ├─ kids_home_screen.dart
│  │  │  │  ├─ kids_pin_screen.dart
│  │  │  │  ├─ kids_reader_screen.dart
│  │  │  │  ├─ kids_rewards_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ animated_book_card.dart
│  │  │  │     ├─ fun_category_bubble.dart
│  │  │  │     └─ reading_reward.dart
│  │  │  ├─ library
│  │  │  │  ├─ my_library_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ bookshelf_view.dart
│  │  │  │     ├─ downloaded_books_tab.dart
│  │  │  │     ├─ favorites_tab.dart
│  │  │  │     └─ reading_lists_tab.dart
│  │  │  ├─ main
│  │  │  │  └─ main_shell.dart
│  │  │  ├─ main_shell.dart
│  │  │  ├─ notifications
│  │  │  │  └─ notifications_screen.dart
│  │  │  ├─ onboarding
│  │  │  │  ├─ onboarding_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     └─ onboarding_page.dart
│  │  │  ├─ profile
│  │  │  │  ├─ downloads_management_screen.dart
│  │  │  │  ├─ edit_profile_screen.dart
│  │  │  │  ├─ parental_control_screen.dart
│  │  │  │  ├─ profile_screen.dart
│  │  │  │  ├─ reading_reports_screen.dart
│  │  │  │  ├─ settings_screen.dart
│  │  │  │  ├─ tabs
│  │  │  │  │  ├─ achievements_tab.dart
│  │  │  │  │  ├─ reviews_tab.dart
│  │  │  │  │  └─ statistics_tab.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ achievement_badges.dart
│  │  │  │     ├─ reading_stats_card.dart
│  │  │  │     └─ reading_streak.dart
│  │  │  ├─ reader
│  │  │  │  ├─ pdf_reader_screen.dart
│  │  │  │  ├─ reader_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     ├─ annotation_toolbar.dart
│  │  │  │     ├─ bookmark_button.dart
│  │  │  │     ├─ book_completion_dialog.dart
│  │  │  │     ├─ book_content_view.dart
│  │  │  │     ├─ bottom_controls.dart
│  │  │  │     ├─ brightness_control.dart
│  │  │  │     ├─ page_slider.dart
│  │  │  │     ├─ reader_bottom_bar.dart
│  │  │  │     ├─ reader_display_settings.dart
│  │  │  │     ├─ reader_settings_sheet.dart
│  │  │  │     ├─ reader_top_bar.dart
│  │  │  │     ├─ table_of_contents.dart
│  │  │  │     └─ top_controls.dart
│  │  │  ├─ search
│  │  │  │  ├─ search_screen.dart
│  │  │  │  └─ widgets
│  │  │  │     └─ search_filter_sheet.dart
│  │  │  ├─ settings
│  │  │  │  └─ settings_screen.dart
│  │  │  ├─ splash
│  │  │  │  └─ splash_screen.dart
│  │  │  ├─ stats
│  │  │  │  └─ reading_stats_screen.dart
│  │  │  └─ subscription
│  │  │     ├─ payment_screen.dart
│  │  │     ├─ subscription_screen.dart
│  │  │     └─ widgets
│  │  │        ├─ feature_comparison.dart
│  │  │        ├─ payment_method_tile.dart
│  │  │        └─ plan_card.dart
│  │  └─ widgets
│  │     ├─ animated_button.dart
│  │     ├─ avatar_widget.dart
│  │     ├─ book_card.dart
│  │     ├─ custom_app_bar.dart
│  │     ├─ custom_bottom_nav.dart
│  │     ├─ empty_state_widget.dart
│  │     ├─ error_widget.dart
│  │     ├─ progress_indicator.dart
│  │     ├─ rating_stars.dart
│  │     ├─ shimmer_loading.dart
│  │     └─ write_review_sheet.dart
│  └─ services
│     ├─ analytics_service.dart
│     ├─ download_service.dart
│     ├─ network_info.dart
│     ├─ notification_service.dart
│     ├─ parental_control_service.dart
│     ├─ pdf_cache_service.dart
│     ├─ purchase_service.dart
│     └─ sync_service.dart
├─ linux
│  ├─ CMakeLists.txt
│  ├─ flutter
│  │  ├─ CMakeLists.txt
│  │  ├─ ephemeral
│  │  │  └─ .plugin_symlinks
│  │  │     ├─ connectivity_plus
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradle.properties
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        └─ java
│  │  │     │  │           └─ dev
│  │  │     │  │              └─ fluttercommunity
│  │  │     │  │                 └─ plus
│  │  │     │  │                    └─ connectivity
│  │  │     │  │                       ├─ Connectivity.java
│  │  │     │  │                       ├─ ConnectivityBroadcastReceiver.java
│  │  │     │  │                       ├─ ConnectivityMethodChannelHandler.java
│  │  │     │  │                       └─ ConnectivityPlugin.java
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ analysis_options.yaml
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     └─ main
│  │  │     │  │  │  │        ├─ AndroidManifest.xml
│  │  │     │  │  │  │        ├─ java
│  │  │     │  │  │  │        │  └─ io
│  │  │     │  │  │  │        │     └─ flutter
│  │  │     │  │  │  │        │        └─ plugins
│  │  │     │  │  │  │        │           └─ connectivityexample
│  │  │     │  │  │  │        │              └─ FlutterActivityTest.java
│  │  │     │  │  │  │        └─ res
│  │  │     │  │  │  │           ├─ mipmap-hdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-mdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xxhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           └─ mipmap-xxxhdpi
│  │  │     │  │  │  │              └─ ic_launcher.png
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ connectivity_plus_test.dart
│  │  │     │  │  ├─ ios
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
│  │  │     │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  └─ Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  ├─ AppIcon.appiconset
│  │  │     │  │  │  │  │  │  ├─ Contents.json
│  │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │     │  │  │  │  │  └─ LaunchImage.imageset
│  │  │     │  │  │  │  │     ├─ Contents.json
│  │  │     │  │  │  │  │     ├─ LaunchImage.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
│  │  │     │  │  │  │  │     └─ README.md
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │     │  │  │  │  │  └─ Main.storyboard
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  └─ Runner-Bridging-Header.h
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  └─ CMakeLists.txt
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │  │        └─ configuration
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │        └─ configuration
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ web
│  │  │     │  │  │  ├─ favicon.png
│  │  │     │  │  │  ├─ icons
│  │  │     │  │  │  │  ├─ Icon-192.png
│  │  │     │  │  │  │  ├─ Icon-512.png
│  │  │     │  │  │  │  ├─ Icon-maskable-192.png
│  │  │     │  │  │  │  └─ Icon-maskable-512.png
│  │  │     │  │  │  ├─ index.html
│  │  │     │  │  │  └─ manifest.json
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  └─ CMakeLists.txt
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ run_loop.cpp
│  │  │     │  │        ├─ run_loop.h
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ios
│  │  │     │  │  ├─ connectivity_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ connectivity_plus
│  │  │     │  │  │        ├─ ConnectivityPlusPlugin.swift
│  │  │     │  │  │        ├─ ConnectivityProvider.swift
│  │  │     │  │  │        ├─ PathMonitorConnectivityProvider.swift
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ connectivity_plus.podspec
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ connectivity_plus.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ connectivity_plus_linux.dart
│  │  │     │  │     ├─ connectivity_plus_web.dart
│  │  │     │  │     └─ web
│  │  │     │  │        └─ dart_html_connectivity_plugin.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ macos
│  │  │     │  │  ├─ connectivity_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ connectivity_plus
│  │  │     │  │  │        ├─ ConnectivityPlusPlugin.swift
│  │  │     │  │  │        ├─ ConnectivityProvider.swift
│  │  │     │  │  │        ├─ PathMonitorConnectivityProvider.swift
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ connectivity_plus.podspec
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  ├─ test
│  │  │     │  │  ├─ connectivity_plus_linux_test.dart
│  │  │     │  │  ├─ connectivity_plus_linux_test.mocks.dart
│  │  │     │  │  └─ connectivity_test.dart
│  │  │     │  └─ windows
│  │  │     │     ├─ CMakeLists.txt
│  │  │     │     ├─ connectivity_plus_plugin.cpp
│  │  │     │     ├─ include
│  │  │     │     │  └─ connectivity_plus
│  │  │     │     │     ├─ connectivity_plus_windows_plugin.h
│  │  │     │     │     └─ network_manager.h
│  │  │     │     └─ network_manager.cpp
│  │  │     ├─ device_info_plus
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradle.properties
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        └─ kotlin
│  │  │     │  │           └─ dev
│  │  │     │  │              └─ fluttercommunity
│  │  │     │  │                 └─ plus
│  │  │     │  │                    └─ device_info
│  │  │     │  │                       ├─ DeviceInfoPlusPlugin.kt
│  │  │     │  │                       └─ MethodCallHandlerImpl.kt
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     ├─ debug
│  │  │     │  │  │  │     │  └─ AndroidManifest.xml
│  │  │     │  │  │  │     ├─ main
│  │  │     │  │  │  │     │  ├─ AndroidManifest.xml
│  │  │     │  │  │  │     │  ├─ kotlin
│  │  │     │  │  │  │     │  │  └─ io
│  │  │     │  │  │  │     │  │     └─ flutter
│  │  │     │  │  │  │     │  │        └─ plugins
│  │  │     │  │  │  │     │  │           └─ deviceinfoexample
│  │  │     │  │  │  │     │  │              └─ example
│  │  │     │  │  │  │     │  │                 └─ MainActivity.kt
│  │  │     │  │  │  │     │  └─ res
│  │  │     │  │  │  │     │     ├─ drawable
│  │  │     │  │  │  │     │     │  └─ launch_background.xml
│  │  │     │  │  │  │     │     ├─ mipmap-hdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-mdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     └─ values
│  │  │     │  │  │  │     │        └─ styles.xml
│  │  │     │  │  │  │     └─ profile
│  │  │     │  │  │  │        └─ AndroidManifest.xml
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ device_info_plus_test.dart
│  │  │     │  │  ├─ ios
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
│  │  │     │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  └─ Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  ├─ AppIcon.appiconset
│  │  │     │  │  │  │  │  │  ├─ Contents.json
│  │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │     │  │  │  │  │  └─ LaunchImage.imageset
│  │  │     │  │  │  │  │     ├─ Contents.json
│  │  │     │  │  │  │  │     ├─ LaunchImage.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
│  │  │     │  │  │  │  │     └─ README.md
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │     │  │  │  │  │  └─ Main.storyboard
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  └─ Runner-Bridging-Header.h
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  └─ CMakeLists.txt
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ pubspec_overrides.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ web
│  │  │     │  │  │  ├─ favicon.png
│  │  │     │  │  │  ├─ icons
│  │  │     │  │  │  │  ├─ Icon-192.png
│  │  │     │  │  │  │  └─ Icon-512.png
│  │  │     │  │  │  ├─ index.html
│  │  │     │  │  │  └─ manifest.json
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  └─ CMakeLists.txt
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ run_loop.cpp
│  │  │     │  │        ├─ run_loop.h
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ios
│  │  │     │  │  ├─ Classes
│  │  │     │  │  │  ├─ FPPDeviceInfoPlusPlugin.h
│  │  │     │  │  │  └─ FPPDeviceInfoPlusPlugin.m
│  │  │     │  │  └─ device_info_plus.podspec
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ device_info_plus.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ device_info_plus_linux.dart
│  │  │     │  │     ├─ device_info_plus_macos.dart
│  │  │     │  │     ├─ device_info_plus_web.dart
│  │  │     │  │     ├─ device_info_plus_windows.dart
│  │  │     │  │     └─ model
│  │  │     │  │        ├─ android_device_info.dart
│  │  │     │  │        ├─ ios_device_info.dart
│  │  │     │  │        ├─ linux_device_info.dart
│  │  │     │  │        ├─ macos_device_info.dart
│  │  │     │  │        ├─ web_browser_info.dart
│  │  │     │  │        └─ windows_device_info.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ macos
│  │  │     │  │  ├─ Classes
│  │  │     │  │  │  ├─ CwlSysctl.swift
│  │  │     │  │  │  ├─ DeviceInfoPlusMacosPlugin.swift
│  │  │     │  │  │  └─ SystemUUID.swift
│  │  │     │  │  └─ device_info_plus.podspec
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ device_info_plus_linux_test.dart
│  │  │     │     ├─ device_info_plus_web_test.dart
│  │  │     │     ├─ device_info_plus_windows_test.dart
│  │  │     │     └─ model
│  │  │     │        ├─ android_device_info_fake.dart
│  │  │     │        ├─ android_device_info_test.dart
│  │  │     │        ├─ ios_device_info_test.dart
│  │  │     │        ├─ linux_device_info_test.dart
│  │  │     │        ├─ macos_device_info_test.dart
│  │  │     │        ├─ web_browser_info_test.dart
│  │  │     │        └─ windows_device_info_test.dart
│  │  │     ├─ file_picker
│  │  │     │  ├─ analysis_options.yaml
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradle.properties
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        └─ java
│  │  │     │  │           └─ com
│  │  │     │  │              └─ mr
│  │  │     │  │                 └─ flutter
│  │  │     │  │                    └─ plugin
│  │  │     │  │                       └─ filepicker
│  │  │     │  │                          ├─ FileInfo.java
│  │  │     │  │                          ├─ FilePickerDelegate.java
│  │  │     │  │                          ├─ FilePickerPlugin.java
│  │  │     │  │                          └─ FileUtils.java
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ CONTRIBUTING.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ analysis_options.yaml
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     ├─ debug
│  │  │     │  │  │  │     │  └─ AndroidManifest.xml
│  │  │     │  │  │  │     ├─ main
│  │  │     │  │  │  │     │  ├─ AndroidManifest.xml
│  │  │     │  │  │  │     │  ├─ kotlin
│  │  │     │  │  │  │     │  │  └─ com
│  │  │     │  │  │  │     │  │     └─ mr
│  │  │     │  │  │  │     │  │        └─ flutter
│  │  │     │  │  │  │     │  │           └─ plugin
│  │  │     │  │  │  │     │  │              └─ filepicker
│  │  │     │  │  │  │     │  │                 └─ file_picker_example
│  │  │     │  │  │  │     │  │                    └─ MainActivity.kt
│  │  │     │  │  │  │     │  └─ res
│  │  │     │  │  │  │     │     ├─ drawable
│  │  │     │  │  │  │     │     │  └─ launch_background.xml
│  │  │     │  │  │  │     │     ├─ drawable-v21
│  │  │     │  │  │  │     │     │  └─ launch_background.xml
│  │  │     │  │  │  │     │     ├─ mipmap-hdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-mdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ values
│  │  │     │  │  │  │     │     │  └─ styles.xml
│  │  │     │  │  │  │     │     └─ values-night
│  │  │     │  │  │  │     │        └─ styles.xml
│  │  │     │  │  │  │     └─ profile
│  │  │     │  │  │  │        └─ AndroidManifest.xml
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ ios
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
│  │  │     │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  └─ Release.xcconfig
│  │  │     │  │  │  ├─ gpxgenerator_path.gpx
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.h
│  │  │     │  │  │  │  ├─ AppDelegate.m
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  ├─ AppIcon.appiconset
│  │  │     │  │  │  │  │  │  ├─ Contents.json
│  │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │     │  │  │  │  │  └─ LaunchImage.imageset
│  │  │     │  │  │  │  │     ├─ Contents.json
│  │  │     │  │  │  │  │     ├─ LaunchImage.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
│  │  │     │  │  │  │  │     └─ README.md
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │     │  │  │  │  │  └─ Main.storyboard
│  │  │     │  │  │  │  ├─ File.swift
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ main.m
│  │  │     │  │  │  │  └─ Runner-Bridging-Header.h
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  └─ Runner.xcworkspace
│  │  │     │  │  │     ├─ contents.xcworkspacedata
│  │  │     │  │  │     └─ xcshareddata
│  │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │        └─ WorkspaceSettings.xcsettings
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  ├─ main.dart
│  │  │     │  │  │  ├─ main_desktop.dart
│  │  │     │  │  │  └─ src
│  │  │     │  │  │     └─ file_picker_demo.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  │  ├─ generated_plugins.cmake
│  │  │     │  │  │  │  ├─ generated_plugin_registrant.cc
│  │  │     │  │  │  │  └─ generated_plugin_registrant.h
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ screenshots
│  │  │     │  │  │  ├─ example_android.gif
│  │  │     │  │  │  ├─ example_ios.gif
│  │  │     │  │  │  ├─ example_linux.gif
│  │  │     │  │  │  ├─ example_macos.png
│  │  │     │  │  │  └─ example_windows.gif
│  │  │     │  │  ├─ web
│  │  │     │  │  │  ├─ favicon.png
│  │  │     │  │  │  ├─ icons
│  │  │     │  │  │  │  ├─ Icon-192.png
│  │  │     │  │  │  │  └─ Icon-512.png
│  │  │     │  │  │  ├─ index.html
│  │  │     │  │  │  └─ manifest.json
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  ├─ CMakeLists.txt
│  │  │     │  │     │  ├─ generated_plugins.cmake
│  │  │     │  │     │  ├─ generated_plugin_registrant.cc
│  │  │     │  │     │  └─ generated_plugin_registrant.h
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ios
│  │  │     │  │  ├─ file_picker
│  │  │     │  │  │  ├─ Package.resolved
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ file_picker
│  │  │     │  │  │        ├─ FileInfo.m
│  │  │     │  │  │        ├─ FilePickerPlugin.m
│  │  │     │  │  │        ├─ FileUtils.m
│  │  │     │  │  │        ├─ ImageUtils.m
│  │  │     │  │  │        ├─ include
│  │  │     │  │  │        │  ├─ file_picker
│  │  │     │  │  │        │  │  ├─ FileInfo.h
│  │  │     │  │  │        │  │  ├─ FilePickerPlugin.h
│  │  │     │  │  │        │  │  ├─ FileUtils.h
│  │  │     │  │  │        │  │  └─ ImageUtils.h
│  │  │     │  │  │        │  ├─ file_picker-umbrella.h
│  │  │     │  │  │        │  └─ file_picker.modulemap
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ file_picker.podspec
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ file_picker.dart
│  │  │     │  │  ├─ src
│  │  │     │  │  │  ├─ exceptions.dart
│  │  │     │  │  │  ├─ file_picker.dart
│  │  │     │  │  │  ├─ file_picker_io.dart
│  │  │     │  │  │  ├─ file_picker_macos.dart
│  │  │     │  │  │  ├─ file_picker_result.dart
│  │  │     │  │  │  ├─ linux
│  │  │     │  │  │  │  ├─ dialog_handler.dart
│  │  │     │  │  │  │  ├─ file_picker_linux.dart
│  │  │     │  │  │  │  ├─ kdialog_handler.dart
│  │  │     │  │  │  │  └─ qarma_and_zenity_handler.dart
│  │  │     │  │  │  ├─ platform_file.dart
│  │  │     │  │  │  ├─ utils.dart
│  │  │     │  │  │  └─ windows
│  │  │     │  │  │     ├─ file_picker_windows.dart
│  │  │     │  │  │     ├─ file_picker_windows_ffi_types.dart
│  │  │     │  │  │     └─ file_picker_windows_stub.dart
│  │  │     │  │  └─ _internal
│  │  │     │  │     └─ file_picker_web.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ macos
│  │  │     │  │  ├─ file_picker
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ file_picker
│  │  │     │  │  │        ├─ FilePickerPlugin.swift
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ file_picker.podspec
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ common.dart
│  │  │     │     ├─ file_picker_macos_test.dart
│  │  │     │     ├─ file_picker_utils_test.dart
│  │  │     │     ├─ file_picker_windows_test.dart
│  │  │     │     ├─ linux
│  │  │     │     │  ├─ dialog_handler_test.dart
│  │  │     │     │  ├─ kdialog_handler_test.dart
│  │  │     │     │  └─ qarma_and_zenity_handler_test.dart
│  │  │     │     └─ test_files
│  │  │     │        ├─ franz-michael-schneeberger-unsplash.jpg
│  │  │     │        ├─ test.pdf
│  │  │     │        └─ test.yml
│  │  │     ├─ flutter_local_notifications_linux
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ flutter_local_notifications_linux.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ dbus_wrapper.dart
│  │  │     │  │     ├─ file_system.dart
│  │  │     │  │     ├─ flutter_local_notifications.dart
│  │  │     │  │     ├─ flutter_local_notifications_platform_linux.dart
│  │  │     │  │     ├─ flutter_local_notifications_stub.dart
│  │  │     │  │     ├─ helpers.dart
│  │  │     │  │     ├─ model
│  │  │     │  │     │  ├─ capabilities.dart
│  │  │     │  │     │  ├─ enums.dart
│  │  │     │  │     │  ├─ hint.dart
│  │  │     │  │     │  ├─ icon.dart
│  │  │     │  │     │  ├─ initialization_settings.dart
│  │  │     │  │     │  ├─ location.dart
│  │  │     │  │     │  ├─ notification_details.dart
│  │  │     │  │     │  ├─ sound.dart
│  │  │     │  │     │  └─ timeout.dart
│  │  │     │  │     ├─ notifications_manager.dart
│  │  │     │  │     ├─ notification_info.dart
│  │  │     │  │     ├─ platform_info.dart
│  │  │     │  │     ├─ posix.dart
│  │  │     │  │     └─ storage.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ notifications_manager_test.dart
│  │  │     │     ├─ notifications_manager_test.mocks.dart
│  │  │     │     ├─ posix_test.dart
│  │  │     │     ├─ storage_test.dart
│  │  │     │     └─ storage_test.mocks.dart
│  │  │     ├─ jni
│  │  │     │  ├─ analysis_options.yaml
│  │  │     │  ├─ android
│  │  │     │  │  ├─ .cxx
│  │  │     │  │  │  ├─ Debug
│  │  │     │  │  │  │  └─ 1s4e134i
│  │  │     │  │  │  │     ├─ arm64-v8a
│  │  │     │  │  │  │     │  ├─ .cmake
│  │  │     │  │  │  │     │  │  └─ api
│  │  │     │  │  │  │     │  │     └─ v1
│  │  │     │  │  │  │     │  │        ├─ query
│  │  │     │  │  │  │     │  │        │  └─ client-agp
│  │  │     │  │  │  │     │  │        │     ├─ cache-v2
│  │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
│  │  │     │  │  │  │     │  │        │     └─ codemodel-v2
│  │  │     │  │  │  │     │  │        └─ reply
│  │  │     │  │  │  │     │  │           ├─ cache-v2-a839d37ee8ea17f34a74.json
│  │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-87f2a19eae4dcab5e0a3.json
│  │  │     │  │  │  │     │  │           ├─ codemodel-v2-3e5f840cd01b7e4e7627.json
│  │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
│  │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-33-0869.json
│  │  │     │  │  │  │     │  │           └─ target-jni-Debug-e2f2b42aa99ddc3d67fa.json
│  │  │     │  │  │  │     │  ├─ .ninja_deps
│  │  │     │  │  │  │     │  ├─ .ninja_log
│  │  │     │  │  │  │     │  ├─ additional_project_files.txt
│  │  │     │  │  │  │     │  ├─ android_gradle_build.json
│  │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
│  │  │     │  │  │  │     │  ├─ build.ninja
│  │  │     │  │  │  │     │  ├─ build_file_index.txt
│  │  │     │  │  │  │     │  ├─ CMakeCache.txt
│  │  │     │  │  │  │     │  ├─ CMakeFiles
│  │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
│  │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
│  │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
│  │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
│  │  │     │  │  │  │     │  │  │  └─ CompilerIdC
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
│  │  │     │  │  │  │     │  │  │     └─ tmp
│  │  │     │  │  │  │     │  │  ├─ cmake.check_cache
│  │  │     │  │  │  │     │  │  ├─ CMakeTmp
│  │  │     │  │  │  │     │  │  ├─ jni.dir
│  │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
│  │  │     │  │  │  │     │  │  │  ├─ include
│  │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
│  │  │     │  │  │  │     │  │  │  └─ third_party
│  │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
│  │  │     │  │  │  │     │  │  ├─ rules.ninja
│  │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
│  │  │     │  │  │  │     │  ├─ cmake_install.cmake
│  │  │     │  │  │  │     │  ├─ compile_commands.json
│  │  │     │  │  │  │     │  ├─ compile_commands.json.bin
│  │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
│  │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
│  │  │     │  │  │  │     │  ├─ prefab_config.json
│  │  │     │  │  │  │     │  └─ symbol_folder_index.txt
│  │  │     │  │  │  │     ├─ armeabi-v7a
│  │  │     │  │  │  │     │  ├─ .cmake
│  │  │     │  │  │  │     │  │  └─ api
│  │  │     │  │  │  │     │  │     └─ v1
│  │  │     │  │  │  │     │  │        ├─ query
│  │  │     │  │  │  │     │  │        │  └─ client-agp
│  │  │     │  │  │  │     │  │        │     ├─ cache-v2
│  │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
│  │  │     │  │  │  │     │  │        │     └─ codemodel-v2
│  │  │     │  │  │  │     │  │        └─ reply
│  │  │     │  │  │  │     │  │           ├─ cache-v2-5666089e635e5344d90c.json
│  │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-6c4c8f4bc739a7188064.json
│  │  │     │  │  │  │     │  │           ├─ codemodel-v2-f0d65234abc65f416dd9.json
│  │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
│  │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-35-0860.json
│  │  │     │  │  │  │     │  │           └─ target-jni-Debug-801cad15e0c2d51bc8d3.json
│  │  │     │  │  │  │     │  ├─ .ninja_deps
│  │  │     │  │  │  │     │  ├─ .ninja_log
│  │  │     │  │  │  │     │  ├─ additional_project_files.txt
│  │  │     │  │  │  │     │  ├─ android_gradle_build.json
│  │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
│  │  │     │  │  │  │     │  ├─ build.ninja
│  │  │     │  │  │  │     │  ├─ build_file_index.txt
│  │  │     │  │  │  │     │  ├─ CMakeCache.txt
│  │  │     │  │  │  │     │  ├─ CMakeFiles
│  │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
│  │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
│  │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
│  │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
│  │  │     │  │  │  │     │  │  │  └─ CompilerIdC
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
│  │  │     │  │  │  │     │  │  │     └─ tmp
│  │  │     │  │  │  │     │  │  ├─ cmake.check_cache
│  │  │     │  │  │  │     │  │  ├─ CMakeTmp
│  │  │     │  │  │  │     │  │  ├─ jni.dir
│  │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
│  │  │     │  │  │  │     │  │  │  ├─ include
│  │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
│  │  │     │  │  │  │     │  │  │  └─ third_party
│  │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
│  │  │     │  │  │  │     │  │  ├─ rules.ninja
│  │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
│  │  │     │  │  │  │     │  ├─ cmake_install.cmake
│  │  │     │  │  │  │     │  ├─ compile_commands.json
│  │  │     │  │  │  │     │  ├─ compile_commands.json.bin
│  │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
│  │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
│  │  │     │  │  │  │     │  ├─ prefab_config.json
│  │  │     │  │  │  │     │  └─ symbol_folder_index.txt
│  │  │     │  │  │  │     ├─ hash_key.txt
│  │  │     │  │  │  │     ├─ x86
│  │  │     │  │  │  │     │  ├─ .cmake
│  │  │     │  │  │  │     │  │  └─ api
│  │  │     │  │  │  │     │  │     └─ v1
│  │  │     │  │  │  │     │  │        ├─ query
│  │  │     │  │  │  │     │  │        │  └─ client-agp
│  │  │     │  │  │  │     │  │        │     ├─ cache-v2
│  │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
│  │  │     │  │  │  │     │  │        │     └─ codemodel-v2
│  │  │     │  │  │  │     │  │        └─ reply
│  │  │     │  │  │  │     │  │           ├─ cache-v2-ce908d41b1252033e926.json
│  │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-2bb796cc6a454960e08e.json
│  │  │     │  │  │  │     │  │           ├─ codemodel-v2-caba4437fd3cefe0f8c1.json
│  │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
│  │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-37-0525.json
│  │  │     │  │  │  │     │  │           └─ target-jni-Debug-ef73d009b6013e3a8fc4.json
│  │  │     │  │  │  │     │  ├─ .ninja_deps
│  │  │     │  │  │  │     │  ├─ .ninja_log
│  │  │     │  │  │  │     │  ├─ additional_project_files.txt
│  │  │     │  │  │  │     │  ├─ android_gradle_build.json
│  │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
│  │  │     │  │  │  │     │  ├─ build.ninja
│  │  │     │  │  │  │     │  ├─ build_file_index.txt
│  │  │     │  │  │  │     │  ├─ CMakeCache.txt
│  │  │     │  │  │  │     │  ├─ CMakeFiles
│  │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
│  │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
│  │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
│  │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
│  │  │     │  │  │  │     │  │  │  └─ CompilerIdC
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
│  │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
│  │  │     │  │  │  │     │  │  │     └─ tmp
│  │  │     │  │  │  │     │  │  ├─ cmake.check_cache
│  │  │     │  │  │  │     │  │  ├─ CMakeTmp
│  │  │     │  │  │  │     │  │  ├─ jni.dir
│  │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
│  │  │     │  │  │  │     │  │  │  ├─ include
│  │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
│  │  │     │  │  │  │     │  │  │  └─ third_party
│  │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
│  │  │     │  │  │  │     │  │  ├─ rules.ninja
│  │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
│  │  │     │  │  │  │     │  ├─ cmake_install.cmake
│  │  │     │  │  │  │     │  ├─ compile_commands.json
│  │  │     │  │  │  │     │  ├─ compile_commands.json.bin
│  │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
│  │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
│  │  │     │  │  │  │     │  ├─ prefab_config.json
│  │  │     │  │  │  │     │  └─ symbol_folder_index.txt
│  │  │     │  │  │  │     └─ x86_64
│  │  │     │  │  │  │        ├─ .cmake
│  │  │     │  │  │  │        │  └─ api
│  │  │     │  │  │  │        │     └─ v1
│  │  │     │  │  │  │        │        ├─ query
│  │  │     │  │  │  │        │        │  └─ client-agp
│  │  │     │  │  │  │        │        │     ├─ cache-v2
│  │  │     │  │  │  │        │        │     ├─ cmakeFiles-v1
│  │  │     │  │  │  │        │        │     └─ codemodel-v2
│  │  │     │  │  │  │        │        └─ reply
│  │  │     │  │  │  │        │           ├─ cache-v2-840facfb3fe94a748fb5.json
│  │  │     │  │  │  │        │           ├─ cmakeFiles-v1-1dc2a214dc0492f110c2.json
│  │  │     │  │  │  │        │           ├─ codemodel-v2-d9e1128f36c8064fe0e5.json
│  │  │     │  │  │  │        │           ├─ directory-.-Debug-d0094a50bb2071803777.json
│  │  │     │  │  │  │        │           ├─ index-2026-04-22T12-02-39-0272.json
│  │  │     │  │  │  │        │           └─ target-jni-Debug-0997099afe667e77ee8d.json
│  │  │     │  │  │  │        ├─ .ninja_deps
│  │  │     │  │  │  │        ├─ .ninja_log
│  │  │     │  │  │  │        ├─ additional_project_files.txt
│  │  │     │  │  │  │        ├─ android_gradle_build.json
│  │  │     │  │  │  │        ├─ android_gradle_build_mini.json
│  │  │     │  │  │  │        ├─ build.ninja
│  │  │     │  │  │  │        ├─ build_file_index.txt
│  │  │     │  │  │  │        ├─ CMakeCache.txt
│  │  │     │  │  │  │        ├─ CMakeFiles
│  │  │     │  │  │  │        │  ├─ 3.22.1-g37088a8-dirty
│  │  │     │  │  │  │        │  │  ├─ CMakeCCompiler.cmake
│  │  │     │  │  │  │        │  │  ├─ CMakeDetermineCompilerABI_C.bin
│  │  │     │  │  │  │        │  │  ├─ CMakeSystem.cmake
│  │  │     │  │  │  │        │  │  └─ CompilerIdC
│  │  │     │  │  │  │        │  │     ├─ CMakeCCompilerId.c
│  │  │     │  │  │  │        │  │     ├─ CMakeCCompilerId.o
│  │  │     │  │  │  │        │  │     └─ tmp
│  │  │     │  │  │  │        │  ├─ cmake.check_cache
│  │  │     │  │  │  │        │  ├─ CMakeTmp
│  │  │     │  │  │  │        │  ├─ jni.dir
│  │  │     │  │  │  │        │  │  ├─ dartjni.c.o
│  │  │     │  │  │  │        │  │  ├─ include
│  │  │     │  │  │  │        │  │  │  └─ dart_api_dl.c.o
│  │  │     │  │  │  │        │  │  └─ third_party
│  │  │     │  │  │  │        │  │     └─ global_jni_env.c.o
│  │  │     │  │  │  │        │  ├─ rules.ninja
│  │  │     │  │  │  │        │  └─ TargetDirectories.txt
│  │  │     │  │  │  │        ├─ cmake_install.cmake
│  │  │     │  │  │  │        ├─ compile_commands.json
│  │  │     │  │  │  │        ├─ compile_commands.json.bin
│  │  │     │  │  │  │        ├─ configure_fingerprint.bin
│  │  │     │  │  │  │        ├─ metadata_generation_command.txt
│  │  │     │  │  │  │        ├─ prefab_config.json
│  │  │     │  │  │  │        └─ symbol_folder_index.txt
│  │  │     │  │  │  └─ tools
│  │  │     │  │  │     └─ profile
│  │  │     │  │  │        ├─ arm64-v8a
│  │  │     │  │  │        │  └─ compile_commands.json
│  │  │     │  │  │        ├─ armeabi-v7a
│  │  │     │  │  │        │  └─ compile_commands.json
│  │  │     │  │  │        ├─ x86
│  │  │     │  │  │        │  └─ compile_commands.json
│  │  │     │  │  │        └─ x86_64
│  │  │     │  │  │           └─ compile_commands.json
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ consumer-rules.pro
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        └─ java
│  │  │     │  │           └─ com
│  │  │     │  │              └─ github
│  │  │     │  │                 └─ dart_lang
│  │  │     │  │                    └─ jni
│  │  │     │  │                       └─ JniPlugin.java
│  │  │     │  ├─ bin
│  │  │     │  │  └─ setup.dart
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ dart_test.yaml
│  │  │     │  ├─ example
│  │  │     │  │  ├─ analysis_options.yaml
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     ├─ debug
│  │  │     │  │  │  │     │  └─ AndroidManifest.xml
│  │  │     │  │  │  │     ├─ main
│  │  │     │  │  │  │     │  ├─ AndroidManifest.xml
│  │  │     │  │  │  │     │  ├─ java
│  │  │     │  │  │  │     │  │  ├─ com
│  │  │     │  │  │  │     │  │  │  └─ github
│  │  │     │  │  │  │     │  │  │     └─ dart_lang
│  │  │     │  │  │  │     │  │  │        └─ jni_example
│  │  │     │  │  │  │     │  │  │           └─ Toaster.java
│  │  │     │  │  │  │     │  │  └─ io
│  │  │     │  │  │  │     │  │     └─ flutter
│  │  │     │  │  │  │     │  │        └─ plugins
│  │  │     │  │  │  │     │  ├─ kotlin
│  │  │     │  │  │  │     │  │  └─ dev
│  │  │     │  │  │  │     │  │     └─ dart
│  │  │     │  │  │  │     │  │        └─ jni_example
│  │  │     │  │  │  │     │  │           └─ MainActivity.kt
│  │  │     │  │  │  │     │  └─ res
│  │  │     │  │  │  │     │     ├─ drawable
│  │  │     │  │  │  │     │     │  └─ launch_background.xml
│  │  │     │  │  │  │     │     ├─ drawable-v21
│  │  │     │  │  │  │     │     │  └─ launch_background.xml
│  │  │     │  │  │  │     │     ├─ mipmap-hdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-mdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
│  │  │     │  │  │  │     │     │  └─ ic_launcher.png
│  │  │     │  │  │  │     │     ├─ values
│  │  │     │  │  │  │     │     │  └─ styles.xml
│  │  │     │  │  │  │     │     └─ values-night
│  │  │     │  │  │  │     │        └─ styles.xml
│  │  │     │  │  │  │     └─ profile
│  │  │     │  │  │  │        └─ AndroidManifest.xml
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ on_device_jni_test.dart
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  └─ CMakeLists.txt
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Podfile
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  └─ Runner.xcworkspace
│  │  │     │  │  │     ├─ contents.xcworkspacedata
│  │  │     │  │  │     └─ xcshareddata
│  │  │     │  │  │        └─ IDEWorkspaceChecks.plist
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  └─ CMakeLists.txt
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ffigen.yaml
│  │  │     │  ├─ ffigen_exts.yaml
│  │  │     │  ├─ java
│  │  │     │  │  ├─ build.gradle.kts
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  ├─ libs.versions.toml
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     ├─ gradle-wrapper.jar
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradlew
│  │  │     │  │  ├─ gradlew.bat
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ settings.gradle.kts
│  │  │     │  │  ├─ src
│  │  │     │  │  │  └─ main
│  │  │     │  │  │     └─ java
│  │  │     │  │  │        └─ com
│  │  │     │  │  │           └─ github
│  │  │     │  │  │              └─ dart_lang
│  │  │     │  │  │                 └─ jni
│  │  │     │  │  │                    ├─ JniUtils.java
│  │  │     │  │  │                    ├─ PortCleaner.java
│  │  │     │  │  │                    ├─ PortContinuation.java
│  │  │     │  │  │                    └─ PortProxyBuilder.java
│  │  │     │  │  └─ ~
│  │  │     │  │     └─ dev
│  │  │     │  │        ├─ native
│  │  │     │  │        │  └─ native
│  │  │     │  │        │     └─ pkgs
│  │  │     │  │        │        └─ jnigen
│  │  │     │  │        │           └─ example
│  │  │     │  │        │              └─ pdfbox_plugin
│  │  │     │  │        │                 └─ dart_example
│  │  │     │  │        └─ native2
│  │  │     │  │           └─ pkgs
│  │  │     │  │              └─ jnigen
│  │  │     │  │                 └─ example
│  │  │     │  │                    └─ pdfbox_plugin
│  │  │     │  │                       └─ dart_example
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ jni.dart
│  │  │     │  │  ├─ jni_symbols.yaml
│  │  │     │  │  ├─ src
│  │  │     │  │  │  ├─ accessors.dart
│  │  │     │  │  │  ├─ build_util
│  │  │     │  │  │  │  └─ build_util.dart
│  │  │     │  │  │  ├─ core_bindings.dart
│  │  │     │  │  │  ├─ errors.dart
│  │  │     │  │  │  ├─ jarray.dart
│  │  │     │  │  │  ├─ jclass.dart
│  │  │     │  │  │  ├─ jimplementer.dart
│  │  │     │  │  │  ├─ jni.dart
│  │  │     │  │  │  ├─ jobject.dart
│  │  │     │  │  │  ├─ jprimitives.dart
│  │  │     │  │  │  ├─ jreference.dart
│  │  │     │  │  │  ├─ jvalues.dart
│  │  │     │  │  │  ├─ kotlin.dart
│  │  │     │  │  │  ├─ lang
│  │  │     │  │  │  │  ├─ jboolean.dart
│  │  │     │  │  │  │  ├─ jbyte.dart
│  │  │     │  │  │  │  ├─ jcharacter.dart
│  │  │     │  │  │  │  ├─ jdouble.dart
│  │  │     │  │  │  │  ├─ jfloat.dart
│  │  │     │  │  │  │  ├─ jinteger.dart
│  │  │     │  │  │  │  ├─ jlong.dart
│  │  │     │  │  │  │  ├─ jnumber.dart
│  │  │     │  │  │  │  ├─ jshort.dart
│  │  │     │  │  │  │  ├─ jstring.dart
│  │  │     │  │  │  │  └─ lang.dart
│  │  │     │  │  │  ├─ method_invocation.dart
│  │  │     │  │  │  ├─ nio
│  │  │     │  │  │  │  ├─ jbuffer.dart
│  │  │     │  │  │  │  ├─ jbyte_buffer.dart
│  │  │     │  │  │  │  └─ nio.dart
│  │  │     │  │  │  ├─ primitive_jarrays.dart
│  │  │     │  │  │  ├─ third_party
│  │  │     │  │  │  │  ├─ generated_bindings.dart
│  │  │     │  │  │  │  ├─ global_env_extensions.dart
│  │  │     │  │  │  │  └─ jni_bindings_generated.dart
│  │  │     │  │  │  ├─ types.dart
│  │  │     │  │  │  ├─ util
│  │  │     │  │  │  │  ├─ jiterator.dart
│  │  │     │  │  │  │  ├─ jlist.dart
│  │  │     │  │  │  │  ├─ jmap.dart
│  │  │     │  │  │  │  ├─ jset.dart
│  │  │     │  │  │  │  └─ util.dart
│  │  │     │  │  │  └─ version_check.dart
│  │  │     │  │  └─ _internal.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ linux
│  │  │     │  │  └─ CMakeLists.txt
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  ├─ src
│  │  │     │  │  ├─ CMakeLists.txt
│  │  │     │  │  ├─ dartjni.c
│  │  │     │  │  ├─ dartjni.h
│  │  │     │  │  ├─ include
│  │  │     │  │  │  ├─ analyze_snapshot_api.h
│  │  │     │  │  │  ├─ bin
│  │  │     │  │  │  │  ├─ dart_io_api.h
│  │  │     │  │  │  │  └─ native_assets_api.h
│  │  │     │  │  │  ├─ BUILD.gn
│  │  │     │  │  │  ├─ dart_api.h
│  │  │     │  │  │  ├─ dart_api_dl.c
│  │  │     │  │  │  ├─ dart_api_dl.h
│  │  │     │  │  │  ├─ dart_embedder_api.h
│  │  │     │  │  │  ├─ dart_native_api.h
│  │  │     │  │  │  ├─ dart_tools_api.h
│  │  │     │  │  │  ├─ dart_version.h
│  │  │     │  │  │  └─ internal
│  │  │     │  │  │     └─ dart_api_dl_impl.h
│  │  │     │  │  ├─ jni_constants.h
│  │  │     │  │  ├─ README.md
│  │  │     │  │  └─ third_party
│  │  │     │  │     ├─ global_jni_env.c
│  │  │     │  │     └─ global_jni_env.h
│  │  │     │  ├─ test
│  │  │     │  │  ├─ boxed_test.dart
│  │  │     │  │  ├─ debug_release_test.dart
│  │  │     │  │  ├─ exception_test.dart
│  │  │     │  │  ├─ global_env_test.dart
│  │  │     │  │  ├─ isolate_test.dart
│  │  │     │  │  ├─ jarray_test.dart
│  │  │     │  │  ├─ jbyte_buffer_test.dart
│  │  │     │  │  ├─ jlist_test.dart
│  │  │     │  │  ├─ jmap_test.dart
│  │  │     │  │  ├─ jobject_test.dart
│  │  │     │  │  ├─ jset_test.dart
│  │  │     │  │  ├─ jstring_test.dart
│  │  │     │  │  ├─ load_test.dart
│  │  │     │  │  ├─ test_util
│  │  │     │  │  │  └─ test_util.dart
│  │  │     │  │  ├─ version_check
│  │  │     │  │  │  ├─ fail_major.dart
│  │  │     │  │  │  ├─ fail_minor.dart
│  │  │     │  │  │  └─ pass.dart
│  │  │     │  │  └─ version_check_test.dart
│  │  │     │  ├─ third_party
│  │  │     │  │  └─ jni.h
│  │  │     │  ├─ tool
│  │  │     │  │  ├─ generate_ffi_bindings.dart
│  │  │     │  │  ├─ generate_ide_files.dart
│  │  │     │  │  ├─ generate_jni_bindings.dart
│  │  │     │  │  ├─ generate_primitive_arrays.dart
│  │  │     │  │  └─ wrapper_generators
│  │  │     │  │     ├─ ffigen_util.dart
│  │  │     │  │     ├─ generate_c_extensions.dart
│  │  │     │  │     ├─ generate_dart_extensions.dart
│  │  │     │  │     ├─ generate_helper_functions.dart
│  │  │     │  │     └─ logging.dart
│  │  │     │  └─ windows
│  │  │     │     └─ CMakeLists.txt
│  │  │     ├─ open_file_linux
│  │  │     │  ├─ analysis_options.yaml
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ open_file_linux.dart
│  │  │     │  │  └─ parse_args.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ linux
│  │  │     │  │  ├─ CMakeLists.txt
│  │  │     │  │  ├─ include
│  │  │     │  │  │  └─ open_file_linux
│  │  │     │  │  │     └─ open_file_linux_plugin.h
│  │  │     │  │  ├─ open_file_linux_plugin.cc
│  │  │     │  │  ├─ open_file_linux_plugin_private.h
│  │  │     │  │  └─ test
│  │  │     │  │     └─ open_file_linux_plugin_test.cc
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     └─ open_file_linux_test.dart
│  │  │     ├─ package_info_plus
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradle.properties
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        └─ kotlin
│  │  │     │  │           └─ dev
│  │  │     │  │              └─ fluttercommunity
│  │  │     │  │                 └─ plus
│  │  │     │  │                    └─ packageinfo
│  │  │     │  │                       └─ PackageInfoPlugin.kt
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ analysis_options.yaml
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  ├─ gradle
│  │  │     │  │  │  │  │  └─ wrapper
│  │  │     │  │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     ├─ androidTest
│  │  │     │  │  │  │     │  └─ java
│  │  │     │  │  │  │     │     └─ io
│  │  │     │  │  │  │     │        └─ flutter
│  │  │     │  │  │  │     │           └─ plugins
│  │  │     │  │  │  │     │              └─ packageinfoexample
│  │  │     │  │  │  │     │                 ├─ EmbedderV1ActivityTest.java
│  │  │     │  │  │  │     │                 └─ MainActivityTest.java
│  │  │     │  │  │  │     └─ main
│  │  │     │  │  │  │        ├─ AndroidManifest.xml
│  │  │     │  │  │  │        ├─ java
│  │  │     │  │  │  │        │  └─ io
│  │  │     │  │  │  │        │     └─ flutter
│  │  │     │  │  │  │        │        └─ plugins
│  │  │     │  │  │  │        └─ res
│  │  │     │  │  │  │           ├─ mipmap-hdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-mdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xxhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           └─ mipmap-xxxhdpi
│  │  │     │  │  │  │              └─ ic_launcher.png
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ build.yaml
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  ├─ driver.dart
│  │  │     │  │  │  ├─ package_info_plus_test.dart
│  │  │     │  │  │  ├─ package_info_plus_web_test.dart
│  │  │     │  │  │  └─ package_info_plus_web_test.mocks.dart
│  │  │     │  │  ├─ ios
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
│  │  │     │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  └─ Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  ├─ AppIcon.appiconset
│  │  │     │  │  │  │  │  │  ├─ Contents.json
│  │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │     │  │  │  │  │  └─ LaunchImage.imageset
│  │  │     │  │  │  │  │     ├─ Contents.json
│  │  │     │  │  │  │  │     ├─ LaunchImage.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
│  │  │     │  │  │  │  │     └─ README.md
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │     │  │  │  │  │  └─ Main.storyboard
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  └─ Runner-Bridging-Header.h
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  └─ CMakeLists.txt
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │  │        └─ configuration
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │        └─ configuration
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ web
│  │  │     │  │  │  ├─ favicon.png
│  │  │     │  │  │  ├─ icons
│  │  │     │  │  │  │  ├─ Icon-192.png
│  │  │     │  │  │  │  ├─ Icon-512.png
│  │  │     │  │  │  │  ├─ Icon-maskable-192.png
│  │  │     │  │  │  │  └─ Icon-maskable-512.png
│  │  │     │  │  │  ├─ index.html
│  │  │     │  │  │  └─ manifest.json
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  └─ CMakeLists.txt
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ios
│  │  │     │  │  ├─ package_info_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ package_info_plus
│  │  │     │  │  │        ├─ FPPPackageInfoPlusPlugin.m
│  │  │     │  │  │        ├─ include
│  │  │     │  │  │        │  └─ package_info_plus
│  │  │     │  │  │        │     └─ FPPPackageInfoPlusPlugin.h
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ package_info_plus.podspec
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ package_info_plus.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ file_attribute.dart
│  │  │     │  │     ├─ file_version_info.dart
│  │  │     │  │     ├─ package_info_plus_linux.dart
│  │  │     │  │     ├─ package_info_plus_macos.dart
│  │  │     │  │     ├─ package_info_plus_web.dart
│  │  │     │  │     └─ package_info_plus_windows.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ macos
│  │  │     │  │  ├─ package_info_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ package_info_plus
│  │  │     │  │  │        ├─ FPPPackageInfoPlusPlugin.m
│  │  │     │  │  │        ├─ include
│  │  │     │  │  │        │  └─ package_info_plus
│  │  │     │  │  │        │     └─ FPPPackageInfoPlusPlugin.h
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ package_info_plus.podspec
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ package_info_plus_linux_test.dart
│  │  │     │     ├─ package_info_plus_windows_test.dart
│  │  │     │     └─ package_info_test.dart
│  │  │     ├─ path_provider_linux
│  │  │     │  ├─ AUTHORS
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ path_provider_test.dart
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  │  └─ generated_plugins.cmake
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  └─ test_driver
│  │  │     │  │     └─ integration_test.dart
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ path_provider_linux.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ get_application_id.dart
│  │  │     │  │     ├─ get_application_id_real.dart
│  │  │     │  │     ├─ get_application_id_stub.dart
│  │  │     │  │     └─ path_provider_linux.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ get_application_id_test.dart
│  │  │     │     └─ path_provider_linux_test.dart
│  │  │     ├─ pdfrx
│  │  │     │  ├─ analysis_options.yaml
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ CMakeLists.txt
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        └─ AndroidManifest.xml
│  │  │     │  ├─ assets
│  │  │     │  │  ├─ pdfium.wasm
│  │  │     │  │  ├─ pdfium_client.js
│  │  │     │  │  └─ pdfium_worker.js
│  │  │     │  ├─ bin
│  │  │     │  │  └─ remove_wasm_modules.dart
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ CLAUDE.md
│  │  │     │  ├─ CODE_OF_CONDUCT.md
│  │  │     │  ├─ darwin
│  │  │     │  │  ├─ pdfium
│  │  │     │  │  │  ├─ build
│  │  │     │  │  │  ├─ build-config.sh
│  │  │     │  │  │  └─ patches
│  │  │     │  │  ├─ pdfrx
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ pdfrx
│  │  │     │  │  │        ├─ include
│  │  │     │  │  │        └─ pdfrx.cpp
│  │  │     │  │  └─ pdfrx.podspec
│  │  │     │  ├─ example
│  │  │     │  │  └─ README.md
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ pdfrx.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ pdfium
│  │  │     │  │     │  ├─ http_cache_control.dart
│  │  │     │  │     │  ├─ pdfium_bindings.dart
│  │  │     │  │     │  ├─ pdfium_interop.dart
│  │  │     │  │     │  ├─ pdfrx_pdfium.dart
│  │  │     │  │     │  ├─ pdf_file_cache.dart
│  │  │     │  │     │  └─ worker.dart
│  │  │     │  │     ├─ pdf_api.dart
│  │  │     │  │     ├─ pdf_document_ref.dart
│  │  │     │  │     ├─ utils
│  │  │     │  │     │  ├─ double_extensions.dart
│  │  │     │  │     │  ├─ native
│  │  │     │  │     │  │  └─ native.dart
│  │  │     │  │     │  ├─ platform.dart
│  │  │     │  │     │  └─ web
│  │  │     │  │     │     └─ web.dart
│  │  │     │  │     ├─ web
│  │  │     │  │     │  ├─ js_utils.dart
│  │  │     │  │     │  └─ pdfrx_wasm.dart
│  │  │     │  │     └─ widgets
│  │  │     │  │        ├─ interactive_viewer.dart
│  │  │     │  │        ├─ pdf_error_widget.dart
│  │  │     │  │        ├─ pdf_page_links_overlay.dart
│  │  │     │  │        ├─ pdf_page_text_overlay.dart
│  │  │     │  │        ├─ pdf_text_searcher.dart
│  │  │     │  │        ├─ pdf_viewer.dart
│  │  │     │  │        ├─ pdf_viewer_params.dart
│  │  │     │  │        ├─ pdf_viewer_scroll_thumb.dart
│  │  │     │  │        └─ pdf_widgets.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ linux
│  │  │     │  │  └─ CMakeLists.txt
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  ├─ screenshot.jpg
│  │  │     │  ├─ src
│  │  │     │  │  ├─ CMakeLists.txt
│  │  │     │  │  └─ pdfium_interop.cpp
│  │  │     │  ├─ test
│  │  │     │  │  ├─ pdf_document_test.dart
│  │  │     │  │  ├─ pdf_viewer_test.dart
│  │  │     │  │  ├─ setup.dart
│  │  │     │  │  └─ utils.dart
│  │  │     │  └─ windows
│  │  │     │     └─ CMakeLists.txt
│  │  │     ├─ shared_preferences_linux
│  │  │     │  ├─ AUTHORS
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ shared_preferences_test.dart
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  │  └─ generated_plugins.cmake
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  └─ test_driver
│  │  │     │  │     └─ integration_test.dart
│  │  │     │  ├─ lib
│  │  │     │  │  └─ shared_preferences_linux.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     ├─ fake_path_provider_linux.dart
│  │  │     │     ├─ legacy_shared_preferences_linux_test.dart
│  │  │     │     └─ shared_preferences_linux_async_test.dart
│  │  │     ├─ share_plus
│  │  │     │  ├─ android
│  │  │     │  │  ├─ build.gradle
│  │  │     │  │  ├─ gradle
│  │  │     │  │  │  └─ wrapper
│  │  │     │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  ├─ gradle.properties
│  │  │     │  │  ├─ settings.gradle
│  │  │     │  │  └─ src
│  │  │     │  │     └─ main
│  │  │     │  │        ├─ AndroidManifest.xml
│  │  │     │  │        ├─ kotlin
│  │  │     │  │        │  └─ dev
│  │  │     │  │        │     └─ fluttercommunity
│  │  │     │  │        │        └─ plus
│  │  │     │  │        │           └─ share
│  │  │     │  │        │              ├─ MethodCallHandler.kt
│  │  │     │  │        │              ├─ Share.kt
│  │  │     │  │        │              ├─ ShareFileProvider.kt
│  │  │     │  │        │              ├─ SharePlusPendingIntent.kt
│  │  │     │  │        │              ├─ SharePlusPlugin.kt
│  │  │     │  │        │              └─ ShareSuccessManager.kt
│  │  │     │  │        └─ res
│  │  │     │  │           └─ xml
│  │  │     │  │              └─ flutter_share_file_paths.xml
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ android
│  │  │     │  │  │  ├─ app
│  │  │     │  │  │  │  ├─ build.gradle
│  │  │     │  │  │  │  └─ src
│  │  │     │  │  │  │     └─ main
│  │  │     │  │  │  │        ├─ AndroidManifest.xml
│  │  │     │  │  │  │        ├─ java
│  │  │     │  │  │  │        │  └─ io
│  │  │     │  │  │  │        │     └─ flutter
│  │  │     │  │  │  │        │        └─ plugins
│  │  │     │  │  │  │        └─ res
│  │  │     │  │  │  │           ├─ mipmap-hdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-mdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           ├─ mipmap-xxhdpi
│  │  │     │  │  │  │           │  └─ ic_launcher.png
│  │  │     │  │  │  │           └─ mipmap-xxxhdpi
│  │  │     │  │  │  │              └─ ic_launcher.png
│  │  │     │  │  │  ├─ build.gradle
│  │  │     │  │  │  ├─ gradle
│  │  │     │  │  │  │  └─ wrapper
│  │  │     │  │  │  │     └─ gradle-wrapper.properties
│  │  │     │  │  │  ├─ gradle.properties
│  │  │     │  │  │  └─ settings.gradle
│  │  │     │  │  ├─ assets
│  │  │     │  │  │  └─ flutter_logo.png
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ share_plus_test.dart
│  │  │     │  │  ├─ ios
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
│  │  │     │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  └─ Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  ├─ AppIcon.appiconset
│  │  │     │  │  │  │  │  │  ├─ Contents.json
│  │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │     │  │  │  │  │  └─ LaunchImage.imageset
│  │  │     │  │  │  │  │     ├─ Contents.json
│  │  │     │  │  │  │  │     ├─ LaunchImage.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
│  │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
│  │  │     │  │  │  │  │     └─ README.md
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │     │  │  │  │  │  └─ Main.storyboard
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  └─ Runner-Bridging-Header.h
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     ├─ swiftpm
│  │  │     │  │  │  │     │  └─ configuration
│  │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  ├─ image_previews.dart
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  └─ CMakeLists.txt
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ macos
│  │  │     │  │  │  ├─ Flutter
│  │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │     │  │  │  │  └─ Flutter-Release.xcconfig
│  │  │     │  │  │  ├─ Runner
│  │  │     │  │  │  │  ├─ AppDelegate.swift
│  │  │     │  │  │  │  ├─ Assets.xcassets
│  │  │     │  │  │  │  │  └─ AppIcon.appiconset
│  │  │     │  │  │  │  │     ├─ app_icon_1024.png
│  │  │     │  │  │  │  │     ├─ app_icon_128.png
│  │  │     │  │  │  │  │     ├─ app_icon_16.png
│  │  │     │  │  │  │  │     ├─ app_icon_256.png
│  │  │     │  │  │  │  │     ├─ app_icon_32.png
│  │  │     │  │  │  │  │     ├─ app_icon_512.png
│  │  │     │  │  │  │  │     ├─ app_icon_64.png
│  │  │     │  │  │  │  │     └─ Contents.json
│  │  │     │  │  │  │  ├─ Base.lproj
│  │  │     │  │  │  │  │  └─ MainMenu.xib
│  │  │     │  │  │  │  ├─ Configs
│  │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
│  │  │     │  │  │  │  │  ├─ Debug.xcconfig
│  │  │     │  │  │  │  │  ├─ Release.xcconfig
│  │  │     │  │  │  │  │  └─ Warnings.xcconfig
│  │  │     │  │  │  │  ├─ DebugProfile.entitlements
│  │  │     │  │  │  │  ├─ Info.plist
│  │  │     │  │  │  │  ├─ MainFlutterWindow.swift
│  │  │     │  │  │  │  └─ Release.entitlements
│  │  │     │  │  │  ├─ Runner.xcodeproj
│  │  │     │  │  │  │  ├─ project.pbxproj
│  │  │     │  │  │  │  ├─ project.xcworkspace
│  │  │     │  │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │  │        └─ configuration
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     └─ xcschemes
│  │  │     │  │  │  │        └─ Runner.xcscheme
│  │  │     │  │  │  ├─ Runner.xcworkspace
│  │  │     │  │  │  │  ├─ contents.xcworkspacedata
│  │  │     │  │  │  │  └─ xcshareddata
│  │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     │  │  │  │     └─ swiftpm
│  │  │     │  │  │  │        └─ configuration
│  │  │     │  │  │  └─ RunnerTests
│  │  │     │  │  │     └─ RunnerTests.swift
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  ├─ test_driver
│  │  │     │  │  │  └─ share_plus_test.dart
│  │  │     │  │  ├─ web
│  │  │     │  │  │  ├─ favicon.png
│  │  │     │  │  │  ├─ icons
│  │  │     │  │  │  │  ├─ Icon-192.png
│  │  │     │  │  │  │  └─ Icon-512.png
│  │  │     │  │  │  ├─ index.html
│  │  │     │  │  │  └─ manifest.json
│  │  │     │  │  └─ windows
│  │  │     │  │     ├─ CMakeLists.txt
│  │  │     │  │     ├─ flutter
│  │  │     │  │     │  └─ CMakeLists.txt
│  │  │     │  │     └─ runner
│  │  │     │  │        ├─ CMakeLists.txt
│  │  │     │  │        ├─ flutter_window.cpp
│  │  │     │  │        ├─ flutter_window.h
│  │  │     │  │        ├─ main.cpp
│  │  │     │  │        ├─ resource.h
│  │  │     │  │        ├─ resources
│  │  │     │  │        │  └─ app_icon.ico
│  │  │     │  │        ├─ runner.exe.manifest
│  │  │     │  │        ├─ Runner.rc
│  │  │     │  │        ├─ run_loop.cpp
│  │  │     │  │        ├─ run_loop.h
│  │  │     │  │        ├─ utils.cpp
│  │  │     │  │        ├─ utils.h
│  │  │     │  │        ├─ win32_window.cpp
│  │  │     │  │        └─ win32_window.h
│  │  │     │  ├─ ios
│  │  │     │  │  ├─ share_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ share_plus
│  │  │     │  │  │        ├─ FPPSharePlusPlugin.m
│  │  │     │  │  │        ├─ include
│  │  │     │  │  │        │  └─ share_plus
│  │  │     │  │  │        │     └─ FPPSharePlusPlugin.h
│  │  │     │  │  │        └─ PrivacyInfo.xcprivacy
│  │  │     │  │  └─ share_plus.podspec
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ share_plus.dart
│  │  │     │  │  └─ src
│  │  │     │  │     ├─ share_plus_linux.dart
│  │  │     │  │     ├─ share_plus_macos.dart
│  │  │     │  │     ├─ share_plus_web.dart
│  │  │     │  │     ├─ share_plus_windows.dart
│  │  │     │  │     └─ windows_version_helper.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ macos
│  │  │     │  │  ├─ share_plus
│  │  │     │  │  │  ├─ Package.swift
│  │  │     │  │  │  └─ Sources
│  │  │     │  │  │     └─ share_plus
│  │  │     │  │  │        ├─ PrivacyInfo.xcprivacy
│  │  │     │  │  │        └─ SharePlusMacosPlugin.swift
│  │  │     │  │  └─ share_plus.podspec
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  ├─ test
│  │  │     │  │  ├─ share_plus_linux_test.dart
│  │  │     │  │  ├─ share_plus_windows_test.dart
│  │  │     │  │  └─ url_launcher_mock.dart
│  │  │     │  └─ windows
│  │  │     │     ├─ CMakeLists.txt
│  │  │     │     ├─ include
│  │  │     │     │  └─ share_plus
│  │  │     │     │     └─ share_plus_windows_plugin_c_api.h
│  │  │     │     ├─ share_plus_plugin.cpp
│  │  │     │     ├─ share_plus_plugin_c_api.cpp
│  │  │     │     ├─ share_plus_windows_plugin.h
│  │  │     │     └─ vector.h
│  │  │     ├─ url_launcher_linux
│  │  │     │  ├─ AUTHORS
│  │  │     │  ├─ CHANGELOG.md
│  │  │     │  ├─ example
│  │  │     │  │  ├─ integration_test
│  │  │     │  │  │  └─ url_launcher_test.dart
│  │  │     │  │  ├─ lib
│  │  │     │  │  │  └─ main.dart
│  │  │     │  │  ├─ linux
│  │  │     │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  ├─ flutter
│  │  │     │  │  │  │  ├─ CMakeLists.txt
│  │  │     │  │  │  │  └─ generated_plugins.cmake
│  │  │     │  │  │  ├─ main.cc
│  │  │     │  │  │  ├─ my_application.cc
│  │  │     │  │  │  └─ my_application.h
│  │  │     │  │  ├─ pubspec.yaml
│  │  │     │  │  ├─ README.md
│  │  │     │  │  └─ test_driver
│  │  │     │  │     └─ integration_test.dart
│  │  │     │  ├─ lib
│  │  │     │  │  ├─ src
│  │  │     │  │  │  └─ messages.g.dart
│  │  │     │  │  └─ url_launcher_linux.dart
│  │  │     │  ├─ LICENSE
│  │  │     │  ├─ linux
│  │  │     │  │  ├─ CMakeLists.txt
│  │  │     │  │  ├─ include
│  │  │     │  │  │  └─ url_launcher_linux
│  │  │     │  │  │     └─ url_launcher_plugin.h
│  │  │     │  │  ├─ messages.g.cc
│  │  │     │  │  ├─ messages.g.h
│  │  │     │  │  ├─ test
│  │  │     │  │  │  └─ url_launcher_linux_test.cc
│  │  │     │  │  ├─ url_launcher_plugin.cc
│  │  │     │  │  └─ url_launcher_plugin_private.h
│  │  │     │  ├─ pigeons
│  │  │     │  │  ├─ copyright.txt
│  │  │     │  │  └─ messages.dart
│  │  │     │  ├─ pubspec.yaml
│  │  │     │  ├─ README.md
│  │  │     │  └─ test
│  │  │     │     └─ url_launcher_linux_test.dart
│  │  │     └─ wakelock_plus
│  │  │        ├─ analysis_options.yaml
│  │  │        ├─ android
│  │  │        │  ├─ build.gradle
│  │  │        │  ├─ settings.gradle
│  │  │        │  └─ src
│  │  │        │     └─ main
│  │  │        │        ├─ AndroidManifest.xml
│  │  │        │        └─ kotlin
│  │  │        │           └─ dev
│  │  │        │              └─ fluttercommunity
│  │  │        │                 └─ plus
│  │  │        │                    └─ wakelock
│  │  │        │                       ├─ Wakelock.kt
│  │  │        │                       ├─ WakelockPlusMessages.g.kt
│  │  │        │                       └─ WakelockPlusPlugin.kt
│  │  │        ├─ assets
│  │  │        │  └─ no_sleep.js
│  │  │        ├─ CHANGELOG.md
│  │  │        ├─ example
│  │  │        │  ├─ analysis_options.yaml
│  │  │        │  ├─ android
│  │  │        │  │  ├─ app
│  │  │        │  │  │  ├─ build.gradle
│  │  │        │  │  │  └─ src
│  │  │        │  │  │     ├─ debug
│  │  │        │  │  │     │  └─ AndroidManifest.xml
│  │  │        │  │  │     ├─ main
│  │  │        │  │  │     │  ├─ AndroidManifest.xml
│  │  │        │  │  │     │  ├─ java
│  │  │        │  │  │     │  │  └─ io
│  │  │        │  │  │     │  │     └─ flutter
│  │  │        │  │  │     │  │        └─ plugins
│  │  │        │  │  │     │  ├─ kotlin
│  │  │        │  │  │     │  │  └─ dev
│  │  │        │  │  │     │  │     └─ fluttercommunity
│  │  │        │  │  │     │  │        └─ plus
│  │  │        │  │  │     │  │           └─ wakelock_example
│  │  │        │  │  │     │  │              └─ MainActivity.kt
│  │  │        │  │  │     │  └─ res
│  │  │        │  │  │     │     ├─ drawable
│  │  │        │  │  │     │     │  └─ launch_background.xml
│  │  │        │  │  │     │     ├─ drawable-v21
│  │  │        │  │  │     │     │  └─ launch_background.xml
│  │  │        │  │  │     │     ├─ mipmap-hdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-mdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xxhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ mipmap-xxxhdpi
│  │  │        │  │  │     │     │  └─ ic_launcher.png
│  │  │        │  │  │     │     ├─ values
│  │  │        │  │  │     │     │  └─ styles.xml
│  │  │        │  │  │     │     └─ values-night
│  │  │        │  │  │     │        └─ styles.xml
│  │  │        │  │  │     └─ profile
│  │  │        │  │  │        └─ AndroidManifest.xml
│  │  │        │  │  ├─ build.gradle
│  │  │        │  │  ├─ gradle
│  │  │        │  │  │  └─ wrapper
│  │  │        │  │  │     └─ gradle-wrapper.properties
│  │  │        │  │  ├─ gradle.properties
│  │  │        │  │  └─ settings.gradle
│  │  │        │  ├─ integration_test
│  │  │        │  │  └─ wakelock_plus_test.dart
│  │  │        │  ├─ ios
│  │  │        │  │  ├─ Flutter
│  │  │        │  │  │  ├─ AppFrameworkInfo.plist
│  │  │        │  │  │  ├─ Debug.xcconfig
│  │  │        │  │  │  └─ Release.xcconfig
│  │  │        │  │  ├─ Podfile
│  │  │        │  │  ├─ Podfile.lock
│  │  │        │  │  ├─ Runner
│  │  │        │  │  │  ├─ AppDelegate.h
│  │  │        │  │  │  ├─ AppDelegate.m
│  │  │        │  │  │  ├─ Assets.xcassets
│  │  │        │  │  │  │  ├─ AppIcon.appiconset
│  │  │        │  │  │  │  │  ├─ Contents.json
│  │  │        │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │        │  │  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │        │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │        │  │  │  │  └─ LaunchImage.imageset
│  │  │        │  │  │  │     ├─ Contents.json
│  │  │        │  │  │  │     ├─ LaunchImage.png
│  │  │        │  │  │  │     ├─ LaunchImage@2x.png
│  │  │        │  │  │  │     ├─ LaunchImage@3x.png
│  │  │        │  │  │  │     └─ README.md
│  │  │        │  │  │  ├─ Base.lproj
│  │  │        │  │  │  │  ├─ LaunchScreen.storyboard
│  │  │        │  │  │  │  └─ Main.storyboard
│  │  │        │  │  │  ├─ Info.plist
│  │  │        │  │  │  └─ main.m
│  │  │        │  │  ├─ Runner.xcodeproj
│  │  │        │  │  │  ├─ project.pbxproj
│  │  │        │  │  │  ├─ project.xcworkspace
│  │  │        │  │  │  │  ├─ contents.xcworkspacedata
│  │  │        │  │  │  │  └─ xcshareddata
│  │  │        │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │        │  │  │  │     ├─ swiftpm
│  │  │        │  │  │  │     │  └─ configuration
│  │  │        │  │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     └─ xcschemes
│  │  │        │  │  │        └─ Runner.xcscheme
│  │  │        │  │  ├─ Runner.xcworkspace
│  │  │        │  │  │  ├─ contents.xcworkspacedata
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │        │  │  │     ├─ swiftpm
│  │  │        │  │  │     │  └─ configuration
│  │  │        │  │  │     └─ WorkspaceSettings.xcsettings
│  │  │        │  │  └─ RunnerTests
│  │  │        │  │     └─ RunnerTests.m
│  │  │        │  ├─ lib
│  │  │        │  │  └─ main.dart
│  │  │        │  ├─ linux
│  │  │        │  │  ├─ CMakeLists.txt
│  │  │        │  │  ├─ flutter
│  │  │        │  │  │  ├─ CMakeLists.txt
│  │  │        │  │  │  ├─ generated_plugins.cmake
│  │  │        │  │  │  ├─ generated_plugin_registrant.cc
│  │  │        │  │  │  └─ generated_plugin_registrant.h
│  │  │        │  │  ├─ main.cc
│  │  │        │  │  ├─ my_application.cc
│  │  │        │  │  └─ my_application.h
│  │  │        │  ├─ macos
│  │  │        │  │  ├─ Flutter
│  │  │        │  │  │  ├─ Flutter-Debug.xcconfig
│  │  │        │  │  │  ├─ Flutter-Release.xcconfig
│  │  │        │  │  │  └─ GeneratedPluginRegistrant.swift
│  │  │        │  │  ├─ Podfile
│  │  │        │  │  ├─ Podfile.lock
│  │  │        │  │  ├─ Runner
│  │  │        │  │  │  ├─ AppDelegate.swift
│  │  │        │  │  │  ├─ Assets.xcassets
│  │  │        │  │  │  │  └─ AppIcon.appiconset
│  │  │        │  │  │  │     ├─ app_icon_1024.png
│  │  │        │  │  │  │     ├─ app_icon_128.png
│  │  │        │  │  │  │     ├─ app_icon_16.png
│  │  │        │  │  │  │     ├─ app_icon_256.png
│  │  │        │  │  │  │     ├─ app_icon_32.png
│  │  │        │  │  │  │     ├─ app_icon_512.png
│  │  │        │  │  │  │     ├─ app_icon_64.png
│  │  │        │  │  │  │     └─ Contents.json
│  │  │        │  │  │  ├─ Base.lproj
│  │  │        │  │  │  │  └─ MainMenu.xib
│  │  │        │  │  │  ├─ Configs
│  │  │        │  │  │  │  ├─ AppInfo.xcconfig
│  │  │        │  │  │  │  ├─ Debug.xcconfig
│  │  │        │  │  │  │  ├─ Release.xcconfig
│  │  │        │  │  │  │  └─ Warnings.xcconfig
│  │  │        │  │  │  ├─ DebugProfile.entitlements
│  │  │        │  │  │  ├─ Info.plist
│  │  │        │  │  │  ├─ MainFlutterWindow.swift
│  │  │        │  │  │  └─ Release.entitlements
│  │  │        │  │  ├─ Runner.xcodeproj
│  │  │        │  │  │  ├─ project.pbxproj
│  │  │        │  │  │  ├─ project.xcworkspace
│  │  │        │  │  │  │  └─ xcshareddata
│  │  │        │  │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │        │  │  │  │     └─ swiftpm
│  │  │        │  │  │  │        └─ configuration
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     └─ xcschemes
│  │  │        │  │  │        └─ Runner.xcscheme
│  │  │        │  │  ├─ Runner.xcworkspace
│  │  │        │  │  │  ├─ contents.xcworkspacedata
│  │  │        │  │  │  └─ xcshareddata
│  │  │        │  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │        │  │  │     └─ swiftpm
│  │  │        │  │  │        └─ configuration
│  │  │        │  │  └─ RunnerTests
│  │  │        │  │     └─ RunnerTests.swift
│  │  │        │  ├─ pubspec.yaml
│  │  │        │  ├─ README.md
│  │  │        │  ├─ test_driver
│  │  │        │  │  └─ integration_test.dart
│  │  │        │  ├─ web
│  │  │        │  │  ├─ favicon.png
│  │  │        │  │  ├─ icons
│  │  │        │  │  │  ├─ Icon-192.png
│  │  │        │  │  │  ├─ Icon-512.png
│  │  │        │  │  │  ├─ Icon-maskable-192.png
│  │  │        │  │  │  └─ Icon-maskable-512.png
│  │  │        │  │  ├─ index.html
│  │  │        │  │  └─ manifest.json
│  │  │        │  └─ windows
│  │  │        │     ├─ CMakeLists.txt
│  │  │        │     ├─ flutter
│  │  │        │     │  ├─ CMakeLists.txt
│  │  │        │     │  ├─ generated_plugins.cmake
│  │  │        │     │  ├─ generated_plugin_registrant.cc
│  │  │        │     │  └─ generated_plugin_registrant.h
│  │  │        │     └─ runner
│  │  │        │        ├─ CMakeLists.txt
│  │  │        │        ├─ flutter_window.cpp
│  │  │        │        ├─ flutter_window.h
│  │  │        │        ├─ main.cpp
│  │  │        │        ├─ resource.h
│  │  │        │        ├─ resources
│  │  │        │        │  └─ app_icon.ico
│  │  │        │        ├─ runner.exe.manifest
│  │  │        │        ├─ Runner.rc
│  │  │        │        ├─ utils.cpp
│  │  │        │        ├─ utils.h
│  │  │        │        ├─ win32_window.cpp
│  │  │        │        └─ win32_window.h
│  │  │        ├─ ios
│  │  │        │  ├─ wakelock_plus
│  │  │        │  │  ├─ Package.swift
│  │  │        │  │  └─ Sources
│  │  │        │  │     └─ wakelock_plus
│  │  │        │  │        ├─ include
│  │  │        │  │        │  └─ wakelock_plus
│  │  │        │  │        │     ├─ messages.g.h
│  │  │        │  │        │     ├─ UIApplication+idleTimerLock.h
│  │  │        │  │        │     └─ WakelockPlusPlugin.h
│  │  │        │  │        ├─ messages.g.m
│  │  │        │  │        ├─ Resources
│  │  │        │  │        │  └─ PrivacyInfo.xcprivacy
│  │  │        │  │        ├─ UIApplication+idleTimerLock.m
│  │  │        │  │        └─ WakelockPlusPlugin.m
│  │  │        │  └─ wakelock_plus.podspec
│  │  │        ├─ lib
│  │  │        │  ├─ src
│  │  │        │  │  ├─ wakelock_plus_io_plugin.dart
│  │  │        │  │  ├─ wakelock_plus_linux_plugin.dart
│  │  │        │  │  ├─ wakelock_plus_macos_plugin.dart
│  │  │        │  │  ├─ wakelock_plus_web_plugin.dart
│  │  │        │  │  ├─ wakelock_plus_windows_plugin.dart
│  │  │        │  │  └─ web_impl
│  │  │        │  │     ├─ import_js_library.dart
│  │  │        │  │     └─ js_wakelock.dart
│  │  │        │  └─ wakelock_plus.dart
│  │  │        ├─ LICENSE
│  │  │        ├─ macos
│  │  │        │  ├─ wakelock_plus
│  │  │        │  │  ├─ Package.swift
│  │  │        │  │  └─ Sources
│  │  │        │  │     └─ wakelock_plus
│  │  │        │  │        ├─ Resources
│  │  │        │  │        │  └─ PrivacyInfo.xcprivacy
│  │  │        │  │        └─ WakelockPlusMacosPlugin.swift
│  │  │        │  └─ wakelock_plus.podspec
│  │  │        ├─ pigeons
│  │  │        │  └─ messages.dart
│  │  │        ├─ pubspec.yaml
│  │  │        ├─ README.md
│  │  │        └─ test
│  │  │           ├─ wakelock_plus_test.dart
│  │  │           └─ wakelock_plus_web_plugin_test.dart
│  │  ├─ generated_plugins.cmake
│  │  ├─ generated_plugin_registrant.cc
│  │  └─ generated_plugin_registrant.h
│  └─ runner
│     ├─ CMakeLists.txt
│     ├─ main.cc
│     ├─ my_application.cc
│     └─ my_application.h
├─ macos
│  ├─ Flutter
│  │  ├─ ephemeral
│  │  │  ├─ Flutter-Generated.xcconfig
│  │  │  └─ flutter_export_environment.sh
│  │  ├─ Flutter-Debug.xcconfig
│  │  ├─ Flutter-Release.xcconfig
│  │  └─ GeneratedPluginRegistrant.swift
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  └─ AppIcon.appiconset
│  │  │     ├─ app_icon_1024.png
│  │  │     ├─ app_icon_128.png
│  │  │     ├─ app_icon_16.png
│  │  │     ├─ app_icon_256.png
│  │  │     ├─ app_icon_32.png
│  │  │     ├─ app_icon_512.png
│  │  │     ├─ app_icon_64.png
│  │  │     └─ Contents.json
│  │  ├─ Base.lproj
│  │  │  └─ MainMenu.xib
│  │  ├─ Configs
│  │  │  ├─ AppInfo.xcconfig
│  │  │  ├─ Debug.xcconfig
│  │  │  ├─ Release.xcconfig
│  │  │  └─ Warnings.xcconfig
│  │  ├─ DebugProfile.entitlements
│  │  ├─ Info.plist
│  │  ├─ MainFlutterWindow.swift
│  │  └─ Release.entitlements
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  └─ xcshareddata
│  │  │     └─ IDEWorkspaceChecks.plist
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  ├─ Runner.xcworkspace
│  │  ├─ contents.xcworkspacedata
│  │  └─ xcshareddata
│  │     └─ IDEWorkspaceChecks.plist
│  └─ RunnerTests
│     └─ RunnerTests.swift
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ test
│  └─ widget_test.dart
├─ web
│  ├─ favicon.png
│  ├─ icons
│  │  ├─ Icon-192.png
│  │  ├─ Icon-512.png
│  │  ├─ Icon-maskable-192.png
│  │  └─ Icon-maskable-512.png
│  ├─ index.html
│  └─ manifest.json
└─ windows
   ├─ CMakeLists.txt
   ├─ flutter
   │  ├─ CMakeLists.txt
   │  ├─ ephemeral
   │  │  └─ .plugin_symlinks
   │  │     ├─ cloud_firestore
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ local-config.gradle
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ firestore
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreException.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreExtension.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreMessageCodec.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestorePlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebaseFirestoreTransactionResult.java
   │  │     │  │  │                       ├─ GeneratedAndroidFirebaseFirestore.java
   │  │     │  │  │                       ├─ streamhandler
   │  │     │  │  │                       │  ├─ DocumentSnapshotsStreamHandler.java
   │  │     │  │  │                       │  ├─ LoadBundleStreamHandler.java
   │  │     │  │  │                       │  ├─ OnTransactionResultListener.java
   │  │     │  │  │                       │  ├─ QuerySnapshotsStreamHandler.java
   │  │     │  │  │                       │  ├─ SnapshotsInSyncStreamHandler.java
   │  │     │  │  │                       │  └─ TransactionStreamHandler.java
   │  │     │  │  │                       └─ utils
   │  │     │  │  │                          ├─ ExceptionConverter.java
   │  │     │  │  │                          ├─ PigeonParser.java
   │  │     │  │  │                          └─ ServerTimestampBehaviorConverter.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ dartpad
   │  │     │  │  ├─ dartpad_metadata.yaml
   │  │     │  │  └─ lib
   │  │     │  │     └─ main.dart
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebase
   │  │     │  │  │  │     │  │              └─ firestore
   │  │     │  │  │  │     │  │                 └─ example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ firebase.json
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  ├─ collection_reference_e2e.dart
   │  │     │  │  │  ├─ document_change_e2e.dart
   │  │     │  │  │  ├─ document_reference_e2e.dart
   │  │     │  │  │  ├─ e2e_test.dart
   │  │     │  │  │  ├─ field_value_e2e.dart
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  ├─ firebase_options_secondary.dart
   │  │     │  │  │  ├─ geo_point_e2e.dart
   │  │     │  │  │  ├─ instance_e2e.dart
   │  │     │  │  │  ├─ load_bundle_e2e.dart
   │  │     │  │  │  ├─ query_e2e.dart
   │  │     │  │  │  ├─ second_database.dart
   │  │     │  │  │  ├─ settings_e2e.dart
   │  │     │  │  │  ├─ snapshot_metadata_e2e.dart
   │  │     │  │  │  ├─ timestamp_e2e.dart
   │  │     │  │  │  ├─ transaction_e2e.dart
   │  │     │  │  │  ├─ vector_value_e2e.dart
   │  │     │  │  │  ├─ web_snapshot_listeners.dart
   │  │     │  │  │  └─ write_batch_e2e.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        ├─ swiftpm
   │  │     │  │  │        │  └─ configuration
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ swiftpm
   │  │     │  │  │  │        └─ configuration
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  ├─ manifest.json
   │  │     │  │  │  └─ wasm_index.html
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ cloud_firestore
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ cloud_firestore
   │  │     │  │  │        ├─ FirestoreMessages.g.m
   │  │     │  │  │        ├─ FirestorePigeonParser.m
   │  │     │  │  │        ├─ FLTDocumentSnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreExtension.m
   │  │     │  │  │        ├─ FLTFirebaseFirestorePlugin.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreReader.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreUtils.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreWriter.m
   │  │     │  │  │        ├─ FLTLoadBundleStreamHandler.m
   │  │     │  │  │        ├─ FLTQuerySnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTSnapshotsInSyncStreamHandler.m
   │  │     │  │  │        ├─ FLTTransactionStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ cloud_firestore
   │  │     │  │  │        │     ├─ Private
   │  │     │  │  │        │     │  ├─ FirestorePigeonParser.h
   │  │     │  │  │        │     │  ├─ FLTDocumentSnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreExtension.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreReader.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreUtils.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreWriter.h
   │  │     │  │  │        │     │  ├─ FLTLoadBundleStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTQuerySnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTSnapshotsInSyncStreamHandler.h
   │  │     │  │  │        │     │  └─ FLTTransactionStreamHandler.h
   │  │     │  │  │        │     └─ Public
   │  │     │  │  │        │        ├─ CustomPigeonHeaderFirestore.h
   │  │     │  │  │        │        ├─ FirestoreMessages.g.h
   │  │     │  │  │        │        └─ FLTFirebaseFirestorePlugin.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ cloud_firestore.podspec
   │  │     │  │  └─ generated_firebase_sdk_version.txt
   │  │     │  ├─ lib
   │  │     │  │  ├─ cloud_firestore.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ aggregate_query.dart
   │  │     │  │     ├─ aggregate_query_snapshot.dart
   │  │     │  │     ├─ collection_reference.dart
   │  │     │  │     ├─ document_change.dart
   │  │     │  │     ├─ document_reference.dart
   │  │     │  │     ├─ document_snapshot.dart
   │  │     │  │     ├─ field_value.dart
   │  │     │  │     ├─ filters.dart
   │  │     │  │     ├─ firestore.dart
   │  │     │  │     ├─ load_bundle_task.dart
   │  │     │  │     ├─ load_bundle_task_snapshot.dart
   │  │     │  │     ├─ persistent_cache_index_manager.dart
   │  │     │  │     ├─ query.dart
   │  │     │  │     ├─ query_document_snapshot.dart
   │  │     │  │     ├─ query_snapshot.dart
   │  │     │  │     ├─ snapshot_metadata.dart
   │  │     │  │     ├─ transaction.dart
   │  │     │  │     ├─ utils
   │  │     │  │     │  └─ codec_utility.dart
   │  │     │  │     └─ write_batch.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ cloud_firestore
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ cloud_firestore
   │  │     │  │  │        ├─ FirestoreMessages.g.m
   │  │     │  │  │        ├─ FirestorePigeonParser.m
   │  │     │  │  │        ├─ FLTDocumentSnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreExtension.m
   │  │     │  │  │        ├─ FLTFirebaseFirestorePlugin.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreReader.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreUtils.m
   │  │     │  │  │        ├─ FLTFirebaseFirestoreWriter.m
   │  │     │  │  │        ├─ FLTLoadBundleStreamHandler.m
   │  │     │  │  │        ├─ FLTQuerySnapshotStreamHandler.m
   │  │     │  │  │        ├─ FLTSnapshotsInSyncStreamHandler.m
   │  │     │  │  │        ├─ FLTTransactionStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ cloud_firestore
   │  │     │  │  │        │     ├─ Private
   │  │     │  │  │        │     │  ├─ FirestorePigeonParser.h
   │  │     │  │  │        │     │  ├─ FLTDocumentSnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreExtension.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreReader.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreUtils.h
   │  │     │  │  │        │     │  ├─ FLTFirebaseFirestoreWriter.h
   │  │     │  │  │        │     │  ├─ FLTLoadBundleStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTQuerySnapshotStreamHandler.h
   │  │     │  │  │        │     │  ├─ FLTSnapshotsInSyncStreamHandler.h
   │  │     │  │  │        │     │  └─ FLTTransactionStreamHandler.h
   │  │     │  │  │        │     └─ Public
   │  │     │  │  │        │        ├─ CustomPigeonHeaderFirestore.h
   │  │     │  │  │        │        ├─ FirestoreMessages.g.h
   │  │     │  │  │        │        └─ FLTFirebaseFirestorePlugin.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  └─ cloud_firestore.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ cloud_firestore_test.dart
   │  │     │  │  ├─ collection_reference_test.dart
   │  │     │  │  ├─ field_value_test.dart
   │  │     │  │  ├─ mock.dart
   │  │     │  │  ├─ query_test.dart
   │  │     │  │  └─ test_firestore_message_codec.dart
   │  │     │  └─ windows
   │  │     │     ├─ cloud_firestore_plugin.cpp
   │  │     │     ├─ cloud_firestore_plugin.h
   │  │     │     ├─ cloud_firestore_plugin_c_api.cpp
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firestore_codec.cpp
   │  │     │     ├─ firestore_codec.h
   │  │     │     ├─ include
   │  │     │     │  └─ cloud_firestore
   │  │     │     │     └─ cloud_firestore_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ plugin_version.h.in
   │  │     │     └─ test
   │  │     │        └─ cloud_firestore_plugin_test.cpp
   │  │     ├─ connectivity_plus
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ java
   │  │     │  │           └─ dev
   │  │     │  │              └─ fluttercommunity
   │  │     │  │                 └─ plus
   │  │     │  │                    └─ connectivity
   │  │     │  │                       ├─ Connectivity.java
   │  │     │  │                       ├─ ConnectivityBroadcastReceiver.java
   │  │     │  │                       ├─ ConnectivityMethodChannelHandler.java
   │  │     │  │                       └─ ConnectivityPlugin.java
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     └─ main
   │  │     │  │  │  │        ├─ AndroidManifest.xml
   │  │     │  │  │  │        ├─ java
   │  │     │  │  │  │        │  └─ io
   │  │     │  │  │  │        │     └─ flutter
   │  │     │  │  │  │        │        └─ plugins
   │  │     │  │  │  │        │           └─ connectivityexample
   │  │     │  │  │  │        │              └─ FlutterActivityTest.java
   │  │     │  │  │  │        └─ res
   │  │     │  │  │  │           ├─ mipmap-hdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-mdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xxhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           └─ mipmap-xxxhdpi
   │  │     │  │  │  │              └─ ic_launcher.png
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ connectivity_plus_test.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │     │  └─ configuration
   │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ swiftpm
   │  │     │  │  │  │        └─ configuration
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ connectivity_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ connectivity_plus
   │  │     │  │  │        ├─ ConnectivityPlusPlugin.swift
   │  │     │  │  │        ├─ ConnectivityProvider.swift
   │  │     │  │  │        ├─ PathMonitorConnectivityProvider.swift
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ connectivity_plus.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ connectivity_plus.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ connectivity_plus_linux.dart
   │  │     │  │     ├─ connectivity_plus_web.dart
   │  │     │  │     └─ web
   │  │     │  │        └─ dart_html_connectivity_plugin.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ connectivity_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ connectivity_plus
   │  │     │  │  │        ├─ ConnectivityPlusPlugin.swift
   │  │     │  │  │        ├─ ConnectivityProvider.swift
   │  │     │  │  │        ├─ PathMonitorConnectivityProvider.swift
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ connectivity_plus.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ connectivity_plus_linux_test.dart
   │  │     │  │  ├─ connectivity_plus_linux_test.mocks.dart
   │  │     │  │  └─ connectivity_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ connectivity_plus_plugin.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ connectivity_plus
   │  │     │     │     ├─ connectivity_plus_windows_plugin.h
   │  │     │     │     └─ network_manager.h
   │  │     │     └─ network_manager.cpp
   │  │     ├─ device_info_plus
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ kotlin
   │  │     │  │           └─ dev
   │  │     │  │              └─ fluttercommunity
   │  │     │  │                 └─ plus
   │  │     │  │                    └─ device_info
   │  │     │  │                       ├─ DeviceInfoPlusPlugin.kt
   │  │     │  │                       └─ MethodCallHandlerImpl.kt
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ deviceinfoexample
   │  │     │  │  │  │     │  │              └─ example
   │  │     │  │  │  │     │  │                 └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     └─ values
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ device_info_plus_test.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ pubspec_overrides.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  └─ Icon-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ Classes
   │  │     │  │  │  ├─ FPPDeviceInfoPlusPlugin.h
   │  │     │  │  │  └─ FPPDeviceInfoPlusPlugin.m
   │  │     │  │  └─ device_info_plus.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ device_info_plus.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ device_info_plus_linux.dart
   │  │     │  │     ├─ device_info_plus_macos.dart
   │  │     │  │     ├─ device_info_plus_web.dart
   │  │     │  │     ├─ device_info_plus_windows.dart
   │  │     │  │     └─ model
   │  │     │  │        ├─ android_device_info.dart
   │  │     │  │        ├─ ios_device_info.dart
   │  │     │  │        ├─ linux_device_info.dart
   │  │     │  │        ├─ macos_device_info.dart
   │  │     │  │        ├─ web_browser_info.dart
   │  │     │  │        └─ windows_device_info.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ Classes
   │  │     │  │  │  ├─ CwlSysctl.swift
   │  │     │  │  │  ├─ DeviceInfoPlusMacosPlugin.swift
   │  │     │  │  │  └─ SystemUUID.swift
   │  │     │  │  └─ device_info_plus.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ device_info_plus_linux_test.dart
   │  │     │     ├─ device_info_plus_web_test.dart
   │  │     │     ├─ device_info_plus_windows_test.dart
   │  │     │     └─ model
   │  │     │        ├─ android_device_info_fake.dart
   │  │     │        ├─ android_device_info_test.dart
   │  │     │        ├─ ios_device_info_test.dart
   │  │     │        ├─ linux_device_info_test.dart
   │  │     │        ├─ macos_device_info_test.dart
   │  │     │        ├─ web_browser_info_test.dart
   │  │     │        └─ windows_device_info_test.dart
   │  │     ├─ file_picker
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ java
   │  │     │  │           └─ com
   │  │     │  │              └─ mr
   │  │     │  │                 └─ flutter
   │  │     │  │                    └─ plugin
   │  │     │  │                       └─ filepicker
   │  │     │  │                          ├─ FileInfo.java
   │  │     │  │                          ├─ FilePickerDelegate.java
   │  │     │  │                          ├─ FilePickerPlugin.java
   │  │     │  │                          └─ FileUtils.java
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ CONTRIBUTING.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ com
   │  │     │  │  │  │     │  │     └─ mr
   │  │     │  │  │  │     │  │        └─ flutter
   │  │     │  │  │  │     │  │           └─ plugin
   │  │     │  │  │  │     │  │              └─ filepicker
   │  │     │  │  │  │     │  │                 └─ file_picker_example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ gpxgenerator_path.gpx
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ File.swift
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ main.m
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  ├─ main_desktop.dart
   │  │     │  │  │  └─ src
   │  │     │  │  │     └─ file_picker_demo.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  │  ├─ generated_plugins.cmake
   │  │     │  │  │  │  ├─ generated_plugin_registrant.cc
   │  │     │  │  │  │  └─ generated_plugin_registrant.h
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ screenshots
   │  │     │  │  │  ├─ example_android.gif
   │  │     │  │  │  ├─ example_ios.gif
   │  │     │  │  │  ├─ example_linux.gif
   │  │     │  │  │  ├─ example_macos.png
   │  │     │  │  │  └─ example_windows.gif
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  └─ Icon-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  ├─ generated_plugins.cmake
   │  │     │  │     │  ├─ generated_plugin_registrant.cc
   │  │     │  │     │  └─ generated_plugin_registrant.h
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ file_picker
   │  │     │  │  │  ├─ Package.resolved
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ file_picker
   │  │     │  │  │        ├─ FileInfo.m
   │  │     │  │  │        ├─ FilePickerPlugin.m
   │  │     │  │  │        ├─ FileUtils.m
   │  │     │  │  │        ├─ ImageUtils.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ file_picker
   │  │     │  │  │        │  │  ├─ FileInfo.h
   │  │     │  │  │        │  │  ├─ FilePickerPlugin.h
   │  │     │  │  │        │  │  ├─ FileUtils.h
   │  │     │  │  │        │  │  └─ ImageUtils.h
   │  │     │  │  │        │  ├─ file_picker-umbrella.h
   │  │     │  │  │        │  └─ file_picker.modulemap
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ file_picker.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ file_picker.dart
   │  │     │  │  ├─ src
   │  │     │  │  │  ├─ exceptions.dart
   │  │     │  │  │  ├─ file_picker.dart
   │  │     │  │  │  ├─ file_picker_io.dart
   │  │     │  │  │  ├─ file_picker_macos.dart
   │  │     │  │  │  ├─ file_picker_result.dart
   │  │     │  │  │  ├─ linux
   │  │     │  │  │  │  ├─ dialog_handler.dart
   │  │     │  │  │  │  ├─ file_picker_linux.dart
   │  │     │  │  │  │  ├─ kdialog_handler.dart
   │  │     │  │  │  │  └─ qarma_and_zenity_handler.dart
   │  │     │  │  │  ├─ platform_file.dart
   │  │     │  │  │  ├─ utils.dart
   │  │     │  │  │  └─ windows
   │  │     │  │  │     ├─ file_picker_windows.dart
   │  │     │  │  │     ├─ file_picker_windows_ffi_types.dart
   │  │     │  │  │     └─ file_picker_windows_stub.dart
   │  │     │  │  └─ _internal
   │  │     │  │     └─ file_picker_web.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ file_picker
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ file_picker
   │  │     │  │  │        ├─ FilePickerPlugin.swift
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ file_picker.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ common.dart
   │  │     │     ├─ file_picker_macos_test.dart
   │  │     │     ├─ file_picker_utils_test.dart
   │  │     │     ├─ file_picker_windows_test.dart
   │  │     │     ├─ linux
   │  │     │     │  ├─ dialog_handler_test.dart
   │  │     │     │  ├─ kdialog_handler_test.dart
   │  │     │     │  └─ qarma_and_zenity_handler_test.dart
   │  │     │     └─ test_files
   │  │     │        ├─ franz-michael-schneeberger-unsplash.jpg
   │  │     │        ├─ test.pdf
   │  │     │        └─ test.yml
   │  │     ├─ firebase_auth
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ auth
   │  │     │  │  │                       ├─ AuthStateChannelStreamHandler.java
   │  │     │  │  │                       ├─ Constants.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthPlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthPluginException.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebaseAuthUser.java
   │  │     │  │  │                       ├─ FlutterFirebaseMultiFactor.java
   │  │     │  │  │                       ├─ FlutterFirebaseTotpMultiFactor.java
   │  │     │  │  │                       ├─ FlutterFirebaseTotpSecret.java
   │  │     │  │  │                       ├─ GeneratedAndroidFirebaseAuth.java
   │  │     │  │  │                       ├─ IdTokenChannelStreamHandler.java
   │  │     │  │  │                       ├─ PhoneNumberVerificationStreamHandler.java
   │  │     │  │  │                       └─ PigeonParser.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebase
   │  │     │  │  │  │     │  │              └─ auth
   │  │     │  │  │  │     │  │                 └─ example
   │  │     │  │  │  │     │  │                    └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ main.m
   │  │     │  │  │  │  ├─ Runner-Bridging-Header.h
   │  │     │  │  │  │  └─ Runner.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ auth.dart
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  └─ profile.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ firebase_auth
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_auth
   │  │     │  │  │        ├─ firebase_auth_messages.g.m
   │  │     │  │  │        ├─ FLTAuthStateChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseAuthPlugin.m
   │  │     │  │  │        ├─ FLTIdTokenChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTPhoneNumberVerificationStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ Private
   │  │     │  │  │        │  │  ├─ FLTAuthStateChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTIdTokenChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTPhoneNumberVerificationStreamHandler.h
   │  │     │  │  │        │  │  └─ PigeonParser.h
   │  │     │  │  │        │  └─ Public
   │  │     │  │  │        │     ├─ CustomPigeonHeader.h
   │  │     │  │  │        │     ├─ firebase_auth_messages.g.h
   │  │     │  │  │        │     └─ FLTFirebaseAuthPlugin.h
   │  │     │  │  │        ├─ PigeonParser.m
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ firebase_auth.podspec
   │  │     │  │  └─ generated_firebase_sdk_version.txt
   │  │     │  ├─ lib
   │  │     │  │  ├─ firebase_auth.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ confirmation_result.dart
   │  │     │  │     ├─ firebase_auth.dart
   │  │     │  │     ├─ multi_factor.dart
   │  │     │  │     ├─ recaptcha_verifier.dart
   │  │     │  │     ├─ user.dart
   │  │     │  │     └─ user_credential.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ firebase_auth
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_auth
   │  │     │  │  │        ├─ firebase_auth_messages.g.m
   │  │     │  │  │        ├─ FLTAuthStateChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTFirebaseAuthPlugin.m
   │  │     │  │  │        ├─ FLTIdTokenChannelStreamHandler.m
   │  │     │  │  │        ├─ FLTPhoneNumberVerificationStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ Private
   │  │     │  │  │        │  │  ├─ FLTAuthStateChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTIdTokenChannelStreamHandler.h
   │  │     │  │  │        │  │  ├─ FLTPhoneNumberVerificationStreamHandler.h
   │  │     │  │  │        │  │  └─ PigeonParser.h
   │  │     │  │  │        │  └─ Public
   │  │     │  │  │        │     ├─ CustomPigeonHeader.h
   │  │     │  │  │        │     ├─ firebase_auth_messages.g.h
   │  │     │  │  │        │     └─ FLTFirebaseAuthPlugin.h
   │  │     │  │  │        ├─ PigeonParser.m
   │  │     │  │  │        └─ Resource
   │  │     │  │  └─ firebase_auth.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ firebase_auth_test.dart
   │  │     │  │  ├─ mock.dart
   │  │     │  │  └─ user_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firebase_auth_plugin.cpp
   │  │     │     ├─ firebase_auth_plugin.h
   │  │     │     ├─ firebase_auth_plugin_c_api.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ firebase_auth
   │  │     │     │     └─ firebase_auth_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ plugin_version.h.in
   │  │     │     └─ test
   │  │     │        └─ firebase_auth_plugin_test.cpp
   │  │     ├─ firebase_core
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ local-config.gradle
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ core
   │  │     │  │  │                       ├─ FlutterFirebaseCorePlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseCoreRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebasePlugin.java
   │  │     │  │  │                       ├─ FlutterFirebasePluginRegistry.java
   │  │     │  │  │                       └─ GeneratedAndroidFirebaseCore.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebasecoreexample
   │  │     │  │  │  │     │  │              └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ main.m
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        └─ IDEWorkspaceChecks.plist
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ firebase_core
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_core
   │  │     │  │  │        ├─ dummy.m
   │  │     │  │  │        ├─ FLTFirebaseCorePlugin.m
   │  │     │  │  │        ├─ FLTFirebasePlugin.m
   │  │     │  │  │        ├─ FLTFirebasePluginRegistry.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ firebase_core
   │  │     │  │  │        │     ├─ dummy.h
   │  │     │  │  │        │     ├─ FLTFirebaseCorePlugin.h
   │  │     │  │  │        │     ├─ FLTFirebasePlugin.h
   │  │     │  │  │        │     ├─ FLTFirebasePluginRegistry.h
   │  │     │  │  │        │     └─ messages.g.h
   │  │     │  │  │        ├─ messages.g.m
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ firebase_core.podspec
   │  │     │  │  └─ firebase_sdk_version.rb
   │  │     │  ├─ lib
   │  │     │  │  ├─ firebase_core.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ firebase.dart
   │  │     │  │     ├─ firebase_app.dart
   │  │     │  │     └─ port_mapping.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ firebase_core
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_core
   │  │     │  │  │        ├─ dummy.m
   │  │     │  │  │        ├─ FLTFirebaseCorePlugin.m
   │  │     │  │  │        ├─ FLTFirebasePlugin.m
   │  │     │  │  │        ├─ FLTFirebasePluginRegistry.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ dummy.h
   │  │     │  │  │        │  └─ firebase_core
   │  │     │  │  │        │     ├─ FLTFirebaseCorePlugin.h
   │  │     │  │  │        │     ├─ FLTFirebasePlugin.h
   │  │     │  │  │        │     ├─ FLTFirebasePluginRegistry.h
   │  │     │  │  │        │     └─ messages.g.h
   │  │     │  │  │        ├─ messages.g.m
   │  │     │  │  │        └─ Resources
   │  │     │  │  └─ firebase_core.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  └─ firebase_core_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firebase_core_plugin.cpp
   │  │     │     ├─ firebase_core_plugin.h
   │  │     │     ├─ firebase_core_plugin_c_api.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ firebase_core
   │  │     │     │     └─ firebase_core_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     └─ plugin_version.h.in
   │  │     ├─ firebase_storage
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ local-config.gradle
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     ├─ AndroidManifest.xml
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ io
   │  │     │  │  │           └─ flutter
   │  │     │  │  │              └─ plugins
   │  │     │  │  │                 └─ firebase
   │  │     │  │  │                    └─ storage
   │  │     │  │  │                       ├─ FlutterFirebaseAppRegistrar.java
   │  │     │  │  │                       ├─ FlutterFirebaseStorageException.java
   │  │     │  │  │                       ├─ FlutterFirebaseStoragePlugin.java
   │  │     │  │  │                       ├─ FlutterFirebaseStorageTask.java
   │  │     │  │  │                       ├─ GeneratedAndroidFirebaseStorage.java
   │  │     │  │  │                       └─ TaskStateChannelStreamHandler.java
   │  │     │  │  └─ user-agent.gradle
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ google-services.json
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  │           └─ firebasestorageexample
   │  │     │  │  │  │     │  │              └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ assets
   │  │     │  │  │  └─ hello.txt
   │  │     │  │  ├─ cors.json
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.h
   │  │     │  │  │  │  ├─ AppDelegate.m
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │     ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │     ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │     ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │     ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │     ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │     ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │     ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │     ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │     ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │     ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │     ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │     ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │     └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ main.m
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        └─ IDEWorkspaceChecks.plist
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ firebase_options.dart
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  └─ save_as
   │  │     │  │  │     ├─ save_as.dart
   │  │     │  │  │     ├─ save_as_html.dart
   │  │     │  │  │     └─ save_as_interface.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ firebase_app_id_file.json
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ GoogleService-Info.plist
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        └─ IDEWorkspaceChecks.plist
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ firebase_storage
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_storage
   │  │     │  │  │        ├─ firebase_storage_messages.g.m
   │  │     │  │  │        ├─ FLTFirebaseStoragePlugin.m
   │  │     │  │  │        ├─ FLTTaskStateChannelStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ firebase_storage_messages.g.h
   │  │     │  │  │        │  ├─ FLTFirebaseStoragePlugin.h
   │  │     │  │  │        │  └─ FLTTaskStateChannelStreamHandler.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  ├─ firebase_storage.podspec
   │  │     │  │  └─ generated_firebase_sdk_version.txt
   │  │     │  ├─ lib
   │  │     │  │  ├─ firebase_storage.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ firebase_storage.dart
   │  │     │  │     ├─ list_result.dart
   │  │     │  │     ├─ reference.dart
   │  │     │  │     ├─ task.dart
   │  │     │  │     ├─ task_snapshot.dart
   │  │     │  │     └─ utils.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ firebase_storage
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ firebase_storage
   │  │     │  │  │        ├─ firebase_storage_messages.g.m
   │  │     │  │  │        ├─ FLTFirebaseStoragePlugin.m
   │  │     │  │  │        ├─ FLTTaskStateChannelStreamHandler.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  ├─ firebase_storage_messages.g.h
   │  │     │  │  │        │  ├─ FLTFirebaseStoragePlugin.h
   │  │     │  │  │        │  └─ FLTTaskStateChannelStreamHandler.h
   │  │     │  │  │        └─ Resources
   │  │     │  │  └─ firebase_storage.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ firebase_storage_test.dart
   │  │     │  │  ├─ list_result_test.dart
   │  │     │  │  ├─ mock.dart
   │  │     │  │  ├─ reference_test.dart
   │  │     │  │  ├─ task_snapshot_test.dart
   │  │     │  │  ├─ task_test.dart
   │  │     │  │  └─ utils_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ firebase_storage_plugin.cpp
   │  │     │     ├─ firebase_storage_plugin.h
   │  │     │     ├─ firebase_storage_plugin_c_api.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ firebase_storage
   │  │     │     │     └─ firebase_storage_plugin_c_api.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     └─ plugin_version.h.in
   │  │     ├─ flutter_tts
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ kotlin
   │  │     │  │           └─ com
   │  │     │  │              └─ eyedeadevelopment
   │  │     │  │                 └─ fluttertts
   │  │     │  │                    └─ FlutterTtsPlugin.kt
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ CODE_OF_CONDUCT.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     └─ values
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  ├─ settings.gradle
   │  │     │  │  │  └─ settings_aar.gradle
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  ├─ ephemeral
   │  │     │  │  │  │  │  ├─ flutter_lldbinit
   │  │     │  │  │  │  │  └─ flutter_lldb_helper.py
   │  │     │  │  │  │  ├─ Flutter.podspec
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        ├─ swiftpm
   │  │     │  │  │        │  └─ configuration
   │  │     │  │  │        └─ WorkspaceSettings.xcsettings
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ language_helper.dart
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  ├─ non_web_language_helper.dart
   │  │     │  │  │  └─ web_language_helper.dart
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │        └─ swiftpm
   │  │     │  │  │           └─ configuration
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test
   │  │     │  │  │  └─ widget_test.dart
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  └─ Icon-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  ├─ windows
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  └─ runner
   │  │     │  │  │     ├─ CMakeLists.txt
   │  │     │  │  │     ├─ flutter_window.cpp
   │  │     │  │  │     ├─ flutter_window.h
   │  │     │  │  │     ├─ main.cpp
   │  │     │  │  │     ├─ resource.h
   │  │     │  │  │     ├─ resources
   │  │     │  │  │     │  └─ app_icon.ico
   │  │     │  │  │     ├─ runner.exe.manifest
   │  │     │  │  │     ├─ Runner.rc
   │  │     │  │  │     ├─ utils.cpp
   │  │     │  │  │     ├─ utils.h
   │  │     │  │  │     ├─ win32_window.cpp
   │  │     │  │  │     └─ win32_window.h
   │  │     │  │  └─ winuwp
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ flutter_windows.h
   │  │     │  │     ├─ project_version
   │  │     │  │     └─ runner_uwp
   │  │     │  │        ├─ appxmanifest.in
   │  │     │  │        ├─ Assets
   │  │     │  │        │  ├─ LargeTile.scale-100.png
   │  │     │  │        │  ├─ LargeTile.scale-125.png
   │  │     │  │        │  ├─ LargeTile.scale-150.png
   │  │     │  │        │  ├─ LargeTile.scale-200.png
   │  │     │  │        │  ├─ LargeTile.scale-400.png
   │  │     │  │        │  ├─ LockScreenLogo.scale-200.png
   │  │     │  │        │  ├─ SmallTile.scale-100.png
   │  │     │  │        │  ├─ SmallTile.scale-125.png
   │  │     │  │        │  ├─ SmallTile.scale-150.png
   │  │     │  │        │  ├─ SmallTile.scale-200.png
   │  │     │  │        │  ├─ SmallTile.scale-400.png
   │  │     │  │        │  ├─ SplashScreen.scale-100.png
   │  │     │  │        │  ├─ SplashScreen.scale-125.png
   │  │     │  │        │  ├─ SplashScreen.scale-150.png
   │  │     │  │        │  ├─ SplashScreen.scale-200.png
   │  │     │  │        │  ├─ SplashScreen.scale-400.png
   │  │     │  │        │  ├─ Square150x150Logo.scale-100.png
   │  │     │  │        │  ├─ Square150x150Logo.scale-125.png
   │  │     │  │        │  ├─ Square150x150Logo.scale-150.png
   │  │     │  │        │  ├─ Square150x150Logo.scale-200.png
   │  │     │  │        │  ├─ Square150x150Logo.scale-400.png
   │  │     │  │        │  ├─ Square44x44Logo.altform-unplated_targetsize-16.png
   │  │     │  │        │  ├─ Square44x44Logo.altform-unplated_targetsize-256.png
   │  │     │  │        │  ├─ Square44x44Logo.altform-unplated_targetsize-32.png
   │  │     │  │        │  ├─ Square44x44Logo.altform-unplated_targetsize-48.png
   │  │     │  │        │  ├─ Square44x44Logo.scale-100.png
   │  │     │  │        │  ├─ Square44x44Logo.scale-125.png
   │  │     │  │        │  ├─ Square44x44Logo.scale-150.png
   │  │     │  │        │  ├─ Square44x44Logo.scale-200.png
   │  │     │  │        │  ├─ Square44x44Logo.scale-400.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-16.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-24.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-24_altform-unplated.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-256.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-32.png
   │  │     │  │        │  ├─ Square44x44Logo.targetsize-48.png
   │  │     │  │        │  ├─ StoreLogo.png
   │  │     │  │        │  ├─ StoreLogo.scale-100.png
   │  │     │  │        │  ├─ StoreLogo.scale-125.png
   │  │     │  │        │  ├─ StoreLogo.scale-150.png
   │  │     │  │        │  ├─ StoreLogo.scale-200.png
   │  │     │  │        │  ├─ StoreLogo.scale-400.png
   │  │     │  │        │  ├─ Wide310x150Logo.scale-200.png
   │  │     │  │        │  ├─ WideTile.scale-100.png
   │  │     │  │        │  ├─ WideTile.scale-125.png
   │  │     │  │        │  ├─ WideTile.scale-150.png
   │  │     │  │        │  ├─ WideTile.scale-200.png
   │  │     │  │        │  └─ WideTile.scale-400.png
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ CMakeSettings.json
   │  │     │  │        ├─ flutter_frameworkview.cpp
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resources.pri
   │  │     │  │        └─ Windows_TemporaryKey.pfx
   │  │     │  ├─ gen
   │  │     │  ├─ ios
   │  │     │  │  ├─ Assets
   │  │     │  │  ├─ Classes
   │  │     │  │  │  ├─ AudioCategory.swift
   │  │     │  │  │  ├─ AudioCategoryOptions.swift
   │  │     │  │  │  ├─ AudioModes.swift
   │  │     │  │  │  ├─ FlutterTtsPlugin.h
   │  │     │  │  │  ├─ FlutterTtsPlugin.m
   │  │     │  │  │  └─ SwiftFlutterTtsPlugin.swift
   │  │     │  │  └─ flutter_tts.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ flutter_tts.dart
   │  │     │  │  ├─ flutter_tts_web.dart
   │  │     │  │  └─ interop_types.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ Classes
   │  │     │  │  │  └─ FlutterTtsPlugin.swift
   │  │     │  │  └─ flutter_tts.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ flutter_tts_plugin.cpp
   │  │     │     └─ include
   │  │     │        └─ flutter_tts
   │  │     │           └─ flutter_tts_plugin.h
   │  │     ├─ jni
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ android
   │  │     │  │  ├─ .cxx
   │  │     │  │  │  ├─ Debug
   │  │     │  │  │  │  └─ 1s4e134i
   │  │     │  │  │  │     ├─ arm64-v8a
   │  │     │  │  │  │     │  ├─ .cmake
   │  │     │  │  │  │     │  │  └─ api
   │  │     │  │  │  │     │  │     └─ v1
   │  │     │  │  │  │     │  │        ├─ query
   │  │     │  │  │  │     │  │        │  └─ client-agp
   │  │     │  │  │  │     │  │        │     ├─ cache-v2
   │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
   │  │     │  │  │  │     │  │        │     └─ codemodel-v2
   │  │     │  │  │  │     │  │        └─ reply
   │  │     │  │  │  │     │  │           ├─ cache-v2-a839d37ee8ea17f34a74.json
   │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-87f2a19eae4dcab5e0a3.json
   │  │     │  │  │  │     │  │           ├─ codemodel-v2-3e5f840cd01b7e4e7627.json
   │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
   │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-33-0869.json
   │  │     │  │  │  │     │  │           └─ target-jni-Debug-e2f2b42aa99ddc3d67fa.json
   │  │     │  │  │  │     │  ├─ .ninja_deps
   │  │     │  │  │  │     │  ├─ .ninja_log
   │  │     │  │  │  │     │  ├─ additional_project_files.txt
   │  │     │  │  │  │     │  ├─ android_gradle_build.json
   │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
   │  │     │  │  │  │     │  ├─ build.ninja
   │  │     │  │  │  │     │  ├─ build_file_index.txt
   │  │     │  │  │  │     │  ├─ CMakeCache.txt
   │  │     │  │  │  │     │  ├─ CMakeFiles
   │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
   │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
   │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
   │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
   │  │     │  │  │  │     │  │  │  └─ CompilerIdC
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
   │  │     │  │  │  │     │  │  │     └─ tmp
   │  │     │  │  │  │     │  │  ├─ cmake.check_cache
   │  │     │  │  │  │     │  │  ├─ CMakeTmp
   │  │     │  │  │  │     │  │  ├─ jni.dir
   │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
   │  │     │  │  │  │     │  │  │  ├─ include
   │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
   │  │     │  │  │  │     │  │  │  └─ third_party
   │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
   │  │     │  │  │  │     │  │  ├─ rules.ninja
   │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
   │  │     │  │  │  │     │  ├─ cmake_install.cmake
   │  │     │  │  │  │     │  ├─ compile_commands.json
   │  │     │  │  │  │     │  ├─ compile_commands.json.bin
   │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
   │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
   │  │     │  │  │  │     │  ├─ prefab_config.json
   │  │     │  │  │  │     │  └─ symbol_folder_index.txt
   │  │     │  │  │  │     ├─ armeabi-v7a
   │  │     │  │  │  │     │  ├─ .cmake
   │  │     │  │  │  │     │  │  └─ api
   │  │     │  │  │  │     │  │     └─ v1
   │  │     │  │  │  │     │  │        ├─ query
   │  │     │  │  │  │     │  │        │  └─ client-agp
   │  │     │  │  │  │     │  │        │     ├─ cache-v2
   │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
   │  │     │  │  │  │     │  │        │     └─ codemodel-v2
   │  │     │  │  │  │     │  │        └─ reply
   │  │     │  │  │  │     │  │           ├─ cache-v2-5666089e635e5344d90c.json
   │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-6c4c8f4bc739a7188064.json
   │  │     │  │  │  │     │  │           ├─ codemodel-v2-f0d65234abc65f416dd9.json
   │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
   │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-35-0860.json
   │  │     │  │  │  │     │  │           └─ target-jni-Debug-801cad15e0c2d51bc8d3.json
   │  │     │  │  │  │     │  ├─ .ninja_deps
   │  │     │  │  │  │     │  ├─ .ninja_log
   │  │     │  │  │  │     │  ├─ additional_project_files.txt
   │  │     │  │  │  │     │  ├─ android_gradle_build.json
   │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
   │  │     │  │  │  │     │  ├─ build.ninja
   │  │     │  │  │  │     │  ├─ build_file_index.txt
   │  │     │  │  │  │     │  ├─ CMakeCache.txt
   │  │     │  │  │  │     │  ├─ CMakeFiles
   │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
   │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
   │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
   │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
   │  │     │  │  │  │     │  │  │  └─ CompilerIdC
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
   │  │     │  │  │  │     │  │  │     └─ tmp
   │  │     │  │  │  │     │  │  ├─ cmake.check_cache
   │  │     │  │  │  │     │  │  ├─ CMakeTmp
   │  │     │  │  │  │     │  │  ├─ jni.dir
   │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
   │  │     │  │  │  │     │  │  │  ├─ include
   │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
   │  │     │  │  │  │     │  │  │  └─ third_party
   │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
   │  │     │  │  │  │     │  │  ├─ rules.ninja
   │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
   │  │     │  │  │  │     │  ├─ cmake_install.cmake
   │  │     │  │  │  │     │  ├─ compile_commands.json
   │  │     │  │  │  │     │  ├─ compile_commands.json.bin
   │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
   │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
   │  │     │  │  │  │     │  ├─ prefab_config.json
   │  │     │  │  │  │     │  └─ symbol_folder_index.txt
   │  │     │  │  │  │     ├─ hash_key.txt
   │  │     │  │  │  │     ├─ x86
   │  │     │  │  │  │     │  ├─ .cmake
   │  │     │  │  │  │     │  │  └─ api
   │  │     │  │  │  │     │  │     └─ v1
   │  │     │  │  │  │     │  │        ├─ query
   │  │     │  │  │  │     │  │        │  └─ client-agp
   │  │     │  │  │  │     │  │        │     ├─ cache-v2
   │  │     │  │  │  │     │  │        │     ├─ cmakeFiles-v1
   │  │     │  │  │  │     │  │        │     └─ codemodel-v2
   │  │     │  │  │  │     │  │        └─ reply
   │  │     │  │  │  │     │  │           ├─ cache-v2-ce908d41b1252033e926.json
   │  │     │  │  │  │     │  │           ├─ cmakeFiles-v1-2bb796cc6a454960e08e.json
   │  │     │  │  │  │     │  │           ├─ codemodel-v2-caba4437fd3cefe0f8c1.json
   │  │     │  │  │  │     │  │           ├─ directory-.-Debug-d0094a50bb2071803777.json
   │  │     │  │  │  │     │  │           ├─ index-2026-04-22T12-02-37-0525.json
   │  │     │  │  │  │     │  │           └─ target-jni-Debug-ef73d009b6013e3a8fc4.json
   │  │     │  │  │  │     │  ├─ .ninja_deps
   │  │     │  │  │  │     │  ├─ .ninja_log
   │  │     │  │  │  │     │  ├─ additional_project_files.txt
   │  │     │  │  │  │     │  ├─ android_gradle_build.json
   │  │     │  │  │  │     │  ├─ android_gradle_build_mini.json
   │  │     │  │  │  │     │  ├─ build.ninja
   │  │     │  │  │  │     │  ├─ build_file_index.txt
   │  │     │  │  │  │     │  ├─ CMakeCache.txt
   │  │     │  │  │  │     │  ├─ CMakeFiles
   │  │     │  │  │  │     │  │  ├─ 3.22.1-g37088a8-dirty
   │  │     │  │  │  │     │  │  │  ├─ CMakeCCompiler.cmake
   │  │     │  │  │  │     │  │  │  ├─ CMakeDetermineCompilerABI_C.bin
   │  │     │  │  │  │     │  │  │  ├─ CMakeSystem.cmake
   │  │     │  │  │  │     │  │  │  └─ CompilerIdC
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.c
   │  │     │  │  │  │     │  │  │     ├─ CMakeCCompilerId.o
   │  │     │  │  │  │     │  │  │     └─ tmp
   │  │     │  │  │  │     │  │  ├─ cmake.check_cache
   │  │     │  │  │  │     │  │  ├─ CMakeTmp
   │  │     │  │  │  │     │  │  ├─ jni.dir
   │  │     │  │  │  │     │  │  │  ├─ dartjni.c.o
   │  │     │  │  │  │     │  │  │  ├─ include
   │  │     │  │  │  │     │  │  │  │  └─ dart_api_dl.c.o
   │  │     │  │  │  │     │  │  │  └─ third_party
   │  │     │  │  │  │     │  │  │     └─ global_jni_env.c.o
   │  │     │  │  │  │     │  │  ├─ rules.ninja
   │  │     │  │  │  │     │  │  └─ TargetDirectories.txt
   │  │     │  │  │  │     │  ├─ cmake_install.cmake
   │  │     │  │  │  │     │  ├─ compile_commands.json
   │  │     │  │  │  │     │  ├─ compile_commands.json.bin
   │  │     │  │  │  │     │  ├─ configure_fingerprint.bin
   │  │     │  │  │  │     │  ├─ metadata_generation_command.txt
   │  │     │  │  │  │     │  ├─ prefab_config.json
   │  │     │  │  │  │     │  └─ symbol_folder_index.txt
   │  │     │  │  │  │     └─ x86_64
   │  │     │  │  │  │        ├─ .cmake
   │  │     │  │  │  │        │  └─ api
   │  │     │  │  │  │        │     └─ v1
   │  │     │  │  │  │        │        ├─ query
   │  │     │  │  │  │        │        │  └─ client-agp
   │  │     │  │  │  │        │        │     ├─ cache-v2
   │  │     │  │  │  │        │        │     ├─ cmakeFiles-v1
   │  │     │  │  │  │        │        │     └─ codemodel-v2
   │  │     │  │  │  │        │        └─ reply
   │  │     │  │  │  │        │           ├─ cache-v2-840facfb3fe94a748fb5.json
   │  │     │  │  │  │        │           ├─ cmakeFiles-v1-1dc2a214dc0492f110c2.json
   │  │     │  │  │  │        │           ├─ codemodel-v2-d9e1128f36c8064fe0e5.json
   │  │     │  │  │  │        │           ├─ directory-.-Debug-d0094a50bb2071803777.json
   │  │     │  │  │  │        │           ├─ index-2026-04-22T12-02-39-0272.json
   │  │     │  │  │  │        │           └─ target-jni-Debug-0997099afe667e77ee8d.json
   │  │     │  │  │  │        ├─ .ninja_deps
   │  │     │  │  │  │        ├─ .ninja_log
   │  │     │  │  │  │        ├─ additional_project_files.txt
   │  │     │  │  │  │        ├─ android_gradle_build.json
   │  │     │  │  │  │        ├─ android_gradle_build_mini.json
   │  │     │  │  │  │        ├─ build.ninja
   │  │     │  │  │  │        ├─ build_file_index.txt
   │  │     │  │  │  │        ├─ CMakeCache.txt
   │  │     │  │  │  │        ├─ CMakeFiles
   │  │     │  │  │  │        │  ├─ 3.22.1-g37088a8-dirty
   │  │     │  │  │  │        │  │  ├─ CMakeCCompiler.cmake
   │  │     │  │  │  │        │  │  ├─ CMakeDetermineCompilerABI_C.bin
   │  │     │  │  │  │        │  │  ├─ CMakeSystem.cmake
   │  │     │  │  │  │        │  │  └─ CompilerIdC
   │  │     │  │  │  │        │  │     ├─ CMakeCCompilerId.c
   │  │     │  │  │  │        │  │     ├─ CMakeCCompilerId.o
   │  │     │  │  │  │        │  │     └─ tmp
   │  │     │  │  │  │        │  ├─ cmake.check_cache
   │  │     │  │  │  │        │  ├─ CMakeTmp
   │  │     │  │  │  │        │  ├─ jni.dir
   │  │     │  │  │  │        │  │  ├─ dartjni.c.o
   │  │     │  │  │  │        │  │  ├─ include
   │  │     │  │  │  │        │  │  │  └─ dart_api_dl.c.o
   │  │     │  │  │  │        │  │  └─ third_party
   │  │     │  │  │  │        │  │     └─ global_jni_env.c.o
   │  │     │  │  │  │        │  ├─ rules.ninja
   │  │     │  │  │  │        │  └─ TargetDirectories.txt
   │  │     │  │  │  │        ├─ cmake_install.cmake
   │  │     │  │  │  │        ├─ compile_commands.json
   │  │     │  │  │  │        ├─ compile_commands.json.bin
   │  │     │  │  │  │        ├─ configure_fingerprint.bin
   │  │     │  │  │  │        ├─ metadata_generation_command.txt
   │  │     │  │  │  │        ├─ prefab_config.json
   │  │     │  │  │  │        └─ symbol_folder_index.txt
   │  │     │  │  │  └─ tools
   │  │     │  │  │     └─ profile
   │  │     │  │  │        ├─ arm64-v8a
   │  │     │  │  │        │  └─ compile_commands.json
   │  │     │  │  │        ├─ armeabi-v7a
   │  │     │  │  │        │  └─ compile_commands.json
   │  │     │  │  │        ├─ x86
   │  │     │  │  │        │  └─ compile_commands.json
   │  │     │  │  │        └─ x86_64
   │  │     │  │  │           └─ compile_commands.json
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ consumer-rules.pro
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ java
   │  │     │  │           └─ com
   │  │     │  │              └─ github
   │  │     │  │                 └─ dart_lang
   │  │     │  │                    └─ jni
   │  │     │  │                       └─ JniPlugin.java
   │  │     │  ├─ bin
   │  │     │  │  └─ setup.dart
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ dart_test.yaml
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ debug
   │  │     │  │  │  │     │  └─ AndroidManifest.xml
   │  │     │  │  │  │     ├─ main
   │  │     │  │  │  │     │  ├─ AndroidManifest.xml
   │  │     │  │  │  │     │  ├─ java
   │  │     │  │  │  │     │  │  ├─ com
   │  │     │  │  │  │     │  │  │  └─ github
   │  │     │  │  │  │     │  │  │     └─ dart_lang
   │  │     │  │  │  │     │  │  │        └─ jni_example
   │  │     │  │  │  │     │  │  │           └─ Toaster.java
   │  │     │  │  │  │     │  │  └─ io
   │  │     │  │  │  │     │  │     └─ flutter
   │  │     │  │  │  │     │  │        └─ plugins
   │  │     │  │  │  │     │  ├─ kotlin
   │  │     │  │  │  │     │  │  └─ dev
   │  │     │  │  │  │     │  │     └─ dart
   │  │     │  │  │  │     │  │        └─ jni_example
   │  │     │  │  │  │     │  │           └─ MainActivity.kt
   │  │     │  │  │  │     │  └─ res
   │  │     │  │  │  │     │     ├─ drawable
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ drawable-v21
   │  │     │  │  │  │     │     │  └─ launch_background.xml
   │  │     │  │  │  │     │     ├─ mipmap-hdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-mdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ mipmap-xxxhdpi
   │  │     │  │  │  │     │     │  └─ ic_launcher.png
   │  │     │  │  │  │     │     ├─ values
   │  │     │  │  │  │     │     │  └─ styles.xml
   │  │     │  │  │  │     │     └─ values-night
   │  │     │  │  │  │     │        └─ styles.xml
   │  │     │  │  │  │     └─ profile
   │  │     │  │  │  │        └─ AndroidManifest.xml
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ on_device_jni_test.dart
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Podfile
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     └─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  └─ Runner.xcworkspace
   │  │     │  │  │     ├─ contents.xcworkspacedata
   │  │     │  │  │     └─ xcshareddata
   │  │     │  │  │        └─ IDEWorkspaceChecks.plist
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ffigen.yaml
   │  │     │  ├─ ffigen_exts.yaml
   │  │     │  ├─ java
   │  │     │  │  ├─ build.gradle.kts
   │  │     │  │  ├─ gradle
   │  │     │  │  │  ├─ libs.versions.toml
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     ├─ gradle-wrapper.jar
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradlew
   │  │     │  │  ├─ gradlew.bat
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ settings.gradle.kts
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ main
   │  │     │  │  │     └─ java
   │  │     │  │  │        └─ com
   │  │     │  │  │           └─ github
   │  │     │  │  │              └─ dart_lang
   │  │     │  │  │                 └─ jni
   │  │     │  │  │                    ├─ JniUtils.java
   │  │     │  │  │                    ├─ PortCleaner.java
   │  │     │  │  │                    ├─ PortContinuation.java
   │  │     │  │  │                    └─ PortProxyBuilder.java
   │  │     │  │  └─ ~
   │  │     │  │     └─ dev
   │  │     │  │        ├─ native
   │  │     │  │        │  └─ native
   │  │     │  │        │     └─ pkgs
   │  │     │  │        │        └─ jnigen
   │  │     │  │        │           └─ example
   │  │     │  │        │              └─ pdfbox_plugin
   │  │     │  │        │                 └─ dart_example
   │  │     │  │        └─ native2
   │  │     │  │           └─ pkgs
   │  │     │  │              └─ jnigen
   │  │     │  │                 └─ example
   │  │     │  │                    └─ pdfbox_plugin
   │  │     │  │                       └─ dart_example
   │  │     │  ├─ lib
   │  │     │  │  ├─ jni.dart
   │  │     │  │  ├─ jni_symbols.yaml
   │  │     │  │  ├─ src
   │  │     │  │  │  ├─ accessors.dart
   │  │     │  │  │  ├─ build_util
   │  │     │  │  │  │  └─ build_util.dart
   │  │     │  │  │  ├─ core_bindings.dart
   │  │     │  │  │  ├─ errors.dart
   │  │     │  │  │  ├─ jarray.dart
   │  │     │  │  │  ├─ jclass.dart
   │  │     │  │  │  ├─ jimplementer.dart
   │  │     │  │  │  ├─ jni.dart
   │  │     │  │  │  ├─ jobject.dart
   │  │     │  │  │  ├─ jprimitives.dart
   │  │     │  │  │  ├─ jreference.dart
   │  │     │  │  │  ├─ jvalues.dart
   │  │     │  │  │  ├─ kotlin.dart
   │  │     │  │  │  ├─ lang
   │  │     │  │  │  │  ├─ jboolean.dart
   │  │     │  │  │  │  ├─ jbyte.dart
   │  │     │  │  │  │  ├─ jcharacter.dart
   │  │     │  │  │  │  ├─ jdouble.dart
   │  │     │  │  │  │  ├─ jfloat.dart
   │  │     │  │  │  │  ├─ jinteger.dart
   │  │     │  │  │  │  ├─ jlong.dart
   │  │     │  │  │  │  ├─ jnumber.dart
   │  │     │  │  │  │  ├─ jshort.dart
   │  │     │  │  │  │  ├─ jstring.dart
   │  │     │  │  │  │  └─ lang.dart
   │  │     │  │  │  ├─ method_invocation.dart
   │  │     │  │  │  ├─ nio
   │  │     │  │  │  │  ├─ jbuffer.dart
   │  │     │  │  │  │  ├─ jbyte_buffer.dart
   │  │     │  │  │  │  └─ nio.dart
   │  │     │  │  │  ├─ primitive_jarrays.dart
   │  │     │  │  │  ├─ third_party
   │  │     │  │  │  │  ├─ generated_bindings.dart
   │  │     │  │  │  │  ├─ global_env_extensions.dart
   │  │     │  │  │  │  └─ jni_bindings_generated.dart
   │  │     │  │  │  ├─ types.dart
   │  │     │  │  │  ├─ util
   │  │     │  │  │  │  ├─ jiterator.dart
   │  │     │  │  │  │  ├─ jlist.dart
   │  │     │  │  │  │  ├─ jmap.dart
   │  │     │  │  │  │  ├─ jset.dart
   │  │     │  │  │  │  └─ util.dart
   │  │     │  │  │  └─ version_check.dart
   │  │     │  │  └─ _internal.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ linux
   │  │     │  │  └─ CMakeLists.txt
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ src
   │  │     │  │  ├─ CMakeLists.txt
   │  │     │  │  ├─ dartjni.c
   │  │     │  │  ├─ dartjni.h
   │  │     │  │  ├─ include
   │  │     │  │  │  ├─ analyze_snapshot_api.h
   │  │     │  │  │  ├─ bin
   │  │     │  │  │  │  ├─ dart_io_api.h
   │  │     │  │  │  │  └─ native_assets_api.h
   │  │     │  │  │  ├─ BUILD.gn
   │  │     │  │  │  ├─ dart_api.h
   │  │     │  │  │  ├─ dart_api_dl.c
   │  │     │  │  │  ├─ dart_api_dl.h
   │  │     │  │  │  ├─ dart_embedder_api.h
   │  │     │  │  │  ├─ dart_native_api.h
   │  │     │  │  │  ├─ dart_tools_api.h
   │  │     │  │  │  ├─ dart_version.h
   │  │     │  │  │  └─ internal
   │  │     │  │  │     └─ dart_api_dl_impl.h
   │  │     │  │  ├─ jni_constants.h
   │  │     │  │  ├─ README.md
   │  │     │  │  └─ third_party
   │  │     │  │     ├─ global_jni_env.c
   │  │     │  │     └─ global_jni_env.h
   │  │     │  ├─ test
   │  │     │  │  ├─ boxed_test.dart
   │  │     │  │  ├─ debug_release_test.dart
   │  │     │  │  ├─ exception_test.dart
   │  │     │  │  ├─ global_env_test.dart
   │  │     │  │  ├─ isolate_test.dart
   │  │     │  │  ├─ jarray_test.dart
   │  │     │  │  ├─ jbyte_buffer_test.dart
   │  │     │  │  ├─ jlist_test.dart
   │  │     │  │  ├─ jmap_test.dart
   │  │     │  │  ├─ jobject_test.dart
   │  │     │  │  ├─ jset_test.dart
   │  │     │  │  ├─ jstring_test.dart
   │  │     │  │  ├─ load_test.dart
   │  │     │  │  ├─ test_util
   │  │     │  │  │  └─ test_util.dart
   │  │     │  │  ├─ version_check
   │  │     │  │  │  ├─ fail_major.dart
   │  │     │  │  │  ├─ fail_minor.dart
   │  │     │  │  │  └─ pass.dart
   │  │     │  │  └─ version_check_test.dart
   │  │     │  ├─ third_party
   │  │     │  │  └─ jni.h
   │  │     │  ├─ tool
   │  │     │  │  ├─ generate_ffi_bindings.dart
   │  │     │  │  ├─ generate_ide_files.dart
   │  │     │  │  ├─ generate_jni_bindings.dart
   │  │     │  │  ├─ generate_primitive_arrays.dart
   │  │     │  │  └─ wrapper_generators
   │  │     │  │     ├─ ffigen_util.dart
   │  │     │  │     ├─ generate_c_extensions.dart
   │  │     │  │     ├─ generate_dart_extensions.dart
   │  │     │  │     ├─ generate_helper_functions.dart
   │  │     │  │     └─ logging.dart
   │  │     │  └─ windows
   │  │     │     └─ CMakeLists.txt
   │  │     ├─ open_file_windows
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ lib
   │  │     │  │  └─ open_file_windows.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     └─ open_file_windows_test.dart
   │  │     ├─ package_info_plus
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        └─ kotlin
   │  │     │  │           └─ dev
   │  │     │  │              └─ fluttercommunity
   │  │     │  │                 └─ plus
   │  │     │  │                    └─ packageinfo
   │  │     │  │                       └─ PackageInfoPlugin.kt
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  ├─ gradle
   │  │     │  │  │  │  │  └─ wrapper
   │  │     │  │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     ├─ androidTest
   │  │     │  │  │  │     │  └─ java
   │  │     │  │  │  │     │     └─ io
   │  │     │  │  │  │     │        └─ flutter
   │  │     │  │  │  │     │           └─ plugins
   │  │     │  │  │  │     │              └─ packageinfoexample
   │  │     │  │  │  │     │                 ├─ EmbedderV1ActivityTest.java
   │  │     │  │  │  │     │                 └─ MainActivityTest.java
   │  │     │  │  │  │     └─ main
   │  │     │  │  │  │        ├─ AndroidManifest.xml
   │  │     │  │  │  │        ├─ java
   │  │     │  │  │  │        │  └─ io
   │  │     │  │  │  │        │     └─ flutter
   │  │     │  │  │  │        │        └─ plugins
   │  │     │  │  │  │        └─ res
   │  │     │  │  │  │           ├─ mipmap-hdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-mdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xxhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           └─ mipmap-xxxhdpi
   │  │     │  │  │  │              └─ ic_launcher.png
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ build.yaml
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  ├─ driver.dart
   │  │     │  │  │  ├─ package_info_plus_test.dart
   │  │     │  │  │  ├─ package_info_plus_web_test.dart
   │  │     │  │  │  └─ package_info_plus_web_test.mocks.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │     │  └─ configuration
   │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ swiftpm
   │  │     │  │  │  │        └─ configuration
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  ├─ Icon-512.png
   │  │     │  │  │  │  ├─ Icon-maskable-192.png
   │  │     │  │  │  │  └─ Icon-maskable-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ package_info_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ package_info_plus
   │  │     │  │  │        ├─ FPPPackageInfoPlusPlugin.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ package_info_plus
   │  │     │  │  │        │     └─ FPPPackageInfoPlusPlugin.h
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ package_info_plus.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ package_info_plus.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ file_attribute.dart
   │  │     │  │     ├─ file_version_info.dart
   │  │     │  │     ├─ package_info_plus_linux.dart
   │  │     │  │     ├─ package_info_plus_macos.dart
   │  │     │  │     ├─ package_info_plus_web.dart
   │  │     │  │     └─ package_info_plus_windows.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ package_info_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ package_info_plus
   │  │     │  │  │        ├─ FPPPackageInfoPlusPlugin.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ package_info_plus
   │  │     │  │  │        │     └─ FPPPackageInfoPlusPlugin.h
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ package_info_plus.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ package_info_plus_linux_test.dart
   │  │     │     ├─ package_info_plus_windows_test.dart
   │  │     │     └─ package_info_test.dart
   │  │     ├─ path_provider_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ path_provider_test.dart
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  ├─ path_provider_windows.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ folders.dart
   │  │     │  │     ├─ folders_stub.dart
   │  │     │  │     ├─ guid.dart
   │  │     │  │     ├─ path_provider_windows_real.dart
   │  │     │  │     ├─ path_provider_windows_stub.dart
   │  │     │  │     └─ win32_wrappers.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ guid_test.dart
   │  │     │     └─ path_provider_windows_test.dart
   │  │     ├─ pdfrx
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ CMakeLists.txt
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        └─ AndroidManifest.xml
   │  │     │  ├─ assets
   │  │     │  │  ├─ pdfium.wasm
   │  │     │  │  ├─ pdfium_client.js
   │  │     │  │  └─ pdfium_worker.js
   │  │     │  ├─ bin
   │  │     │  │  └─ remove_wasm_modules.dart
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ CLAUDE.md
   │  │     │  ├─ CODE_OF_CONDUCT.md
   │  │     │  ├─ darwin
   │  │     │  │  ├─ pdfium
   │  │     │  │  │  ├─ build
   │  │     │  │  │  ├─ build-config.sh
   │  │     │  │  │  └─ patches
   │  │     │  │  ├─ pdfrx
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ pdfrx
   │  │     │  │  │        ├─ include
   │  │     │  │  │        └─ pdfrx.cpp
   │  │     │  │  └─ pdfrx.podspec
   │  │     │  ├─ example
   │  │     │  │  └─ README.md
   │  │     │  ├─ lib
   │  │     │  │  ├─ pdfrx.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ pdfium
   │  │     │  │     │  ├─ http_cache_control.dart
   │  │     │  │     │  ├─ pdfium_bindings.dart
   │  │     │  │     │  ├─ pdfium_interop.dart
   │  │     │  │     │  ├─ pdfrx_pdfium.dart
   │  │     │  │     │  ├─ pdf_file_cache.dart
   │  │     │  │     │  └─ worker.dart
   │  │     │  │     ├─ pdf_api.dart
   │  │     │  │     ├─ pdf_document_ref.dart
   │  │     │  │     ├─ utils
   │  │     │  │     │  ├─ double_extensions.dart
   │  │     │  │     │  ├─ native
   │  │     │  │     │  │  └─ native.dart
   │  │     │  │     │  ├─ platform.dart
   │  │     │  │     │  └─ web
   │  │     │  │     │     └─ web.dart
   │  │     │  │     ├─ web
   │  │     │  │     │  ├─ js_utils.dart
   │  │     │  │     │  └─ pdfrx_wasm.dart
   │  │     │  │     └─ widgets
   │  │     │  │        ├─ interactive_viewer.dart
   │  │     │  │        ├─ pdf_error_widget.dart
   │  │     │  │        ├─ pdf_page_links_overlay.dart
   │  │     │  │        ├─ pdf_page_text_overlay.dart
   │  │     │  │        ├─ pdf_text_searcher.dart
   │  │     │  │        ├─ pdf_viewer.dart
   │  │     │  │        ├─ pdf_viewer_params.dart
   │  │     │  │        ├─ pdf_viewer_scroll_thumb.dart
   │  │     │  │        └─ pdf_widgets.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ linux
   │  │     │  │  └─ CMakeLists.txt
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ screenshot.jpg
   │  │     │  ├─ src
   │  │     │  │  ├─ CMakeLists.txt
   │  │     │  │  └─ pdfium_interop.cpp
   │  │     │  ├─ test
   │  │     │  │  ├─ pdf_document_test.dart
   │  │     │  │  ├─ pdf_viewer_test.dart
   │  │     │  │  ├─ setup.dart
   │  │     │  │  └─ utils.dart
   │  │     │  └─ windows
   │  │     │     └─ CMakeLists.txt
   │  │     ├─ permission_handler_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ res
   │  │     │  │  │  └─ images
   │  │     │  │  │     ├─ baseflow_logo_def_light-02.png
   │  │     │  │  │     ├─ poweredByBaseflowLogoLight.png
   │  │     │  │  │     ├─ poweredByBaseflowLogoLight@2x.png
   │  │     │  │  │     └─ poweredByBaseflowLogoLight@3x.png
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  ├─ generated_plugins.cmake
   │  │     │  │     │  ├─ generated_plugin_registrant.cc
   │  │     │  │     │  └─ generated_plugin_registrant.h
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ include
   │  │     │     │  └─ permission_handler_windows
   │  │     │     │     └─ permission_handler_windows_plugin.h
   │  │     │     ├─ permission_constants.h
   │  │     │     └─ permission_handler_windows_plugin.cpp
   │  │     ├─ shared_preferences_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ AUTHORS
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ shared_preferences_test.dart
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ LICENSE
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  └─ shared_preferences_windows.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ test
   │  │     │     ├─ fake_path_provider_windows.dart
   │  │     │     ├─ legacy_shared_preferences_windows_test.dart
   │  │     │     └─ shared_preferences_windows_async_test.dart
   │  │     ├─ share_plus
   │  │     │  ├─ android
   │  │     │  │  ├─ build.gradle
   │  │     │  │  ├─ gradle
   │  │     │  │  │  └─ wrapper
   │  │     │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  ├─ gradle.properties
   │  │     │  │  ├─ settings.gradle
   │  │     │  │  └─ src
   │  │     │  │     └─ main
   │  │     │  │        ├─ AndroidManifest.xml
   │  │     │  │        ├─ kotlin
   │  │     │  │        │  └─ dev
   │  │     │  │        │     └─ fluttercommunity
   │  │     │  │        │        └─ plus
   │  │     │  │        │           └─ share
   │  │     │  │        │              ├─ MethodCallHandler.kt
   │  │     │  │        │              ├─ Share.kt
   │  │     │  │        │              ├─ ShareFileProvider.kt
   │  │     │  │        │              ├─ SharePlusPendingIntent.kt
   │  │     │  │        │              ├─ SharePlusPlugin.kt
   │  │     │  │        │              └─ ShareSuccessManager.kt
   │  │     │  │        └─ res
   │  │     │  │           └─ xml
   │  │     │  │              └─ flutter_share_file_paths.xml
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ android
   │  │     │  │  │  ├─ app
   │  │     │  │  │  │  ├─ build.gradle
   │  │     │  │  │  │  └─ src
   │  │     │  │  │  │     └─ main
   │  │     │  │  │  │        ├─ AndroidManifest.xml
   │  │     │  │  │  │        ├─ java
   │  │     │  │  │  │        │  └─ io
   │  │     │  │  │  │        │     └─ flutter
   │  │     │  │  │  │        │        └─ plugins
   │  │     │  │  │  │        └─ res
   │  │     │  │  │  │           ├─ mipmap-hdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-mdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           ├─ mipmap-xxhdpi
   │  │     │  │  │  │           │  └─ ic_launcher.png
   │  │     │  │  │  │           └─ mipmap-xxxhdpi
   │  │     │  │  │  │              └─ ic_launcher.png
   │  │     │  │  │  ├─ build.gradle
   │  │     │  │  │  ├─ gradle
   │  │     │  │  │  │  └─ wrapper
   │  │     │  │  │  │     └─ gradle-wrapper.properties
   │  │     │  │  │  ├─ gradle.properties
   │  │     │  │  │  └─ settings.gradle
   │  │     │  │  ├─ assets
   │  │     │  │  │  └─ flutter_logo.png
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ share_plus_test.dart
   │  │     │  │  ├─ ios
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ AppFrameworkInfo.plist
   │  │     │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  └─ Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  ├─ AppIcon.appiconset
   │  │     │  │  │  │  │  │  ├─ Contents.json
   │  │     │  │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │     │  │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │     │  │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │     │  │  │  │  │  └─ LaunchImage.imageset
   │  │     │  │  │  │  │     ├─ Contents.json
   │  │     │  │  │  │  │     ├─ LaunchImage.png
   │  │     │  │  │  │  │     ├─ LaunchImage@2x.png
   │  │     │  │  │  │  │     ├─ LaunchImage@3x.png
   │  │     │  │  │  │  │     └─ README.md
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  ├─ LaunchScreen.storyboard
   │  │     │  │  │  │  │  └─ Main.storyboard
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  └─ Runner-Bridging-Header.h
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │  │     │  └─ configuration
   │  │     │  │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     ├─ swiftpm
   │  │     │  │  │  │     │  └─ configuration
   │  │     │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ image_previews.dart
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ linux
   │  │     │  │  │  ├─ CMakeLists.txt
   │  │     │  │  │  ├─ flutter
   │  │     │  │  │  │  └─ CMakeLists.txt
   │  │     │  │  │  ├─ main.cc
   │  │     │  │  │  ├─ my_application.cc
   │  │     │  │  │  └─ my_application.h
   │  │     │  │  ├─ macos
   │  │     │  │  │  ├─ Flutter
   │  │     │  │  │  │  ├─ Flutter-Debug.xcconfig
   │  │     │  │  │  │  └─ Flutter-Release.xcconfig
   │  │     │  │  │  ├─ Runner
   │  │     │  │  │  │  ├─ AppDelegate.swift
   │  │     │  │  │  │  ├─ Assets.xcassets
   │  │     │  │  │  │  │  └─ AppIcon.appiconset
   │  │     │  │  │  │  │     ├─ app_icon_1024.png
   │  │     │  │  │  │  │     ├─ app_icon_128.png
   │  │     │  │  │  │  │     ├─ app_icon_16.png
   │  │     │  │  │  │  │     ├─ app_icon_256.png
   │  │     │  │  │  │  │     ├─ app_icon_32.png
   │  │     │  │  │  │  │     ├─ app_icon_512.png
   │  │     │  │  │  │  │     ├─ app_icon_64.png
   │  │     │  │  │  │  │     └─ Contents.json
   │  │     │  │  │  │  ├─ Base.lproj
   │  │     │  │  │  │  │  └─ MainMenu.xib
   │  │     │  │  │  │  ├─ Configs
   │  │     │  │  │  │  │  ├─ AppInfo.xcconfig
   │  │     │  │  │  │  │  ├─ Debug.xcconfig
   │  │     │  │  │  │  │  ├─ Release.xcconfig
   │  │     │  │  │  │  │  └─ Warnings.xcconfig
   │  │     │  │  │  │  ├─ DebugProfile.entitlements
   │  │     │  │  │  │  ├─ Info.plist
   │  │     │  │  │  │  ├─ MainFlutterWindow.swift
   │  │     │  │  │  │  └─ Release.entitlements
   │  │     │  │  │  ├─ Runner.xcodeproj
   │  │     │  │  │  │  ├─ project.pbxproj
   │  │     │  │  │  │  ├─ project.xcworkspace
   │  │     │  │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │  │     └─ swiftpm
   │  │     │  │  │  │  │        └─ configuration
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     └─ xcschemes
   │  │     │  │  │  │        └─ Runner.xcscheme
   │  │     │  │  │  ├─ Runner.xcworkspace
   │  │     │  │  │  │  ├─ contents.xcworkspacedata
   │  │     │  │  │  │  └─ xcshareddata
   │  │     │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │     │  │  │  │     └─ swiftpm
   │  │     │  │  │  │        └─ configuration
   │  │     │  │  │  └─ RunnerTests
   │  │     │  │  │     └─ RunnerTests.swift
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ share_plus_test.dart
   │  │     │  │  ├─ web
   │  │     │  │  │  ├─ favicon.png
   │  │     │  │  │  ├─ icons
   │  │     │  │  │  │  ├─ Icon-192.png
   │  │     │  │  │  │  └─ Icon-512.png
   │  │     │  │  │  ├─ index.html
   │  │     │  │  │  └─ manifest.json
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  └─ CMakeLists.txt
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ ios
   │  │     │  │  ├─ share_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ share_plus
   │  │     │  │  │        ├─ FPPSharePlusPlugin.m
   │  │     │  │  │        ├─ include
   │  │     │  │  │        │  └─ share_plus
   │  │     │  │  │        │     └─ FPPSharePlusPlugin.h
   │  │     │  │  │        └─ PrivacyInfo.xcprivacy
   │  │     │  │  └─ share_plus.podspec
   │  │     │  ├─ lib
   │  │     │  │  ├─ share_plus.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ share_plus_linux.dart
   │  │     │  │     ├─ share_plus_macos.dart
   │  │     │  │     ├─ share_plus_web.dart
   │  │     │  │     ├─ share_plus_windows.dart
   │  │     │  │     └─ windows_version_helper.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ macos
   │  │     │  │  ├─ share_plus
   │  │     │  │  │  ├─ Package.swift
   │  │     │  │  │  └─ Sources
   │  │     │  │  │     └─ share_plus
   │  │     │  │  │        ├─ PrivacyInfo.xcprivacy
   │  │     │  │  │        └─ SharePlusMacosPlugin.swift
   │  │     │  │  └─ share_plus.podspec
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  ├─ share_plus_linux_test.dart
   │  │     │  │  ├─ share_plus_windows_test.dart
   │  │     │  │  └─ url_launcher_mock.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ include
   │  │     │     │  └─ share_plus
   │  │     │     │     └─ share_plus_windows_plugin_c_api.h
   │  │     │     ├─ share_plus_plugin.cpp
   │  │     │     ├─ share_plus_plugin_c_api.cpp
   │  │     │     ├─ share_plus_windows_plugin.h
   │  │     │     └─ vector.h
   │  │     ├─ syncfusion_pdfviewer_windows
   │  │     │  ├─ analysis_options.yaml
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ analysis_options.yaml
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ include
   │  │     │     │  ├─ pdfium
   │  │     │     │  │  ├─ cpp
   │  │     │     │  │  │  ├─ fpdf_deleters.h
   │  │     │     │  │  │  └─ fpdf_scopers.h
   │  │     │     │  │  ├─ fpdfview.h
   │  │     │     │  │  ├─ fpdf_annot.h
   │  │     │     │  │  ├─ fpdf_attachment.h
   │  │     │     │  │  ├─ fpdf_catalog.h
   │  │     │     │  │  ├─ fpdf_dataavail.h
   │  │     │     │  │  ├─ fpdf_doc.h
   │  │     │     │  │  ├─ fpdf_edit.h
   │  │     │     │  │  ├─ fpdf_ext.h
   │  │     │     │  │  ├─ fpdf_flatten.h
   │  │     │     │  │  ├─ fpdf_formfill.h
   │  │     │     │  │  ├─ fpdf_fwlevent.h
   │  │     │     │  │  ├─ fpdf_javascript.h
   │  │     │     │  │  ├─ fpdf_ppo.h
   │  │     │     │  │  ├─ fpdf_progressive.h
   │  │     │     │  │  ├─ fpdf_save.h
   │  │     │     │  │  ├─ fpdf_searchex.h
   │  │     │     │  │  ├─ fpdf_signature.h
   │  │     │     │  │  ├─ fpdf_structtree.h
   │  │     │     │  │  ├─ fpdf_sysfontinfo.h
   │  │     │     │  │  ├─ fpdf_text.h
   │  │     │     │  │  ├─ fpdf_thumbnail.h
   │  │     │     │  │  ├─ fpdf_transformpage.h
   │  │     │     │  │  └─ x64
   │  │     │     │  │     ├─ bin
   │  │     │     │  │     │  └─ pdfium.dll
   │  │     │     │  │     └─ lib
   │  │     │     │  │        └─ pdfium.dll.lib
   │  │     │     │  └─ syncfusion_pdfviewer_windows
   │  │     │     │     └─ syncfusion_pdfviewer_windows_plugin.h
   │  │     │     ├─ pdfviewer.cpp
   │  │     │     ├─ pdfviewer.h
   │  │     │     └─ syncfusion_pdfviewer_windows_plugin.cpp
   │  │     ├─ url_launcher_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ example
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ url_launcher_test.dart
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  ├─ src
   │  │     │  │  │  └─ messages.g.dart
   │  │     │  │  └─ url_launcher_windows.dart
   │  │     │  ├─ LICENSE
   │  │     │  ├─ pigeons
   │  │     │  │  ├─ copyright.txt
   │  │     │  │  └─ messages.dart
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ README.md
   │  │     │  ├─ test
   │  │     │  │  └─ url_launcher_windows_test.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ include
   │  │     │     │  └─ url_launcher_windows
   │  │     │     │     └─ url_launcher_windows.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ system_apis.cpp
   │  │     │     ├─ system_apis.h
   │  │     │     ├─ test
   │  │     │     │  └─ url_launcher_windows_test.cpp
   │  │     │     ├─ url_launcher_plugin.cpp
   │  │     │     ├─ url_launcher_plugin.h
   │  │     │     └─ url_launcher_windows.cpp
   │  │     └─ wakelock_plus
   │  │        ├─ analysis_options.yaml
   │  │        ├─ android
   │  │        │  ├─ build.gradle
   │  │        │  ├─ settings.gradle
   │  │        │  └─ src
   │  │        │     └─ main
   │  │        │        ├─ AndroidManifest.xml
   │  │        │        └─ kotlin
   │  │        │           └─ dev
   │  │        │              └─ fluttercommunity
   │  │        │                 └─ plus
   │  │        │                    └─ wakelock
   │  │        │                       ├─ Wakelock.kt
   │  │        │                       ├─ WakelockPlusMessages.g.kt
   │  │        │                       └─ WakelockPlusPlugin.kt
   │  │        ├─ assets
   │  │        │  └─ no_sleep.js
   │  │        ├─ CHANGELOG.md
   │  │        ├─ example
   │  │        │  ├─ analysis_options.yaml
   │  │        │  ├─ android
   │  │        │  │  ├─ app
   │  │        │  │  │  ├─ build.gradle
   │  │        │  │  │  └─ src
   │  │        │  │  │     ├─ debug
   │  │        │  │  │     │  └─ AndroidManifest.xml
   │  │        │  │  │     ├─ main
   │  │        │  │  │     │  ├─ AndroidManifest.xml
   │  │        │  │  │     │  ├─ java
   │  │        │  │  │     │  │  └─ io
   │  │        │  │  │     │  │     └─ flutter
   │  │        │  │  │     │  │        └─ plugins
   │  │        │  │  │     │  ├─ kotlin
   │  │        │  │  │     │  │  └─ dev
   │  │        │  │  │     │  │     └─ fluttercommunity
   │  │        │  │  │     │  │        └─ plus
   │  │        │  │  │     │  │           └─ wakelock_example
   │  │        │  │  │     │  │              └─ MainActivity.kt
   │  │        │  │  │     │  └─ res
   │  │        │  │  │     │     ├─ drawable
   │  │        │  │  │     │     │  └─ launch_background.xml
   │  │        │  │  │     │     ├─ drawable-v21
   │  │        │  │  │     │     │  └─ launch_background.xml
   │  │        │  │  │     │     ├─ mipmap-hdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-mdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xxhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ mipmap-xxxhdpi
   │  │        │  │  │     │     │  └─ ic_launcher.png
   │  │        │  │  │     │     ├─ values
   │  │        │  │  │     │     │  └─ styles.xml
   │  │        │  │  │     │     └─ values-night
   │  │        │  │  │     │        └─ styles.xml
   │  │        │  │  │     └─ profile
   │  │        │  │  │        └─ AndroidManifest.xml
   │  │        │  │  ├─ build.gradle
   │  │        │  │  ├─ gradle
   │  │        │  │  │  └─ wrapper
   │  │        │  │  │     └─ gradle-wrapper.properties
   │  │        │  │  ├─ gradle.properties
   │  │        │  │  └─ settings.gradle
   │  │        │  ├─ integration_test
   │  │        │  │  └─ wakelock_plus_test.dart
   │  │        │  ├─ ios
   │  │        │  │  ├─ Flutter
   │  │        │  │  │  ├─ AppFrameworkInfo.plist
   │  │        │  │  │  ├─ Debug.xcconfig
   │  │        │  │  │  └─ Release.xcconfig
   │  │        │  │  ├─ Podfile
   │  │        │  │  ├─ Podfile.lock
   │  │        │  │  ├─ Runner
   │  │        │  │  │  ├─ AppDelegate.h
   │  │        │  │  │  ├─ AppDelegate.m
   │  │        │  │  │  ├─ Assets.xcassets
   │  │        │  │  │  │  ├─ AppIcon.appiconset
   │  │        │  │  │  │  │  ├─ Contents.json
   │  │        │  │  │  │  │  ├─ Icon-App-1024x1024@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-20x20@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-29x29@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-40x40@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-60x60@2x.png
   │  │        │  │  │  │  │  ├─ Icon-App-60x60@3x.png
   │  │        │  │  │  │  │  ├─ Icon-App-76x76@1x.png
   │  │        │  │  │  │  │  ├─ Icon-App-76x76@2x.png
   │  │        │  │  │  │  │  └─ Icon-App-83.5x83.5@2x.png
   │  │        │  │  │  │  └─ LaunchImage.imageset
   │  │        │  │  │  │     ├─ Contents.json
   │  │        │  │  │  │     ├─ LaunchImage.png
   │  │        │  │  │  │     ├─ LaunchImage@2x.png
   │  │        │  │  │  │     ├─ LaunchImage@3x.png
   │  │        │  │  │  │     └─ README.md
   │  │        │  │  │  ├─ Base.lproj
   │  │        │  │  │  │  ├─ LaunchScreen.storyboard
   │  │        │  │  │  │  └─ Main.storyboard
   │  │        │  │  │  ├─ Info.plist
   │  │        │  │  │  └─ main.m
   │  │        │  │  ├─ Runner.xcodeproj
   │  │        │  │  │  ├─ project.pbxproj
   │  │        │  │  │  ├─ project.xcworkspace
   │  │        │  │  │  │  ├─ contents.xcworkspacedata
   │  │        │  │  │  │  └─ xcshareddata
   │  │        │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │        │  │  │  │     ├─ swiftpm
   │  │        │  │  │  │     │  └─ configuration
   │  │        │  │  │  │     └─ WorkspaceSettings.xcsettings
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     └─ xcschemes
   │  │        │  │  │        └─ Runner.xcscheme
   │  │        │  │  ├─ Runner.xcworkspace
   │  │        │  │  │  ├─ contents.xcworkspacedata
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │        │  │  │     ├─ swiftpm
   │  │        │  │  │     │  └─ configuration
   │  │        │  │  │     └─ WorkspaceSettings.xcsettings
   │  │        │  │  └─ RunnerTests
   │  │        │  │     └─ RunnerTests.m
   │  │        │  ├─ lib
   │  │        │  │  └─ main.dart
   │  │        │  ├─ linux
   │  │        │  │  ├─ CMakeLists.txt
   │  │        │  │  ├─ flutter
   │  │        │  │  │  ├─ CMakeLists.txt
   │  │        │  │  │  ├─ generated_plugins.cmake
   │  │        │  │  │  ├─ generated_plugin_registrant.cc
   │  │        │  │  │  └─ generated_plugin_registrant.h
   │  │        │  │  ├─ main.cc
   │  │        │  │  ├─ my_application.cc
   │  │        │  │  └─ my_application.h
   │  │        │  ├─ macos
   │  │        │  │  ├─ Flutter
   │  │        │  │  │  ├─ Flutter-Debug.xcconfig
   │  │        │  │  │  ├─ Flutter-Release.xcconfig
   │  │        │  │  │  └─ GeneratedPluginRegistrant.swift
   │  │        │  │  ├─ Podfile
   │  │        │  │  ├─ Podfile.lock
   │  │        │  │  ├─ Runner
   │  │        │  │  │  ├─ AppDelegate.swift
   │  │        │  │  │  ├─ Assets.xcassets
   │  │        │  │  │  │  └─ AppIcon.appiconset
   │  │        │  │  │  │     ├─ app_icon_1024.png
   │  │        │  │  │  │     ├─ app_icon_128.png
   │  │        │  │  │  │     ├─ app_icon_16.png
   │  │        │  │  │  │     ├─ app_icon_256.png
   │  │        │  │  │  │     ├─ app_icon_32.png
   │  │        │  │  │  │     ├─ app_icon_512.png
   │  │        │  │  │  │     ├─ app_icon_64.png
   │  │        │  │  │  │     └─ Contents.json
   │  │        │  │  │  ├─ Base.lproj
   │  │        │  │  │  │  └─ MainMenu.xib
   │  │        │  │  │  ├─ Configs
   │  │        │  │  │  │  ├─ AppInfo.xcconfig
   │  │        │  │  │  │  ├─ Debug.xcconfig
   │  │        │  │  │  │  ├─ Release.xcconfig
   │  │        │  │  │  │  └─ Warnings.xcconfig
   │  │        │  │  │  ├─ DebugProfile.entitlements
   │  │        │  │  │  ├─ Info.plist
   │  │        │  │  │  ├─ MainFlutterWindow.swift
   │  │        │  │  │  └─ Release.entitlements
   │  │        │  │  ├─ Runner.xcodeproj
   │  │        │  │  │  ├─ project.pbxproj
   │  │        │  │  │  ├─ project.xcworkspace
   │  │        │  │  │  │  └─ xcshareddata
   │  │        │  │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │        │  │  │  │     └─ swiftpm
   │  │        │  │  │  │        └─ configuration
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     └─ xcschemes
   │  │        │  │  │        └─ Runner.xcscheme
   │  │        │  │  ├─ Runner.xcworkspace
   │  │        │  │  │  ├─ contents.xcworkspacedata
   │  │        │  │  │  └─ xcshareddata
   │  │        │  │  │     ├─ IDEWorkspaceChecks.plist
   │  │        │  │  │     └─ swiftpm
   │  │        │  │  │        └─ configuration
   │  │        │  │  └─ RunnerTests
   │  │        │  │     └─ RunnerTests.swift
   │  │        │  ├─ pubspec.yaml
   │  │        │  ├─ README.md
   │  │        │  ├─ test_driver
   │  │        │  │  └─ integration_test.dart
   │  │        │  ├─ web
   │  │        │  │  ├─ favicon.png
   │  │        │  │  ├─ icons
   │  │        │  │  │  ├─ Icon-192.png
   │  │        │  │  │  ├─ Icon-512.png
   │  │        │  │  │  ├─ Icon-maskable-192.png
   │  │        │  │  │  └─ Icon-maskable-512.png
   │  │        │  │  ├─ index.html
   │  │        │  │  └─ manifest.json
   │  │        │  └─ windows
   │  │        │     ├─ CMakeLists.txt
   │  │        │     ├─ flutter
   │  │        │     │  ├─ CMakeLists.txt
   │  │        │     │  ├─ generated_plugins.cmake
   │  │        │     │  ├─ generated_plugin_registrant.cc
   │  │        │     │  └─ generated_plugin_registrant.h
   │  │        │     └─ runner
   │  │        │        ├─ CMakeLists.txt
   │  │        │        ├─ flutter_window.cpp
   │  │        │        ├─ flutter_window.h
   │  │        │        ├─ main.cpp
   │  │        │        ├─ resource.h
   │  │        │        ├─ resources
   │  │        │        │  └─ app_icon.ico
   │  │        │        ├─ runner.exe.manifest
   │  │        │        ├─ Runner.rc
   │  │        │        ├─ utils.cpp
   │  │        │        ├─ utils.h
   │  │        │        ├─ win32_window.cpp
   │  │        │        └─ win32_window.h
   │  │        ├─ ios
   │  │        │  ├─ wakelock_plus
   │  │        │  │  ├─ Package.swift
   │  │        │  │  └─ Sources
   │  │        │  │     └─ wakelock_plus
   │  │        │  │        ├─ include
   │  │        │  │        │  └─ wakelock_plus
   │  │        │  │        │     ├─ messages.g.h
   │  │        │  │        │     ├─ UIApplication+idleTimerLock.h
   │  │        │  │        │     └─ WakelockPlusPlugin.h
   │  │        │  │        ├─ messages.g.m
   │  │        │  │        ├─ Resources
   │  │        │  │        │  └─ PrivacyInfo.xcprivacy
   │  │        │  │        ├─ UIApplication+idleTimerLock.m
   │  │        │  │        └─ WakelockPlusPlugin.m
   │  │        │  └─ wakelock_plus.podspec
   │  │        ├─ lib
   │  │        │  ├─ src
   │  │        │  │  ├─ wakelock_plus_io_plugin.dart
   │  │        │  │  ├─ wakelock_plus_linux_plugin.dart
   │  │        │  │  ├─ wakelock_plus_macos_plugin.dart
   │  │        │  │  ├─ wakelock_plus_web_plugin.dart
   │  │        │  │  ├─ wakelock_plus_windows_plugin.dart
   │  │        │  │  └─ web_impl
   │  │        │  │     ├─ import_js_library.dart
   │  │        │  │     └─ js_wakelock.dart
   │  │        │  └─ wakelock_plus.dart
   │  │        ├─ LICENSE
   │  │        ├─ macos
   │  │        │  ├─ wakelock_plus
   │  │        │  │  ├─ Package.swift
   │  │        │  │  └─ Sources
   │  │        │  │     └─ wakelock_plus
   │  │        │  │        ├─ Resources
   │  │        │  │        │  └─ PrivacyInfo.xcprivacy
   │  │        │  │        └─ WakelockPlusMacosPlugin.swift
   │  │        │  └─ wakelock_plus.podspec
   │  │        ├─ pigeons
   │  │        │  └─ messages.dart
   │  │        ├─ pubspec.yaml
   │  │        ├─ README.md
   │  │        └─ test
   │  │           ├─ wakelock_plus_test.dart
   │  │           └─ wakelock_plus_web_plugin_test.dart
   │  ├─ generated_plugins.cmake
   │  ├─ generated_plugin_registrant.cc
   │  └─ generated_plugin_registrant.h
   └─ runner
      ├─ CMakeLists.txt
      ├─ flutter_window.cpp
      ├─ flutter_window.h
      ├─ main.cpp
      ├─ resource.h
      ├─ resources
      │  └─ app_icon.ico
      ├─ runner.exe.manifest
      ├─ Runner.rc
      ├─ utils.cpp
      ├─ utils.h
      ├─ win32_window.cpp
      └─ win32_window.h

```