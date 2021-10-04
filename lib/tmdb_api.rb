require 'net/http'
require 'json'

# TMDB API KEY
$tmdb_api_key = YOUR_TMDB_API_KEY

# TMDB API GET
def getDataFromApi(uri)
    return JSON.parse(Net::HTTP.get(uri))
end

# LOCAL SERVER POST 
def postDataToServer(uri, body)
    body['api-call'] = 'true'
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
    request.body = body.to_json
    return Net::HTTP.new(uri.host, uri.port).request(request)
end

def generateCrawlList()

    crawl_list = []

    if (ARGV[0] == '-rating' || ARGV[0] == '-popular') && ARGV.length == 2

        if ARGV[0] == '-rating'
            option = 'top_rated'
        elsif ARGV[0] == '-popular'
            option = 'popular'
        end

        number_of_movie = ARGV[1].to_i()

        number_of_page = number_of_movie / 20

        number_of_offset = number_of_movie % 20

        for i in 1..number_of_page
            
            # TMDB API GET GET movie/option
            tmdb_api_uri_option = URI("https://api.themoviedb.org/3/movie/#{option}?api_key=#{$tmdb_api_key}&language=en-US&page=#{i}")
            movies_option = getDataFromApi(tmdb_api_uri_option)

            for j in 0..19
                crawl_list.push(movies_option['results'][j]['id'])
            end
        end

        # TMDB API GET GET movie/option URI
        tmdb_api_uri_option = URI("https://api.themoviedb.org/3/movie/#{option}?api_key=#{$tmdb_api_key}&language=en-US&page=#{number_of_page+1}")
        movies_option = getDataFromApi(tmdb_api_uri_option)

        for i in 0..(number_of_offset-1)
            crawl_list.push(movies_option['results'][i]['id'])
        end

    else
        crawl_list = ARGV
    end

    return crawl_list
end

movie_id_list = generateCrawlList()

movie_id_list.each do|movie_id|

    # TMDB API GET Requst에 사용될 URI 미리 선언
    tmdb_api_uri_movie = URI("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{$tmdb_api_key}")
    tmdb_api_uri_movie_credit = URI("https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{$tmdb_api_key}")

    # LOCAL SERVER POST Requst에 사용될 URI 미리 선언
    local_server_uri_movie = URI("http://localhost:3000/movies")

    # TMDB API Movie data get 
    movie = getDataFromApi(tmdb_api_uri_movie)

    # status_code 34
    if movie['status_code'] == 34
        puts "[ERROR   ] The MOVIE##{movie_id} could not be found."
    else
        # Data Movie
        movie = {
            'movie_id'=>movie_id,
            'title'=>movie['title'],
            'rating'=>movie['vote_average'],
            'overview'=>movie['overview'],
            'poster_path'=>movie['poster_path']
        }

        # LOCAL SERVER Movie data post
        response = postDataToServer(local_server_uri_movie, movie)    
        if response.code == '200'
            puts JSON.parse(response.body)["message"]
        else
            puts "[ERROR   ] The MOVIE##{movie_id} is aleady created value."
        end
    end
end