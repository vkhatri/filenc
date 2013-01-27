require 'rubygems'
require 'openssl'

class Filenc

  attr_reader :key, :algo, :iv, :opt, :file, :color

  def initialize(o)
    @key = '0n#f0x)n#l!0n!sh#quiv@l#ntinth#j8n3l#'
    @iv = '060//>,#%**12!@54rQu0t#!@$#$WEs09'
    @algo = 'AES-256-CBC'
    @opt = o
    @file = o[:file]
    @color = Term::ANSIColor
  end

  def enc
    puts "encrypting file '#{file}'"
    aes = OpenSSL::Cipher::Cipher.new(algo)
    aes.encrypt
    aes.key = key
    aes.iv = iv
    encfile = "#{file}.enc"
    File.open(encfile,'w') do |enc|
      File.open(file) do |f|
        loop do
          r = f.read(4096)
          break unless r
          cipher = aes.update(r)
          enc << cipher
        end
      end
      enc << aes.final
    end
    File.chown(opt[:userid],opt[:groupid],encfile)
    puts "encrypted to file '#{encfile}'")
  end

  def dec
    puts "decrypting file '#{file}'"
    aes = OpenSSL::Cipher::Cipher.new(algo)
    aes.decrypt
    aes.key = key
    aes.iv = iv
    decfile = "#{file}.dec"
    File.open(decfile,'w') do |dec|
      File.open(file) do |f|
        loop do 
          r = f.read(4096) 
          break unless r        
          cipher = aes.update(r)       
          dec << cipher                       
        end                                        
      end          
      dec << aes.final
    end
    File.chown(opt[:userid],opt[:groupid],decfile)
    puts "decrypted to file '#{decfile}'")
  end

end 
