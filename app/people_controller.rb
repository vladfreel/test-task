require 'date'
class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    dollar = normalize_format(params[:dollar_format], '$')
    percent = normalize_format(params[:percent_format], '%')
    peoples = normalize_array(dollar.drop(1), dollar.first).concat(normalize_array(percent.drop(1), percent.first)).sort.flatten
    return peoples
  end

  private

  def normalize_format(text, sign)
    string_records = text.split("\n")
    string_records.map! do |line|
      line.strip.split(sign).map(&:strip)
    end

  end

  def normalize_array(arr, head)
    array = []
    arr.each do |line|
      date = Date.parse(line[head.index('birthdate')]).strftime("%-m/%-d/%Y")
      array << ["#{line[head.index('first_name')]}, #{line[head.index('city')]}, #{date}"]
    end
    array
  end
  attr_reader :params
end