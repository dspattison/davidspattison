require 'rubygems'
require 'escape'
module Crypt
  module Shell
    class Main
      
      def self.initalize
        
      end
      
      def new_key_set
        uniqid= rand.to_s
        `mkdir #{File.join('/tmp', uniqid)}`
        private_key_file = File.join('/tmp', uniqid, 'private_key.pem')
        public_key_file = File.join('/tmp', uniqid, 'public_key.pem')
        
        #create key file
       `openssl genpkey -algorithm RSA -out #{private_key_file}`
       
       private_key = read_pem private_key_file
       
       `cat #{private_key_file} | openssl rsa -pubkey #{private_key_file}`
       
       public_key = read_pem public_key_file
       
       `rm -rf #{File.join('/tmp', uniqid)} `
       [public_key, private_key] 
     end
      
      def encrypt text_plain, public_key
        'dfasdfadsfasdfa'
      end
      
      def decrypt text_encrypted, secret_key
        'the text'
      end
      
      private
      
      def read_pem file
        contents = `cat #{file} | grep -v '\----'`
        return contents.split("\n").join('')
      end
    end
  end
end


if __FILE__ == $0
  text = 'top secret'
  puts text
  
  crypter = Crypt::Shell::Main.new
  key_set = crypter.new_key_set
  public_key = key_set[0]
  secret_key = key_set[1]
  
  encrypted = crypter.encrypt text, public_key
  puts encrypted
  
  decrypted = crypter.decrypt encrypted, secret_key
  puts decrypted
  
  
  
end