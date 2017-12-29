require 'digest'

class Block
  attr_reader :index, :timestamp, :nonce, :hash, :data, :previous_hash

  def initialize(index,  data, previous_hash)
    @index = index
    @timestamp = Time.now
    @data = data
    @previous_hash = previous_hash
    @hash = calculate_hash
    @nonce = 0
  end

  def calculate_hash
    @hash = Digest::SHA256.hexdigest(@index.to_s + @timestamp.to_s + @data.to_s + @previous_hash.to_s + @nonce.to_s)
  end

  def mine(difficulty)
    puts "Mining Block: #{index}"
    time_started = Time.now

    until @hash.start_with?("0" * difficulty)
      @nonce += 1
      @hash = calculate_hash
      print "Block hash: #{hash}\t Time Elapsed: #{Time.at((Time.now - time_started).to_i).utc.strftime("%H:%M:%S")}\r"
      $stdout.flush
    end

    puts "\nCalculated block hash: #{hash}, using nonce: #{nonce}"
  end
end
