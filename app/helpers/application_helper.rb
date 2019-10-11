module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Turtle"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def number_of_participants
    [
      [2],
      [4],
      [6],
      [8],
      [10],
      [12],
      [14],
      [16],
      [18],
      [20]
    ]
  end

  def number_of_weeks
    [
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [10]
    ]
  end

  def number_of_matches
    [
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
      [10]
    ]
  end

end
