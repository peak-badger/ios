module Digest
  module MD5
    extend self

    def hex_digest(string)
      NSData.MD5HexDigest(string.dataUsingEncoding(NSUTF8StringEncoding))
    end

  end
end