# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class GoogleBaseExtension < Spree::Extension
  version "1.0"
  description "Google Base Extension"
  url "http://www.endpoint.com/"

  def activate
    Taxon.class_eval do
      has_one :taxon_map
    end
  end
end
