module RLP
  module Constant
    SHORT_LENGTH_LIMIT = 56
    LONG_LENGTH_LIMIT = 256**8

    PRIMITIVE_PREFIX_OFFSET = 0x80
    LIST_PREFIX_OFFSET = 0xc0

    BYTE_ZERO = "\x00".force_encoding('ascii-8bit').freeze
    BYTE_EMPTY = ''.force_encoding('ascii-8bit').freeze
  end
end
