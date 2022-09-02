class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home

  end


  def dashboard
    @user = current_user
    #On met une base à 0
    @base = {
      vineux: 0,
      epicee: 0,
      boise: 0,
      animale: 0,
      fruite: 0,
      floral: 0,
      herbace: 0,
      cereale: 0,
      empyreumatique: 0,
      tourbe: 0
    }
    # Recupérer les champs que le USER a rempli sur le form precedent
    @user.experiences.each do |el|


      @base.map do |key, value|
        @base[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
      end
    end
    profile = @base
    AlcoolProfile.create(user: @user) if @user.alcool_profile.nil?
    profile.each { |k, v| @user.alcool_profile[:"#{k}"] = v }  unless profile.reject { |k, v| v == @user.alcool_profile[:"#{k}"]}.empty?

    @familie_order = []
    profile.sort_by { |_, v| -v }.each { |k, _| @familie_order << k }

    @popo = []
    @papa = []
    @base.each do |k, v|
      @popo << k
      @papa << v
    end
    @value = @popo.join("-")
    @data = @papa.join("-")

    @result = {}
    Spirit.all.each do |spirit|
      difference = 0
      @base.each do |key, value|
        diff = ((value - spirit[:"#{key}"]) * 4)
        diff = diff * (-1) if diff < 0
        difference += diff
      end
      @result[:"#{spirit.id}"] = difference
    end

    @user.recommendations.each { |el| el.destroy }
    unless @user.experiences.empty?
      @forbidden = []
      @user.orders.each { |el| @forbidden << el.spirit.id } unless @user.orders.empty?
      @user.experiences.each { |el| @forbidden << el.spirit.id } unless @user.experiences.empty?
      @result.reject{ |k, v| @forbidden.include?(k) }.sort_by { |_, v| v }.first(5).map(&:first).each do |k, v|
        Recommendation.create(spirit: Spirit.find("#{k}"), user: @user, percentages: (100 - @result[k].round(2)))
      end
    end
  end

  def maindashboard

    @user = current_user
    @test = {
      vineux: 0,
      epicee: 0,
      boise: 0,
      animale: 0,
      fruite: 0,
      floral: 0,
      herbace: 0,
      cereale: 0,
      empyreumatique: 0,
      tourbe: 0
    }

    #Pour le dashboard general
    @base = @test
    @user.experiences.each do |el|
      @base.map do |key, value|
        @base[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
      end
    end
    @user.alcool_profile.nil? ? @affichage = "d-none" || @demande = "" : @affichage = "" || @demande = "d-none"
    @popo = []
    @papa = []
    @base.each do |k, v|
      @popo << k
      @papa << v
    end

    @valued = @popo.join("-")
    @datad = @papa.join("-")

    #Pour le dashboard whisky
    @affichagew = "d-none"
    @demandew = ""
    @whisky = {}
    @test.map { |k, _| @whisky[:"#{k}"] = 0 }

    @user.experiences.each do |el|
      @whisky.map do |key, value|
        if el.spirit.category == "Whisky"
          @whisky[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichagew = ""
          @demandew = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @whisky.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuew = @popo.join("-")
    @dataw = @papa.join("-")

    #Pour le dashboard gin
    @affichageg = "d-none"
    @demandeg = ""
    @gin = {}
    @test.map { |k, _| @gin[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @gin.map do |key, value|
        if el.spirit.category == "Gin"
          @gin[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichageg = ""
          @demandeg = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @gin.each do |k, v|
      @popo << k
      @papa << v
    end
    @valueg = @popo.join("-")
    @datag = @papa.join("-")


    #Pour le dashboard rhum
    @affichager = "d-none"
    @demander = ""
    @rhum = {}
    @test.map { |k, _| @rhum[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @rhum.map do |key, value|
        if el.spirit.category == "Rhum"
          @rhum[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichager = ""
          @demander = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @rhum.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuer = @popo.join("-")
    @datar = @papa.join("-")

    #Pour le dashboard tequila

    @affichaget = "d-none"
    @demandet = ""
    @tequila = {}
    @test.map { |k, _| @tequila[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @tequila.map do |key, value|
        if el.spirit.category == "Tequila"
          @tequila[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichaget = ""
          @demandet = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @tequila.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuet = @popo.join("-")
    @datat = @papa.join("-")

    #Pour le dashboard cognac

    @affichagec = "d-none"
    @demandec = ""
    @cognac = {}
    @test.map { |k, _| @cognac[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @cognac.map do |key, value|
        if el.spirit.category == "Cognac"
          @cognac[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichagec = ""
          @demandec = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @cognac.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuec = @popo.join("-")
    @datac = @papa.join("-")


    #Pour le dashboard calvados
    @affichageca = "d-none"
    @demandeca = ""
    @calvados = {}
    @test.map { |k, _| @calvados[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @calvados.map do |key, value|
        if el.spirit.category == "Calvados"
          @calvados[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichageca = ""
          @demandeca = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @calvados.each do |k, v|
      @popo << k
      @papa << v
    end
    @valueca = @popo.join("-")
    @dataca = @papa.join("-")



    #Pour le dashboard mezcal
    @affichagem = "d-none"
    @demandem = ""
    @mezcal = {}
    @test.map { |k, _| @mezcal[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @mezcal.map do |key, value|
        if el.spirit.category == "Mezcal"
          @mezcal[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichagem = ""
          @demandem = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @mezcal.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuem = @popo.join("-")
    @datam = @papa.join("-")



    #Pour le dashboard vodka
    @affichagev = "d-none"
    @demandev = ""
    @vodka = {}
    @test.map { |k, _| @vodka[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @vodka.map do |key, value|
        if el.spirit.category == "Vodka"
          @vodka[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichagev = ""
          @demandev = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @vodka.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuev = @popo.join("-")
    @datav = @papa.join("-")

    #Pour le dashboard armagnac
    @affichagea = "d-none"
    @demandea = ""
    @armagnac = {}
    @test.map { |k, _| @armagnac[:"#{k}"] = 0 }
    @user.experiences.each do |el|
      @armagnac.map do |key, value|
        if el.spirit.category == "Armagnac"
          @armagnac[key] += ((el.spirit[:"#{key}"]).fdiv(@user.experiences.size))
          @affichagea = ""
          @demandea = "d-none"
        end
      end
    end
    @popo = []
    @papa = []
    @armagnac.each do |k, v|
      @popo << k
      @papa << v
    end
    @valuea = @popo.join("-")
    @dataa = @papa.join("-")



  end
end
