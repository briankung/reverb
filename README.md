# Record Accessor

The Record Accessor is a system that parses and sorts a set of records from a file and then exposes the processed records in an API. Each record consists of a last name, first name, gender, favorite color, and birth date. Each record may be delimited by comma, pipe, or space.

## Usage

### RecordSet Demo

To see a demo parse the provided test cases in `spec/fixtures/`:

1. Open a terminal window and `cd` to the `reverb` repository/folder
2. Run the `demo.rb` script by executing `ruby demo.rb`

### Starting the server

1. Open a terminal window and `cd` to the `reverb` repository/folder
2. Install dependencies with `bundle install`
3. Start the server by typing `rackup`
4. `POST` some data to the `/records` endpoint. You can separate values with commas, spaces, or pipes. Try 'Poppins, Mary, Female, Mauve, 1934-06-23'.

Then try any of these endpoints in your browser of choice:

- [http://localhost:9292/records](http://localhost:9292/records)
- [http://localhost:9292/records/gender](http://localhost:9292/records/gender)
- [http://localhost:9292/records/birthdate](http://localhost:9292/records/birthdate)
- [http://localhost:9292/records/name](http://localhost:9292/records/name)


## Specs

To run the specs:

1. Open a terminal window and `cd` to the `reverb` repository/folder
2. Ensure that you have the rspec gem by executing either `bundle install` or `gem install rspec`
3. Execute `bundle exec rspec` from the application root

## Classes

The application is composed of three classes: `Record`, `RecordSet`, and `RecordAccessor`

### Record

The Record class is responsible for parsing individual lines of an input file. Every line in an input file contains information about a person in a string, separated by a comma, a space, or a pipe: last name, first name, gender, favorite color, and date of birth.

```ruby
# Pipe Separated Values (.psv)
"Einstein | Albert | Male | Green | 1879-03-14"

# Comma Separated Values (.csv)
"Curie, Marie, Female, Yellow, 1867-11-07"

# Space Separated Values (.ssv)
"Turing Alan Male Green 1912-06-03"
```

The Record class parses these strings and stores the data in a structured format internally, since Record inherits from Hash. It parses the data in a naive manner, relying on it to be in the proper order.

```ruby
record = Record.new("Einstein | Albert | Male | Green | 1879-03-14")
record[:last_name]  #=> "Einstein"
record[:first_name] #=> "Albert"
record[:gender] #=> "Male"
record[:favorite_color] #=> "Green"
record[:birthdate]  #=> "1879-03-14"
```

Finally, the Record class can display its contents in a human readable format:

```ruby
record.display #=> "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green"
```

### RecordSet

The RecordSet class inherits from Array and represents a list of Records. It is responsible for managing records, including sorting, displaying, and adding records. It must be initialized with a path to a properly formatted input file.

```ruby
# Note: the extension does not matter as long as the data is properly formatted.
records = RecordSet.new('/some/path/to/input.csv')

# The :order keyword can accept any of the Record class's KEYS:
# :last_name, :first_name, :gender, :favorite_color, :birthdate
records.list  #=> Returns the list of records in default order (by birthdate)
records.list(order: :gender)  #=> Returns the list of records in order of gender (then last name)

records.display #=> Displays the list of records in default order
records.display(order: :gender) #=> Displays the list of records in order of gender (then last name)

```

Records may be added the the RecordSet in the same manner as an Array.

```ruby
records << Record.new('LastName, FirstName, Gender, FavoriteColor, 1234-01-23')
```

Then they may be saved with `#save!`

```ruby
records.save! #=> Writes the current contents of record to the origin file in CSV format
```

### RecordAccessor

Finally, RecordAccessor::API is the Rack middleware that exposes the functionality of Record and RecordSet to HTTP endpoints. These API endpoints return structured data in JSON format:

- `POST /records/` Takes a parameter of 'record[new]' as the key, with the value being whatever data should be written to the record list: 'LastName, FirstName, Gender, FavoriteColor, 1234-01-23'
- `GET /records/` Returns a list of the records in order of retrieval from the source file
- `GET /records/gender` Returns a list of the records in order of gender, women first, then by last name.
- `GET /records/birthdate` Returns a list of the records in order of birthdate, ascending.
- `GET /records/name` Returns a list of the records in order of last name.

Any string following `/records/` in the URL is passed to `RecordSet#list` as the `order` keyword, so the remainder of Record class's `KEYS` can be used to sort the resultant JSON response, as well:

- `GET /records/first_name`
- `GET /records/last_name`
- `GET /records/favorite_color`