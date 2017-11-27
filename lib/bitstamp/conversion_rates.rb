module Bitstamp
  module ConversionRates
    def eur_usd_conversion_rate
      return call(request_uri('eur_usd'), 'GET', nil)
    end
  end
end
