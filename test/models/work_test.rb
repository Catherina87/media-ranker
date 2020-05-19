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

    it "is invalid without publication_year" do 
      work = works(:titanic)
      work.publication_year = nil 
      work.save 

      result = work.valid?
      expect(result).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it "is invalid if publication_year is not a number" do 
      work = works(:titanic)
      work.publication_year = "year"
      work.save 

      result = work.valid?
      expect(result).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it "is invalid without description" do 
      work = works(:titanic)
      work.description = nil 
      work.save 

      result = work.valid? 
      expect(result).must_equal false 
      expect(work.errors.messages).must_include :description 
    end
  end

  describe "relations" do 
    it "can have many votes" do 
      work = works(:titanic)
      user_1 = User.create(username: "Mary")
      user_2 = User.create(username: "John")
      vote_1 = Vote.create(work_id: work.id, user_id: user_1.id, date: Date.today)
      vote_2 = Vote.create(work_id: work.id, user_id: user_2.id, date: Date.today)

      expect(work.votes.count).must_equal 2
    end

    it "can access user through votes" do 
      work = works(:titanic)
      user_1 = User.create(username: "Mary")
      user_2 = User.create(username: "John")
      vote_1 = Vote.create(work_id: work.id, user_id: user_1.id, date: Date.today)
      vote_2 = Vote.create(work_id: work.id, user_id: user_2.id, date: Date.today)

      expect(work.votes[0].user.username).must_equal "Mary"
    end
  end

  describe "custom methods" do 
    describe "sort_album_works" do 
      it "sorts works by albums" do 
        albums = Work.sort_album_works

        result = albums.length 
        expect(result).must_equal 10

        vote1 = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:some_album).id,
          date: "Today"
        )

        vote2 = Vote.create(
          user_id: users(:user_one).id, 
          work_id: works(:some_album).id,
          date: "Today"
        )

        num_of_votes = works(:some_album).votes.count 
        expect(num_of_votes).must_equal 2

        albums = Work.sort_album_works
        expect(albums[0].title).must_equal works(:some_album).title
      end    
    end

    describe "sort_book_works" do 
      it "sorts works by books" do 
        books = Work.sort_book_works

        result = books.length 
        expect(result).must_equal 10

        vote1 = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:dandelion_wine).id,
          date: "Today"
        )

        vote2 = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:catcher_in_the_rye).id,
          date: "Today"
        )

        num_of_votes = works(:dandelion_wine).votes.count 
        expect(num_of_votes).must_equal 1

        num_of_votes = works(:catcher_in_the_rye).votes.count 
        expect(num_of_votes).must_equal 1
      end
    end

    describe "sort_movie_works" do 
      it "sorts works by movies" do 
        movies = Work.sort_movie_works

        result = movies.length 
        expect(result).must_equal 10

        vote1 = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:titanic).id,
          date: "Today"
        )

        vote2 = Vote.create(
          user_id: users(:user_one).id, 
          work_id: works(:titanic).id,
          date: "Today"
        )

        num_of_votes = works(:titanic).votes.count 
        expect(num_of_votes).must_equal 2
      end
    end

    describe "top_albums" do 
      it "returns 10 albums" do 
        albums = Work.top_albums

        result = albums.length
        expect(result).must_equal 10

        vote = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:album_ten).id,
          date: "Today"
        )

        num_of_votes = works(:album_ten).votes.count 
        expect(num_of_votes).must_equal 1

        albums = Work.top_albums
        expect(albums[0].title).must_equal works(:album_ten).title
      end

      it "returns empty array if there are no albums" do 
        albums = Work.sort_album_works
        albums.each do |a|
          a.category = "book"
          a.save
        end

        result = Work.top_albums
        expect(result).must_equal []
      end

      it "returns 5 albums if there are only 5 of them" do 
        albums = Work.sort_album_works
        albums.each_with_index do |album, index|
          album.category = "book"
          album.save
          break if index == 4
        end

        result = Work.top_albums.count
        puts "RESULT = #{result}"
        expect(result).must_equal 5
      end
    end

    describe "top_books" do 
      it "returns 10 books" do 
        books = Work.top_books

        result = books.length
        expect(result).must_equal 10

        vote = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:dandelion_wine).id,
          date: "Today"
        )

        num_of_votes = works(:dandelion_wine).votes.count 
        expect(num_of_votes).must_equal 1

        works = Work.top_books
        expect(works[0].title).must_equal works(:dandelion_wine).title
      end

      it "returns empty array if there are no books" do 
        books = Work.sort_book_works
        books.each do |b|
          b.category = "movie"
          b.save
        end

        result = Work.top_books
        expect(result).must_equal []
      end

      it "returns 5 books if there are only 5 of them" do 
        books = Work.sort_book_works
        books.each_with_index do |book, index|
          book.category = "movie"
          book.save
          break if index == 4
        end

        result = Work.top_books.count
        puts "RESULT = #{result}"
        expect(result).must_equal 5
      end  
    end

    describe "top_movies" do
      it "returns 10 movies" do 
        movies = Work.top_movies

        result = movies.length
        expect(result).must_equal 10

        vote = Vote.create(
          user_id: users(:user_two).id, 
          work_id: works(:titanic).id,
          date: "Today"
        )

        num_of_votes = works(:titanic).votes.count 
        expect(num_of_votes).must_equal 1

        works = Work.top_movies
        expect(works[0].title).must_equal works(:titanic).title
      end

      it "returns empty array if there are no movies" do 
        movies = Work.sort_movie_works
        movies.each do |m|
          m.category = "book"
          m.save
        end

        result = Work.top_movies
        expect(result).must_equal []
      end

      it "returns 5 movies if there are only 5 of them" do 
        movies = Work.sort_movie_works
        movies.each_with_index do |movie, index|
          movie.category = "book"
          movie.save
          break if index == 4
        end

        result = Work.top_movies.count
        puts "RESULT = #{result}"
        expect(result).must_equal 5
      end  
    end

    describe "get_spotlight" do 
    end
  end
end
