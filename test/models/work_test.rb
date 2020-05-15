require "test_helper"

describe Work do
  describe "validations" do 
    it "is valid when all fields are present" do 
      work = works(:titanic)

      result = work.valid?
      expect(result).must_equal true
    end

    it "is invalid without title" do 
      work = works(:titanic)
      work.title = nil 
      work.save

      result = work.valid?
      expect(result).must_equal false 
      expect(work.errors.messages).must_include :title 
    end

    it "is invalid if title is not unique" do 
      work = Work.create(
        category: "book", 
        title: "Titanic", 
        creator: "James Cameron",
        publication_year: 1998,
        description: "Wonderful movie"
      )

      work.save 

      result = work.valid?
      expect(result).must_equal false 
      expect(work.errors.messages).must_include :title
    end

    it "is invalid if title is not unique but of different case" do
      work = Work.create(
        category: "book", 
        title: "titanic", 
        creator: "James Cameron",
        publication_year: 1998,
        description: "Wonderful movie"
      )

      work.save 

      result = work.valid?
      expect(result).must_equal false 
      expect(work.errors.messages).must_include :title
    end

    it "is invalid without creator" do
      work = works(:titanic)
      work.creator = nil 
      work.save

      result = work.valid?
      expect(result).must_equal false 
      expect(work.errors.messages).must_include :creator
    end
  end
end
