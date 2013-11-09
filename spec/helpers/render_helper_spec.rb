require 'spec_helper'

describe RenderHelper do
  describe "#form_block" do
    context "no title" do
      it "renders the form_block partial" do
        helper.form_block { "hello" }.should match /hello/
      end
    end

    context "with title" do
      it "renders the form_block partial" do
        formblock = helper.form_block("some title") { "blah blah" }
        formblock.should match /blah blah/
        formblock.should match /some title/
      end
    end
  end
end
