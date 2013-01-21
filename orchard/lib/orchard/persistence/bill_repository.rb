module Orcharding
  class BillRepository
    class << self
      KEYGEN_DATA = [('0'..'9'), ('a'..'z'), ('A'..'Z')].map {|chars| chars.to_a}.flatten

      def seed=(data)
        @seed = data
      end

      def all
        @seed ||= []
      end

      def find_by_id(id)
        all.select {|bill| bill[:id] == id}.first
      end

      def find_by_chamber(name)
        all.select {|bill| bill[:chamber] == name}
      end

      def create(data)
        data[:id] = (0..10).map {KEYGEN_DATA[rand(KEYGEN_DATA.length)]}.join
        all << data
        data
      end

       def update(data)
         bill = find_by_id(data[:id])
         #updating hash, not using the Bill class
         bill.update(data) and return bill if bill
         nil
       end

       def destroy(id)
         #deletes element from array
         all.delete find_by_id(id)
       end
    end
  end
end
