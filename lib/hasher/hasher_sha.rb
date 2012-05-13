# $Id$

require 'digest/sha1'
require 'hasher_base'

class Hasher::Sha < Hasher::Base
  
  def hash *values_to_hash
    if values_to_hash.length == 0
      return ''
    end
    
    if values_to_hash.length == 1
      return digest values_to_hash.first
    end
    
    hashed_values = values_to_hash.map do |x|
       digest x
    end
    
    
    hashed_values.reduce do |memo, obj| 
      digest "#{memo}::#{obj}"
    end
  end
  
  private
  def digest x
    d = Digest::SHA1.new
    d.hexdigest(x.to_s)
    to_s_62(d.hexdigest(x.to_s).hex)
  end
  
  #http://refactormycode.com/codes/125-base-62-encoding
  SIXTYTWO = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
  def to_s_62(i)
    return '0' if i == 0
    s = ''
    while i > 0
      i,r = i.divmod(62)
      s = (SIXTYTWO[r]) + s
    end
    s
  end
  
end