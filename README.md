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
