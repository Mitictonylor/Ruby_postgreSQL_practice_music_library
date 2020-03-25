class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @name = option['name']
  end
end
