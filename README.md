# Rspec学習

## Textbook
『Everyday Rails - RSpecによるRailsテスト入門』
https://leanpub.com/everydayrailsrspec-jp

## Install
```
# プロジェクトディレクトリ作成&移動
$ mkdir project; cd $_

# 初期化してGemfile生成
$ bundle init
```
```
$ vim Gemfile
# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# 以下をコメントインする
gem "rails"
```
```
# pathオプション付きでプロジェクト配下にインストールする
$ bundle install --path vendor/bundle

# Railsプロジェクト新規作成
# -G: .gitignoreファイルを自動作成しない
# -T: testファイルを作成しない
$ bundle exec rails new . -G -T
```
```
$ vim Gemfile
# gem追加（必要な部分だけ抜粋）
group :development, :test do
  gem 'rspec-rails'
end
```
```
# RSpecインストール
$ bundle exec rails g rspec:install
```

# Environment
- Ruby 2.5.3
- Rails 5.2.2
- Rspec 3.8.1
