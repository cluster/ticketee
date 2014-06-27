require 'spec_helper'

describe User do
  it "needs a password and confirmation to save" do
    u = User.new(name: "steve")
    u.save

    expect(u).to_not be_valid

    u.password = "password"
    u.email = "titi@toto.fr"
    u.password_confirmation = ""
    u.save

    expect(u).to_not be_valid

    u.password_confirmation = "password"
    u.save

    expect(u).to be_valid
  end

  it "needs password confirmation to match" do
    u = User.create(name: "steve", email: "toto@toto.fr", password: "hunter", password_confirmation: "hunter2")

    expect(u).to_not be_valid
  end

  it "requires an email" do
    u = User.new(name:"steve",
                 password: "password",
                 password_confirmation: "password")
    u.save
    expect(u).to_not be_valid

    u.email = "steve@example.com"
    u.save
    expect(u).to be_valid
  end
end

describe "authentication" do
  let(:user){ User.create(name: "steve", email: "toto@toto.fr", password: "hunter2", password_confirmation: "hunter2") }

  it "authenticate with a correct password" do
    expect(user.authenticate("hunter2")).to be
  end

  it "does not authenticate with an incorrect password" do
    expect(user.authenticate("hunter1")).to_not be
  end
end
