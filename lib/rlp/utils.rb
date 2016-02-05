module RLP
  module Utils
    class <<self
      ##
      # Do your best to make `obj` as immutable as possible.
      #
      # If `obj` is a list, apply this function recursively to all elements and
      # return a new list containing them. If `obj` is an instance of
      # {RLP::Sedes::Serializable}, apply this function to its fields, and set
      # `@_mutable` to `false`. If `obj` is neither of the above, just return
      # `obj`.
      #
      # @return [Object] `obj` after making it immutable
      #
      def make_immutable!(obj)
        if obj.is_a?(Sedes::Serializable)
          obj.make_immutable!
        elsif list?(obj)
          obj.map {|e| make_immutable!(e) }
        else
          obj
        end
      end
    end

    extend self

    def primitive?(item)
      item.instance_of?(String)
    end

    def list?(item)
      item.respond_to?(:each)
    end

    def bytes_to_str(v)
      v.unpack('U*').pack('U*')
    end

    def str_to_bytes(v)
      v.b
    end

    def big_endian_to_int(v)
      v.unpack('H*').first.to_i(16)
    end

    def int_to_big_endian(v)
      hex = v.to_s(16)
      hex = "0#{hex}" if hex.size.odd?
      [hex].pack('H*')
    end

    def encode_hex(b)
      raise TypeError, "Value must be an instance of String" unless b.instance_of?(String)
      b = str_to_bytes(b) unless b.encoding.name == 'ASCII-8BIT'
      b.unpack("H*").first
    end
  end
end
