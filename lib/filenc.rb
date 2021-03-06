require 'rubygems'
require 'openssl'

class Filenc

  attr_reader :key, :algo, :iv, :file, :opt

  def initialize(o)
    # Set Strong phrase value for @key > 32 and @iv > 16
    @key = ''
    @iv = ''
    # Default Algorithm set to AES-256-CBC
    @algo = 'AES-256-CBC'
    @file = o[:file]
    @opt = o
    raise "initialize @key and @iv values (@iv>15,@key>31 for AES-256-CBS)" if @key == '' or @iv == '' 
    raise "initialize @iv>15 & @key>31 for AES-256-CBS" if @algo == 'AES-256-CBC' and ( @key.length < 32 or @iv.length < 16 )
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
    puts "encrypted to file '#{encfile}'"
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
    puts "decrypted to file '#{decfile}'"
  end

end 
