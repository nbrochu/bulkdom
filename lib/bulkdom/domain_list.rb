module Bulkdom
  class DomainList
    attr_accessor :list, :tlds, :results, :processed
    
    def initialize()
      @list, @tlds = ["example"], [".com"]
      @processed = false
    end
    
    def process
      self.results = whois_check(dns_record_check(generate_results_hash(self.list, self.tlds), self.tlds), self.tlds)
      self.processed = true
    end
    
    def return_available(tld)
      process unless self.processed
      
      available_domains = []
      
      self.results.each do |i|
        available_domains << "#{i[:domain]}#{tld}" if i[:tlds]["#{tld.split('.')[1]}_available"] == "y"
      end
      
      return available_domains
    end
    
    private
    
    def generate_results_hash(list, tlds)
      results = []
      
      list.each do |d|
        item = {}
        item[:domain] = d
        item[:tlds] = {}
        
        tlds.each do |tld|
          item[:tlds]["#{tld.split('.')[1]}_available"] = "u"
        end
        
        results << item
      end
      
      return results
    end
    
    def dns_record_check(results, tlds)
      results.each do |i|
        tlds.each do |tld|
          begin
            Resolv.getaddress("#{i[:domain]}#{tld}")
            i[:tlds]["#{tld.split('.')[1]}_available"] = "n"
          rescue Resolv::ResolvError
            i[:tlds]["#{tld.split('.')[1]}_available"] = "u"
          end
        end
      end
      
      return results
    end
   
   def whois_check(results, tlds)
     @wc = Whois::Client.new
     @wc.timeout = nil
     
     results.each do |i|
       tlds.each do |tld|
         if i[:tlds]["#{tld.split('.')[1]}_available"] == "u"
           begin
             d = @wc.query("#{i[:domain]}#{tld}")
             if d.available?
               i[:tlds]["#{tld.split('.')[1]}_available"] = "y"
             else
               i[:tlds]["#{tld.split('.')[1]}_available"] = "n"
             end
           rescue Exception => e
             i[:tlds]["#{tld.split('.')[1]}_available"] = "u"
           end
         end
       end
     end
     
     return results
   end

  end
end