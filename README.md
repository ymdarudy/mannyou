# README
## Table Schema
#### User
| Column          | Type   |
| --------------- | ------ |
| name            | string |
| email           | string |
| password_digest | string |
| image           | text   |

#### Task
| Column  | Type   |
| ------- | ------ |
| user_id | bigint |
| title   | string |
| content | text   |

#### Label
| Column | Type   |
| ------ | ------ |
| name   | string |

#### TaskLabel
| Column   | Type   |
| -------- | ------ |
| task_id  | bigint |
| label_id | bigint |

## Herokuへのデプロイ手順
1. ＄heroic login
   -  herokuにログイン　
2. $ heroku create
   - herokuアプリ作成
3. $ heroku buildpacks:set heroku/ruby
   - rubyのbuildpackerを設定
4. $ heroku buildpacks:add --index 1 heroku/nodejs
   - nodejsのbuildpackerを設定
5. $ bundle lock --add-platform x86_64-linux
   - M1チップに対応していないため、x86_64-linuxプラットフォームを追加する。　
6. $ git add .
   - 変更を追加
7. $ git commit -m "chore: Herekuへのデプロイのため、x86_64-linuxプラットフォームを追加"
   - 変更をコミット
8. $ git push heroku (ブランチ名):master
   - デプロイ