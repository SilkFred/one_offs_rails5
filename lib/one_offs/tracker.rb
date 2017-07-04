module OneOffs
  class Tracker
    include Mongoid::Document

    class << self
      def complete?(name)
        where(name: name).first.present?
      end

      def complete(name)
        create(:name => name)
      end
    end
  end
end

