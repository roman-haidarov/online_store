# Online_store

API for CRUD users-resource

### Dependencies
* Ruby 2.7.1
* Rails 6.1.6
* PostgreSQL

### Install project
```
$ git clone https://github.com/roman-haidarov/online_store.git
$ cd online_store
```

### Instal dependencies
#### Ruby
```
$ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ \curl -sSL https://get.rvm.io | bash
$ rvm install 2.7.1
$ rvm use ruby-2.7.1
```

#### Prepare application
```
$ bundle install
```

### Create database
```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

### Run tests
```
$ bundle exec rspec spec/
```

### Run application
```
$ rails server
```