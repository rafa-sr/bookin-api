class Plane < ApplicationRecord

  attr_accessor :array_row_left,  :array_row_right

  def initialize (attributes = {})
    #row x col
    #TODO single array for all sits
    @array_row_left = Array.new(3) { Array.new(26) }
    @array_row_right = Array.new(3) { Array.new(26) }
    @single_sit = nil
    @tow_sit = nil
    fill_arrays
  end

  #@todo
  def cancel_sit
    #TODO
  end
  #----------------------------------------------------------------------

  def fill_arrays
    fill_left_row
    fill_right_row
  end

  #----------------------------------------------------------------------

  def get_one_sit
    if left_windows_sits.nil?
      if right_windows_sits.nil?
        if random_sit.nil?
          #there is no sits available
          return nil
        end
      end
    end
    @single_sit
  end

  #----------------------------------------------------------------------

  def fill_left_row

    (0..2).each  do | row |
      (0..25).each do |col|
        if row == 0
          @array_row_left[row][col]= 'A' +  (col + 1 ).to_s
        elsif row == 1
          @array_row_left[row][col]= 'B' + (col + 1).to_s
        else
          @array_row_left[row][col]= 'C' + (col + 1).to_s
        end
      end
    end
  end

  #----------------------------------------------------------------------

  def fill_right_row

    (0..2).each  do | row |
      (0..25).each do |col|
        if row == 0
          @array_row_right[row][col]= 'D' +  (col + 1 ).to_s
        elsif row == 1
          @array_row_right[row][col]= 'E' +  (col + 1 ).to_s
        else
          @array_row_right[row][col]= 'F' +  (col + 1 ).to_s
        end
      end
    end
  end

  #----------------------------------------------------------------------

  def print
    puts @array_row_left
    puts @array_row_right
  end

  #----------------------------------------------------------------------

  def print_sits
    puts @single_sit
  end

  #----------------------------------------------------------------------

  def left_windows_sits

    (0..25).each do |col|
      if @array_row_left[0][col] != 0
        @single_sit  = @array_row_left[0][col]
        @array_row_left[0][col] = 0
        return @single_sit
      end
    end
    @tow_sit = nil
  end

  #----------------------------------------------------------------------

  def right_windows_sits

    (0..25).each do |col|
      if @array_row_right[2][col] != 0
        @single_sit = @array_row_right[2][col]
        @array_row_right[2][col] = 0
        return @single_sit
      end
    end
    @tow_sit = nil
  end

  #----------------------------------------------------------------------

  def random_sit

    (1..2).each do |row|
      (0..25).each do |col|

        if @array_row_left[row][col] != 0
          @single_sit = @array_row_left[row][col]
          @array_row_left[row][col] = 0
          return @single_sit
        elsif row == 2 and col == 25
          break
        end
      end
    end

    (0..1).each do |row|
      (0..25).each do |col|

        if @array_row_right[row][col] != 0
          @single_sit = @array_row_right[row][col]
          @array_row_right[row][col] = 0
          return @single_sit
        elsif row == 1 and col == 25
          return nil
        end
      end
    end
  end

  #----------------------------------------------------------------------

  def get_tow_sits
    if left_get_tow_sits.nil?
      if right_get_tow_sits.nil?
        if left_tow_sits_no_windows.nil?
          if right_tow_sits_no_windows.nil?
            if across_aisle_tow_sits.nil?
              #should call random single sit twice
            end
          end
        end
      end
    end
    @tow_sit
  end

  #----------------------------------------------------------------------

  def left_get_tow_sits

    @tow_sit = Array.new
    (0..25).each do |col|

      if (@array_row_left[0][col] != 0) and (@array_row_left[1][col] != 0)
          @tow_sit << @array_row_left[0][col]
          @tow_sit << @array_row_left[1][col]
          @array_row_left[0][col] = 0
          @array_row_left[1][col] = 0
          #TODO
          puts @tow_sit.inspect
          return @tow_sit
      end

    end
    @tow_sit = nil

  end

  #----------------------------------------------------------------------
  def right_get_tow_sits

    @tow_sit = Array.new
    (0..25).each do |col|

      if (@array_row_right[1][col] != 0) and (@array_row_right[2][col] != 0)
        @tow_sit << @array_row_right[1][col]
        @tow_sit << @array_row_right[2][col]
        @array_row_right[1][col] = 0
        @array_row_right[2][col] = 0
        #TODO
        #puts @tow_sit.inspect
        return @tow_sit
      end

    end
    @tow_sit = nil

  end

  #----------------------------------------------------------------------

  def left_tow_sits_no_windows

    @tow_sit = Array.new
    (0..25).each do |col|
      if (@array_row_left[1][col] != 0) and (@array_row_left[2][col] != 0)
        @tow_sit << @array_row_left[1][col]
        @tow_sit << @array_row_left[2][col]
        @array_row_left[1][col] = 0
        @array_row_left[2][col] = 0
        return @tow_sit
      end

    end
    @tow_sit = nil

  end

  #----------------------------------------------------------------------

  def right_tow_sits_no_windows
    @tow_sit = Array.new
    (0..25).each do |col|
      if (@array_row_right[0][col] != 0) and (@array_row_right[1][col] != 0)
        @tow_sit << @array_row_right[0][col]
        @tow_sit << @array_row_right[1][col]
        @array_row_right[0][col] = 0
        @array_row_right[1][col] = 0
        return @tow_sit
      end

    end
    @tow_sit = nil
  end

  #----------------------------------------------------------------------

  def across_aisle_tow_sits
    @tow_sit = Array.new
    (0..25).each do |col|
      if (@array_row_left[2][col] != 0) and (@array_row_right[0][col] != 0)
        @tow_sit << @array_row_left[2][col]
        @tow_sit << @array_row_right[0][col]
        @array_row_right[0][col] = 0
        @array_row_left[2][col] = 0
        return @tow_sit
      end
    end
    @tow_sit = nil
  end

  #----------------------------------------------------------------------
  def random_sit_left
    #todo
  end

  #----------------------------------------------------------------------


  def random_sit_right
     #todo
  end

  #----------------------------------------------------------------------

end