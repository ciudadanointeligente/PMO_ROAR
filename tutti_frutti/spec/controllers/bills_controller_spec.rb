require 'spec_helper'

describe BillsController do
  it "should return json for a single bill" do
    Orcharding::Bill.stub(:find_by_id) { Orcharding::Bill.new({id: 1, title: 'Title 1', chamber: 'Senado'}) }
    get :show, id: 1, format: :json
    puts "<response>"
    puts response.body
    puts "</response>"
    response.body.should == {id: 1, title: 'Title 1', chamber: 'Senado', _links: {self: {href: 'http://fru.it/bills/1'}}}.to_json
  end

  it "should return json for bills collection" do
    Orcharding::Bill.stub(:all) {[
      Orcharding::Bill.new({id: 1, title: 'Title 1', chamber: 'Senado'}),
      Orcharding::Bill.new({id: 2, title: 'Title 2', chamber: 'C.Diputados'})
    ]}
    get :index, format: :json
    response.body.should == {bills: [
      {id: 1, title: 'Title 1', chamber: 'Senado', _links: {self: {href: 'http://fru.it/bills/1'}}},
      {id: 2, title: 'Title 2', chamber: 'C.Diputados', _links: {self: {href: 'http://fru.it/bills/2'}}}
    ]}.to_json
  end
end