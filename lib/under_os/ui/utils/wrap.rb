#
# The raw -> abstraction wrapping code
# for UI::Views
#
module UnderOs::UI::Wrap
  INSTANCES_CACHE = {}
  RAW_WRAPS_MAP   = {}
  WRAPS_TAGS_MAP  = {}

  def self.included(base)
    base.instance_eval do
      attr_accessor :_

      def self.wraps(raw_class, options={})
        RAW_WRAPS_MAP[self] = raw_class
        WRAPS_TAGS_MAP[options[:tag].to_s] = self if options[:tag]
      end

      def self.new(options={}, *args)
        return INSTANCES_CACHE[options] if INSTANCES_CACHE[options]

        if options.is_a?(UIView)
          klass  = find_wrap_for(options.class); return nil if ! klass
          inst   = klass.alloc
          inst._ = options; options = args.shift || {}
        else
          inst   = alloc
          inst._ = find_raw_class_for(self).alloc.initWithFrame([[0, 0], [0, 0]])
        end

        INSTANCES_CACHE[inst._] = inst
        inst.__send__ :initialize, options, *args
        inst
      end

      def self.find_wrap_for(raw_class)
        RAW_WRAPS_MAP.each do |wrap, raw|
          return wrap if raw == raw_class
        end

        return nil
      end

      def self.find_raw_class_for(wrap)
        while wrap
          return RAW_WRAPS_MAP[wrap] if RAW_WRAPS_MAP[wrap]
          wrap = wrap.superclass
        end
      end

      def self.wrap_for(raw_view)
        INSTANCES_CACHE[raw_view]
      end
    end
  end

end
