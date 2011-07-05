
require File.join(File.dirname(__FILE__),'jis2euc/libjis2euc')


module Jis2euc
  # Your code goes here...
  def self.jis2euc s
	 arib_jis_to_euc s
end

  def self.euc2utf8 s
   eucjp_to_utf8 s
  end

end
