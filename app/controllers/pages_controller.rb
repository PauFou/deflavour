class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home






  end

  def my_profile
    
    test = {
      vineux: 0,
      epicee: 0,
      boise: 0,
      animale: 0,
      noix: 0,
      sucre: 0,
      fruite: 0,
      floral: 0,
      herbace: 0,
      cereale: 0,
      empyreumatique: 0,
      tourbe: 0
    }

    p User.last

    Spirit.all.each { |el | Experience.create(user: User.last, spirit: el)}
    User.last.experiences.size
    User.last.experiences.each do |el|

      test.map do |key, value|
        test[key] += ((el.spirit[:"#{key}"]).fdiv(User.last.experiences.size))
        p el.spirit[:"#{key}"]
      end
      p test
    end
  end
end
