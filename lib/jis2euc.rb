
require File.join(File.dirname(__FILE__),'jis2euc/libjis2euc')


module Jis2euc
   #
   # set verbose to true will print out the detail parse and conversion information
   # 
  def self.jis2euc s ,verbose = false
	 arib_jis_to_euc s , verbose
end

  def self.euc2utf8 s
   eucjp_to_utf8 s
  end

end
