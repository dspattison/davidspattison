class Urlshort < ActiveRecord::Base
  validates_uniqueness_of :code
            
  #validates_uniqueness_of :target_url
  
  validates_each :code do |record, attr, value|
    record.errors.add(attr, "Must be different from the url") if value == record.send(:target_url)
  end
  
  #checks that target_url looks like a url
  validates_format_of :target_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  #when null/empty we will populate it
  validates_format_of :code, :with => /^[a-zA-Z0-9]*$/
  
  
  validate :next_code
  
  def get_short_url
    "https://patt.us/u/#{code}"
  end
  
  
  private

  def find_avaliable_code(length=1)
    code = ''
    length.times do
      code += get_random_char
    end
    logger.info code
    if Urlshort.find_by_code code
      return find_avaliable_code(length+1)
    end
    logger.info "Found ava code: #{code}"
    return code
  end
  
  def get_random_char
    x = rand(62)
    logger.info "rand int is #{x}"
    return (x+48).chr if x < 10
    return (x+65-10).chr if x < 36
    return (x+97-36).chr
  end
  
  def next_code
    if new_record?
      if self.code.nil? || self.code.empty?
        self.code = find_avaliable_code
      end
    end
  end
  
  
end
