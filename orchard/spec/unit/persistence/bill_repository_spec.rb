require 'spec_helper'

module Orcharding
  describe BillRepository do
    before :all do
      BillRepository.seed = [
        {id: "1", title: "Bill Title 1", chamber: 'Senado'},
        {id: "2", title: "Bill title 2", chamber: 'C.Diputados'},
        {id: "3", title: "Bill title 3", chamber: 'Senado'},
        {id: "4", title: "Bill title 4", chamber: 'C.Diputados'}
      ]
      #BillRepository.seed = [
      #  Bill.new({id: "1", title: "Bill Title 1", chamber: 'Senado'}),
      #  Bill.new({id: "2", title: "Bill title 2", chamber: 'C.Diputados'}),
      #  Bill.new({id: "3", title: "Bill title 3", chamber: 'Senado'}),
      #  Bill.new({id: "4", title: "Bill title 4", chamber: 'C.Diputados'})
      #]
    end

    it "shouldn't find a non existing bill by id" do
      BillRepository.find_by_id("100").should == nil
    end

    it "finds bill by id" do
      hash = BillRepository.find_by_id("2")
      hash[:id].should == "2"
    end

    it "shouldn't find non existing bills by title" do
      BillRepository.find_by_chamber("Ciudadania").should == []
    end

    it "finds bills by title" do
      array = BillRepository.find_by_chamber('Senado')
      array.size.should == 2
    end

    it "creates a bill" do
      hash = BillRepository.create({title: "Bill Title 5", chamber: "Senado"})
      hash[:title].should == "Bill Title 5"
    end

    it "shouldn't update a non existing bill" do
      hash = BillRepository.update({id: "100", title: 'Updated Bill Title'})
      hash.should == nil
      BillRepository.find_by_id("100").should == nil
    end

    it "updates an existing bill" do
      hash = BillRepository.update({id: "3", title: 'Updated Bill Title'})
      hash[:title].should == "Updated Bill Title"
      BillRepository.find_by_id("3")[:title].should == "Updated Bill Title"
    end

    it "shouldn't destroy a non existing bill" do
      BillRepository.destroy("100").should == nil
    end

    it "destroys an existing bill" do
      BillRepository.destroy("4")[:id].should == "4"
      BillRepository.find_by_id("4").should == nil
    end
  end
end
