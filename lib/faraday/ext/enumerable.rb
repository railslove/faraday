module Enumerable
  def to_param(parts=nil, previous_base=nil)
    parts = []

    self.to_a.each do |key, value|
      base = build_base(key, previous_base)

      case value
      when Array
        values = value.map(&:strip).join(",")
        parts << build_param(base, values)
      when Hash
        parts << value.to_param(parts, base)
      else
        parts << build_param(base, value)
      end
    end

    parts.join("&")
  end

  private

  # {:a => {:b => {:c => "d"}}} => a[b][c]...
  # {:a => {:b => "d"}} => a[b]...
  def build_base(key, previous_base)
    return key unless previous_base

    "#{previous_base}[#{key}]"
  end

  def build_param(base, value)
    "#{base}=#{value}"
  end
end