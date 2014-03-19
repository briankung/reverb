# Record Accessor

The Record Accessor is a system that parses and sorts a set of records from a file and then exposes the processed records in an API. Each record consists of a last name, first name, gender, favorite color, and birth date. Each record may be delimited by comma, pipe, or space.

## Demo

To see a demo run against the provided test cases in `spec/samples/`:

1. Open a terminal window and `cd` to the `reverb` repository/folder
2. Run the `demo.rb` script by executing `ruby demo.rb`

## Specs

To run the specs:

1. Open a terminal window and `cd` to the `reverb` repository/folder
2. Ensure that you have the rspec gem by executing either `bundle install` or `gem install rspec`
3. Execute `rspec` from the application root