class ShortCode

  def self.encode(uuid)
    [uuid.tr('-', '').scan(/../).map(&:hex).pack('c*')].pack('m*').tr('+/', '-_').slice(0..21)
  end

  def self.decode(slug)
    (slug.tr('-_', '+/') + '==').unpack('m0').first.unpack('H8H4H4H4H12').join('-')
  end

end