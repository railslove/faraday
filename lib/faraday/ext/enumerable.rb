module Enumerable
  def to_param(parts=nil, base=nil)
    parts = []

    self.to_a.each do |key, value|
      case value
      when Array
        values = value.map(&:strip).join(",")
        parts << build_param(key, values, base)
      when Hash
        parts << value.to_param(parts, key)
      else
        parts << build_param(key, value, base)
      end
    end

    parts.join("&")
  end

  private

  def build_param(key, value, base)
    if base
      "#{base}[#{key}]=#{value}"
    else
      "#{key}=#{value}"
    end
  end
end