require "test_helper"

describe User do
  describe "validations" do
    it "is valid when all fields are present" do 
      user = users(:user_one)

      result = user.valid?
      expect(result).must_equal true 
    end

    it "is invalid without username" do 
      user = users(:user_one)
      user.username = nil 
      user.save

      result = user.valid?
      expect(result).must_equal false 
      expect(user.errors.messages).must_include :username 
    end

    it "is invalid if username is an empty string" do 
      user = users(:user_one)
      user.username = ""
      user.save

      result = user.valid?
      expect(result).must_equal false 
      expect(user.errors.messages).must_include :username 
    end

    it "is invalid if username is less than 3 chars" do 
      user = users(:user_one)
      user.username = "ab"
      user.save

      result = user.valid?
      expect(result).must_equal false 
      expect(user.errors.messages).must_include :username 
    end

    it "is valid if username is 3 chars long" do 
      user = users(:user_one)
      user.username = "abc"
      user.save

      result = user.valid?
      expect(result).must_equal true 
    end

    it "is valid if username is 25 chars long" do 
      user = users(:user_one)
      user.username = "abcdeabcdeabcdeabcdeabcde"
      user.save

      result = user.valid?
      expect(result).must_equal true 
    end

    it "is invalid if username is more than 25 chars long" do 
      user = users(:user_one)
      user.username = "abcdeabcdeabcdeabcdeabcdef"
      user.save

      result = user.valid?
      expect(result).must_equal false 
      expect(user.errors.messages).must_include :username 
    end
  end

  describe "relations" do 
    it "can have many votes" do 
      vote1 = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      vote1 = Vote.create(
        work_id: works(:some_album).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(users(:user_one).votes.count).must_equal 2
    end

    it "can access work through votes" do 
      vote1 = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      vote1 = Vote.create(
        work_id: works(:some_album).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(users(:user_one).votes[0].work.title).must_equal "Titanic"
    end
  end
end
