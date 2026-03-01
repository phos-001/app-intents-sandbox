# app-intents-sandbox

AppIntentsの機能を試すSwiftUIを用いたiOSアプリです。

## 概要

このプロジェクトは、Apple の **AppIntents** フレームワークを使ってSiriやショートカットアプリと連携するiOSアプリのサンドボックスです。シンプルなタスク管理UIを通じて、AppIntentsの主要な機能を体験できます。

## 動作環境

- **Xcode**: 15.0 以上
- **iOS**: 16.0 以上
- **Swift**: 5.0

## プロジェクト構成

```
AppIntentsSandbox/
├── AppIntentsSandbox.xcodeproj/   # Xcodeプロジェクトファイル
└── AppIntentsSandbox/
    ├── AppIntentsSandboxApp.swift  # アプリエントリーポイント
    ├── ContentView.swift           # メインUIビュー（タスク一覧）
    ├── TaskStore.swift             # タスクのモデルと状態管理
    └── Intents/
        ├── AddTaskIntent.swift         # タスク追加 AppIntent
        ├── ListTasksIntent.swift       # タスク一覧取得 AppIntent
        └── AppShortcutsProvider.swift  # Siriフレーズ定義
```

## 実装されているAppIntents

| Intent | 説明 | Siriフレーズ例 |
|---|---|---|
| `AddTaskIntent` | 新しいタスクを追加する | 「タスクを追加 AppIntentsSandbox」 |
| `ListTasksIntent` | タスク一覧を読み上げる | 「AppIntentsSandboxのタスクを確認」 |

## 主な機能

- **SwiftUI タスク管理UI**: タスクの追加・削除・完了トグル
- **AppIntent**: Siriおよびショートカットアプリから呼び出し可能なインテント
- **AppShortcutsProvider**: アプリ固有のSiri起動フレーズを定義
- **UserDefaults 永続化**: タスクデータをアプリ再起動後も保持

## ビルド方法

1. `AppIntentsSandbox/AppIntentsSandbox.xcodeproj` をXcodeで開く
2. ターゲットデバイスまたはシミュレータを選択（iOS 16.0以上）
3. ▶︎ ボタンでビルド・実行

## AppIntentsの試し方

アプリをデバイスにインストールした後:

1. **ショートカットアプリ**: 「オートメーション」タブからアプリのショートカットを利用
2. **Siri**: 上記のフレーズで呼び出し（実機推奨）
3. **Siriショートカット設定**: 設定 → Siriと検索 → AppIntentsSandboxからショートカットを追加