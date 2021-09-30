# it would be nice if we could do this:
inception = Movie.find_by_title('Inception')
alice,bob = Moviegoer.find(alice_id, bob_id)
# alice likes Inception, bob hates it
alice_review = Review.new(:potatoes => 5)
bob_review   = Review.new(:potatoes => 2)
# a movie has many reviews:
inception.reviews = [alice_review, bob_review]
inception.save!
# a moviegoer has many reviews:
alice.reviews << alice_review
bob.reviews << bob_review
# can we find out who wrote each review?
inception.reviews.map { |r| r.moviegoer.name } # => ['alice','bob']