require "rails_helper"

RSpec.describe BilldeskMailer, :type => :mailer do
  describe "regular" do
    let(:mail) { BilldeskMailer.regular }

    it "renders the headers" do
      expect(mail.subject).to eq("Regular")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "club" do
    let(:mail) { BilldeskMailer.club }

    it "renders the headers" do
      expect(mail.subject).to eq("Club")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
