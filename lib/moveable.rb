module Moveable
  def vertical(steps = 7)
    {
      up: (1..steps).map { |i| [-i, 0] },
      down: (1..steps).map { |i| [i, 0] }
    }
  end

  def horizontal(steps = 7)
    {
      left: (1..steps).map { |i| [0, -i] },
      right: (1..steps).map { |i| [0, i] }
    }
  end

  def diagonal(steps = 7)
    {
      upper_left: (1..steps).map { |i| [-i, -i] },
      upper_right: (1..steps).map { |i| [-i, i] },
      lower_left: (1..steps).map { |i| [i, -i] },
      lower_right: (1..steps).map { |i| [i, i] }
    }
  end

  def jump
    { around: [
      [-2, -1], [-2, 1], [2, -1], [2, 1],
      [-1, -2], [1, -2], [-1, 2], [1, 2]
    ] }
  end
end
