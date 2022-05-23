# Test technique

## requirements

This project need some requirements to works
- git
- NodeJs v18
- yarn
- Rubi v3.1.0

## Install

You need to follow this steps to perform the installation

```bash
yarn install

cd src-react && yarn install

cd ../src-rails 
bundle install
bin/rails db:migrate
rake db:fixtures:load
bundle exec whenever --update-crontab  --set environment='development'
```


## Start environment

To start the development server you just need to execute the following command

```bash
yarn dev
```

## Run tests

### Backend

Test all sensitives rules in one time

```bash
cd ./src-rails

bin/rails test
```

You can test just one file to see the details

```bash
bin/rails test test/controllers/contracts_controller_test.rb
```

### Frontend

No tests currently provided


## Routes


### Authentication

Authenticate as user and get the Authorization token
`post /auth/login`
body
```json
{
	"email": "admin@unkle.com",
	"password": "password"
}
```

All the fallwing routes require the Authorization token set in the header

### Archives

See deleted contracts
`get /archives`

### Options

List options
`get /options`

Show an option
`get /options/:id`

### Users

List all users
`get /users`

Create user
`post /users`
body
```json
{
	"email": "admin2@unkle.com",
	"password": "password",
  "valid_password": "password",
  "role": "admin"
}
```

Show a User
`get /users/:id`

Delete a User
`delete /users/:id`

### Contracts

List all contracts
`get /contracts`

Create conctrat
`post /contracts`
body
```json
{
	"start_at": 1653345948,
	"end_at": 1853345948,
	"clients_id": [ 1 ],
  "options_id": [ 1 ]
}
``

Cancel a contract
`post /contracts/:id/cancel`
body
```json
{
	"end_at": 1853345948
}

Show a Contract
`get /contracts/:id`

Update a Contract
`put /contracts/:id`
body
```json
{
	"start_at": 1653345948,
	"end_at": 1853345948
}
```

Delete a contract
`delete /contracts/:id`

