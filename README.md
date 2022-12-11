Please check the following RSpec issue

https://github.com/rspec/rspec-core/issues/2767

## Usage

```
# Clone the repo
# Navigate to it
$ bundle install
```

### Reproduce the leak

```
$ bundle exec ruby test.rb
```

On the 10.000th iteration the process' memory is at **~800Mb**.

### Confirm fix

```
$ WITH_FIX=true bundle exec ruby test.rb
```

The process' memory has reached a plateau - on the 10.000th iteration it is at **~33Mb**.
