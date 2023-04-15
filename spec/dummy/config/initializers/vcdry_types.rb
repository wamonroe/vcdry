require_relative "../../lib/custom_hash"

VCDry::Types.add_type(:custom_hash, ->(value) { CustomHash.new(value) })
