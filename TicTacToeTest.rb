require 'selenium-webdriver'
require 'webdrivers'

class TicTacToeTest

  # Launches Browser
  # @param browser [String] browser name
  def launch_browser(browser)

    case browser
      when 'chrome'
        @driver = Selenium::WebDriver.for :chrome
      when 'firefox'
        @driver = Selenium::WebDriver.for :firefox
      when 'edge'
        @driver = Selenium::WebDriver.for :edge
      else
        raise ArgumentError, "Unsupported browser: #{browser}"
    end
  end

  # Navigates to given website
  # @param url [String] website url
  def visit_website(url)
    @driver.navigate.to(url)
    sleep(5)
  end

  # Enters the number in text box to build size of game board
  # @param number [Integer] number of rows/columns
  def enter_number(number)
    @driver.find_element(id: 'number').send_keys(number)
    sleep(1)
  end

  # Clicks the Play button
  def start_game
    @driver.find_element(id: 'start').click
    sleep(5)
  end

  # Verifies the game board is visible by finding the last row on the table
  # @param row_number [Integer] row number
  def verify_game_board_present(row_number)
    begin
      @driver.find_element(:xpath, "/html/body/table/tr[#{row_number}]")
      puts 'Game board is found. Test Passed!'
    rescue Selenium::WebDriver::Error::NoSuchElementError
      fail('Game board is not present. Test failed.')
    end
  end

  # Clicks squares on game board by row and column
  # @param row [Integer] row number
  # @param column [Integer] column number
  def click_square(row, column)
    xpath = "/html/body/table/tr[#{row}]/td[#{column}]"
    @driver.find_element(:xpath, xpath).click
    sleep(1)
  end

  # Click various squares to win a game
  def win_a_game
    click_square(1, 1)
    click_square(3, 1)
    click_square(2, 2)
    click_square(3, 2)
    click_square(3, 3)
  end

  # Verifies the winner prompt appears - NOTE: A known bug with winner prompt not showing correct winner
  def verify_winner_prompt
    begin
    @driver.find_element(:xpath, "//*[@id='endgame' and contains(text(), 'Congratulations player')]")
      puts 'Winner, Winner. Test Passed!'
    rescue Selenium::WebDriver::Error::NoSuchElementError
      fail('Winner Prompt not found. Test failed.')
    end
  end

  # Quits selenium-webdriver
  def quit_driver
    @driver.quit
  end
end

#---------------------------------------------------------------------------------------------------------


# Test 1: Verify Game board displays
test_1 = TicTacToeTest.new
test_1.launch_browser('chrome')
test_1.visit_website('https://roomy-fire-houseboat.glitch.me/')
test_1.enter_number(3)
test_1.start_game
test_1.verify_game_board_present(3)
test_1.quit_driver

# Test 2: Win a game
test_2 = TicTacToeTest.new
test_2.launch_browser('chrome')
test_2.visit_website('https://roomy-fire-houseboat.glitch.me/')
test_2.enter_number(3)
test_2.start_game
test_2.win_a_game
test_2.verify_winner_prompt
test_2.quit_driver

# Test 3: Verify 5x5 game board displays
test_3 = TicTacToeTest.new
test_3.launch_browser('chrome')
test_3.visit_website('https://roomy-fire-houseboat.glitch.me/')
test_3.enter_number(5)
test_3.start_game
test_3.verify_game_board_present(5)
test_3.quit_driver

# Test 4: Verify game board displays on Microsoft Edge
test_4 = TicTacToeTest.new
test_4.launch_browser('edge')
test_4.visit_website('https://roomy-fire-houseboat.glitch.me/')
test_4.enter_number(3)
test_4.start_game
test_4.verify_game_board_present(3)
test_4.quit_driver