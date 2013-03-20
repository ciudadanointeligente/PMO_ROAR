require 'spec_helper'

describe BillsController do

  def format bills
    bills_attrib = []
    bills.each do |bill|
      attrib = bill.attributes
      attrib.delete '_id'
      attrib.delete 'created_at'
      attrib.delete 'updated_at'
      attrib['events'] = []
      attrib['urgencies'] = []
      attrib['reports'] = []
      bills_attrib.push attrib
    end

    result = {"bills" => bills_attrib}.to_json
  end

"{\"bills\":["\
      "{\"uid\":\"1\",\"title\":\"Title 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/1\"}}},"\
      "{\"uid\":\"2\",\"title\":\"Title 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/2\"}}},"\
      "{\"uid\":\"3\",\"title\":\"Header 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/3\"}}},"\
      "{\"uid\":\"4\",\"title\":\"Header 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/4\"}}}"\
      "]}"

  before(:each) do
    @bill1 = Orcharding::Bill.new({uid: '1', title: 'Title 1', origin_chamber: 'Senado'})
    @bill1.save()
    @bill2 = Orcharding::Bill.new({uid: '2', title: 'Title 2', origin_chamber: 'C.Diputados'})
    @bill2.save()
    @bill3 = Orcharding::Bill.new({uid: '3', title: 'Header 1', origin_chamber: 'Senado'})
    @bill3.save()
    @bill4 = Orcharding::Bill.new({uid: '4', title: 'Header 2', origin_chamber: 'C.Diputados'})
    @bill4.save()

    Sunspot.remove_all(Orcharding::Bill)
    Sunspot.index!(Orcharding::Bill.all)
  end

  # it "should return json for a single bill" do
  #   Orcharding::Bill.stub(:find_by_id) { Orcharding::Bill.new({id: 1, title: 'Title 1', chamber: 'Senado'}) }
  #   get :show, id: 1, format: :json
  #   puts "<response>"
  #   puts response.body
  #   puts "</response>"
  #   response.body.should == {id: 1, title: 'Title 1', chamber: 'Senado', _links: {self: {href: 'http://fru.it/bills/1'}}}.to_json
  # end

  # it "should return json for bills collection" do
  #   Orcharding::Bill.stub(:all) {[
  #     Orcharding::Bill.new({id: 1, title: 'Title 1', chamber: 'Senado'}),
  #     Orcharding::Bill.new({id: 2, title: 'Title 2', chamber: 'C.Diputados'})
  #   ]}
  #   get :index, format: :json
  #   response.body.should == {bills: [
  #     {id: 1, title: 'Title 1', chamber: 'Senado', _links: {self: {href: 'http://fru.it/bills/1'}}},
  #     {id: 2, title: 'Title 2', chamber: 'C.Diputados', _links: {self: {href: 'http://fru.it/bills/2'}}}
  #   ]}.to_json
  # end

  describe "show" do
    it "should return json for the requested bill" do
      get :show, id: '1', format: :json
      response.body.should == "{\"uid\":\"1\",\"title\":\"Title 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/1\"}}}"
    end
  end
  describe "index" do
    it "should return json with a set of bills" do
      get :index, format: :json
      puts '<response>'
      puts response.body
      puts '</response>'
      response.body.should == "{\"bills\":["\
      "{\"uid\":\"1\",\"title\":\"Title 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/1\"}}},"\
      "{\"uid\":\"2\",\"title\":\"Title 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/2\"}}},"\
      "{\"uid\":\"3\",\"title\":\"Header 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/3\"}}},"\
      "{\"uid\":\"4\",\"title\":\"Header 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/4\"}}}"\
      "]}"
    end

    xit "should return a paginated result" do
      get :index, page: '2', per_page: '2', format: :json
      puts '<response>'
      puts response.body
      puts '</response>'
      response.body.should == "{\"bills\":["\
      "{\"uid\":\"3\",\"title\":\"Header 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/3\"}}},"\
      "{\"uid\":\"4\",\"title\":\"Header 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/4\"}}}"\
      "]}"
    end

    it "should return simple queries filtered by title" do

      puts '<format>'
      puts format [@bill1]
      puts '</format>'

      get :search, q: 'Title', format: :json
      response.body.should == "{\"bills\":["\
      "{\"uid\":\"1\",\"title\":\"Title 1\",\"origin_chamber\":\"Senado\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/1\"}}},"\
      "{\"uid\":\"2\",\"title\":\"Title 2\",\"origin_chamber\":\"C.Diputados\","\
      "\"events\":[],\"urgencies\":[],\"reports\":[],"\
      "\"_links\":{\"self\":{\"href\":\"http://localhost:9292/bills/2\"}}}"\
      "]}"
      # response.body.should == format [@bill1, @bill2]
    end

    xit "should return results filtered by origin chamber" do
      response.body.should == format [@bill1, @bill2]

    end
  end

end