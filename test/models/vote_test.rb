require "test_helper"

describe Vote do
  describe "relations" do 
    it "can access work through work_id" do 
      vote = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(vote.work_id).must_equal works(:titanic).id
    end

    it "can access work through work" do 
      vote = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(vote.work.title).must_equal works(:titanic).title
    end

    it "can access user through user_id" do 
      vote = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(vote.user_id).must_equal users(:user_one).id
    end

    it "can access user through user" do 
      vote = Vote.create(
        work_id: works(:titanic).id,
        user_id: users(:user_one).id,
        date: Date.today
      )

      expect(vote.user.username).must_equal users(:user_one).username
    end
  end

  describe "validations" do 
    it "must have a user id" do
      vote = Vote.create(work_id: works(:titanic).id, date: Date.today)

      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user
    end

    it "must have a work id" do 
      vote = Vote.create(user_id: users(:user_one).id, date: Date.today)

      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work
    end
  end
end
