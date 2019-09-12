class ExistentialSet
  # Configurable parameters
  attr_accessor :sameness_threshold, :recursion_limit

  def initialize(params = {})
    @raw_set    = []
    @master_set = []

    @sameness_threshold = params.fetch('sameness_threshold', 10)
    @recursion_limit    = params.fetch('recursion_limit',    1)

  end

  def self.same?(apple, orange, domain: {}, params: {})
    # todo: Scale distance over domain
    # todo: Better params passing
    distance(apple, orange) < params.fetch('sameness_threshold', 10)
  end

  def self.distance(apple, orange)
    d = DistanceComparator.distance(apple, orange)
    puts "Distance from #{apple.inspect} to #{orange.inspect} is #{d.inspect}"

    d
  end

  def items
    @uniq_set   = []

    @raw_set.each do |potential_item|
      # If this item is unique from all items already in the uniq set, add it
      unless @uniq_set.any? { |uniq_item| self.class.same?(uniq_item, potential_item) }
        # todo: Create QuantumHash.new(potential_item) here (keyed on which uniq item matched)
        #       and add it to @uniq_set with potential_item as a version
        @uniq_set << potential_item

        # todo: If there's already a QuantumHash that's same to this item, add this item
        #       as a version
      end
    end

    @uniq_set
  end

  def add(obj)
    @raw_set << obj

    add_to_master_set(obj)
  end

  def count
    items.count
  end

  # Pass these methods on through to the @raw_set array itself
  def actual_count; @raw_set.count; end
  
  private

  attr_accessor :raw_set
  attr_accessor :uniq_set
  attr_accessor :master_set

  def add_to_master_set(obj)
    # todo: Rewrite this into the #items method
    if obj.is_a?(Hash)
      master_equivalent = @master_set.detect { |item| self.class.same?(item, obj) }
      if master_equivalent.nil?
        # If we don't have anything like this in the master set yet, create one
        @master_set << QuantumHash.new(obj)
      
      else
        # If we do have something that's already the "same" as this obj, add this as a version
        master_equivalent.versions << obj

      end
    else
      puts "todo: Something non-hash being added to master set"
    end
  end

  class QuantumHash
    attr_accessor :versions

    def initialize(obj)
      @versions = ExistentialSet.new
      @versions.add(obj)
    end
  end
  
  class DistanceComparator
    require "levenshtein"

    def self.distance(apple, orange)
      puts "Comparison of #{apple.inspect} and #{orange.inspect}"
      # todo: Handle cross-type comparisons also
      return 100 unless apple.class.name == orange.class.name

      case apple.class.name
      when String.name
        Levenshtein.distance(apple.to_s, orange.to_s)
      when Integer.name
        (apple - orange).abs
      when Float.name
        (apple - orange).abs
      when Hash.name
        hash_comparison(apple, orange)
      when QuantumHash
        binding.pry

      else
        # Unrecognized type, so lets just fall back on native equivalence
        # apple == orange
        69
      end
    end

    private

    def self.hash_comparison(apple, orange)
      key_set = apple.keys + orange.keys
      key_distance = 0

      key_set.each do |key|
        puts "Key #{key}: #{apple[key].inspect} vs #{orange[key].inspect} = distance #{distance(apple[key], orange[key])}"
        key_distance += distance(apple[key], orange[key])
      end
      puts "Total key distance = #{key_distance} (for #{key_set.count} keys)"
      key_distance /= key_set.count.to_f

      puts "Final key distance = #{key_distance}"
      key_distance
    end

  end
end
