#only example data for brevity
string_example = "Game 1: 1 blue; 4 green, 5 blue; 11 red, 3 blue, 11 green; 1 red, 10 green, 4 blue; 17 red, 12 green, 7 blue; 3 blue, 19 green, 15 red\nGame 2: 17 red, 10 green; 3 blue, 17 red, 7 green; 10 green, 1 blue, 10 red; 7 green, 15 red, 1 blue; 7 green, 8 blue, 16 red; 18 red, 5 green, 3 blue"

CUBES_IN_BAG = { red: 12, green: 13, blue: 14 }

module GameParser
    def self.parse_game_string (input_string)
        input_string.split("\n").each_with_object({}) do |game, hash|
          game_arr = game.split(':')
          hash[game_number(game_arr[0])] = all_draws(game_arr[1])
        end
    end

    private

    def self.one_draw (draw_string)
        cube_groups = draw_string.split(',')
        cube_groups.each_with_object({}) do |cube_group, hash|
          cube = cube_group.split(' ')
          hash[cube[1].to_sym] = cube[0].to_i
        end
    end
      
    def self.all_draws (all_draws_string)
        all_draws_string.split(';').map { |draw| one_draw(draw) }
    end
      
    def self.game_number (game_string)
        game_string.split(' ')[1].to_i
    end
end


def draw_higher_than_bag? (draw)
  draw.each do |key, value|
    return true if value > CUBES_IN_BAG[key]
  end
  return false
end

def impossible_game? (game)
  game.each { |draw| return true if draw_higher_than_bag?(draw) }
  return false
end

def sum_possible_games (games)
  games.reduce(0) do |total, (key, game)|
    impossible_game?(game) ? total : total + key
  end
end

def minimum_cubes (game)
  game.reduce({}) do |hash, draw|
    draw.each do |color, number|
      hash[color] = number if hash[color].nil? || number > hash[color]
    end
    hash
  end
end

def power_of_minimum_cubes(minimums)
  minimums.values.reduce(1) { |total, number| total*number }
end

def sum_of_all_powers (games)
  games.reduce(0) do |total, (game_number, game)|
    total += power_of_minimum_cubes(minimum_cubes(game))
  end
end

games = GameParser.parse_game_string(string_example)

puts sum_possible_games(games)
puts sum_of_all_powers(games)