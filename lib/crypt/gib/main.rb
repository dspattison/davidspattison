require 'rubygems'
require 'gibberish'

module Crypt
  module Gib
    class Main
      def self.initalize
        
      end
      
      def new_key_set
        k = Gibberish::RSA.generate_keypair(1024)
        return [k.public_key, k.private_key]
      end
      
      def encrypt text_plain, public_key
        cipher = Gibberish::RSA.new(public_key)
        cipher.encrypt(text_plain)  
      end
      
      def decrypt text_encrypted, secret_key
        cipher = Gibberish::RSA.new(secret_key)
        cipher.decrypt(text_encrypted)
      end
    end
  end
end

if __FILE__ == $0
  text = 'this is used for testing -- top secret'
  puts text
  
  crypter = Crypt::Gib::Main.new
  key_set = crypter.new_key_set
  public_key = key_set[0]
  secret_key = key_set[1]
  
  encrypted = crypter.encrypt text, public_key
  puts encrypted
  
  decrypted = crypter.decrypt encrypted, secret_key
  puts decrypted
  
  
end