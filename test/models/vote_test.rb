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

    it "can access usre through user_id" do 
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
end
