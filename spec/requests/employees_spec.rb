require 'rails_helper'
require 'net/http'
require "uri"
require "json"
require "faker"

$http = Net::HTTP.new("dummy.restapiexample.com")
$id
$name = Faker::Name.unique.name
$salary = Faker::Number.within(range: 10000..1000000)
$age = Faker::Number.within(range: 1..100)


describe "Dummy Rest API Example" do
  it "creates employee data" do
    request = Net::HTTP::Post.new("/api/v1/create")
    request.body= {"name":$name, "salary":$salary, "age":$age}.to_json

    response = $http.request(request)

    res = JSON.parse(response.body)

  	$id = res["id"]
  	expect(res["id"].empty?).to eq(false)
  	expect(res["name"]).to eq($name)
  	expect(res["salary"]).to eq($salary.to_s)
  	expect(res["age"]).to eq($age.to_s)

  end

  it "gets a particular employee data" do
    request = Net::HTTP::Get.new("/api/v1/employee/"+$id)
    response = $http.request(request)

    res = JSON.parse(response.body)

    expect(res["id"]).to eq($id)
    expect(res["employee_name"]).to eq($name)
    expect(res["employee_salary"]).to eq($salary.to_s)
    expect(res["employee_age"]).to eq($age.to_s)
  end

  it "delete an employee record" do
    request = Net::HTTP::Delete.new("/api/v1/delete/"+$id)
    response = $http.request(request)

    res = JSON.parse(response.body)

    message = res["success"]["text"]

    expect(message).to eq("successfully! deleted Records")

  end
end