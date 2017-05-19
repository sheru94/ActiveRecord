require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    @columns = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      "#{table_name}"
    SQL

    @columns = @columns[1].keys.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |value|
        self.attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    # ...
    results.map { |result| self.new(result) }

  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL
    parse_all(result).first
  end

  def initialize(params = {})
    params.each do |col, value|
      col = col.to_sym
      if self.class.columns.include?(col)
        self.send("#{col}=", value)
      else
        raise "unknown attribute '#{col}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...

  end

  def insert
    

    DBConnection.execute(<<-SQL, col1, col2, col3)
      INSERT INTO
        #{table_name}
      VALUES
        (? ? ?)
    SQL





  end

  def update
    # ...
  end

  def save
    # ...
  end
end
