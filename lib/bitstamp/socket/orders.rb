module Bitstamp::Socket
  module Orders
    def live_order_book(currency_pair:, &block)
      channel = "order_book_#{currency_pair}"
      event   = 'data'

      listen(channel, event, block)
    end

    def live_orders_created(currency_pair:, &block)
      channel = "live_orders_#{currency_pair}"
      event   = 'order_created'

      listen(channel, event, block)
    end

    def live_orders_changed(currency_pair:, &block)
      channel = "live_orders_#{currency_pair}"
      event   = 'order_changed'

      listen(channel, event, block)
    end

    def live_orders_changed(currency_pair:, &block)
      channel = "live_orders_#{currency_pair}"
      event   = 'order_deleted'

      listen(channel, event, block)
    end

    def live_full_order_book(currency_pair:, &block)
      channel = "diff_order_book_#{currency_pair}"
      event   = 'data'

      listen(channel, event, block)
    end
  end
end
