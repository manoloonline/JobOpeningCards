class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search]
  def index
    @jobopenings=Jobopening.all
    @search_options=[]
    categories=Category.all
    for category in categories
      @search_options << [category.tittle,category.id]
    end
  end

  def show
    id=params[:id]
    @jobopening=Jobopening.find id   
  end

  def dashboard
    
  end
  
  def add 
    @grouped_options = []
    categories = Category.all 
    professions = Profession.all
     for category in categories
        auxCategory = [category.tittle]
       @grouped_options << auxCategory
         auxOptions = []
         auxCategory << auxOptions
        for profession in professions
          if category.id == profession.category.id
            auxOptions << [profession.tittle, profession.id]
          end
        end
     end
  end
  
  def create
    
  end

  def search
    jobopenings=Jobopening.all
    @jobopenings=[]
    @search_options=[]
    categories=Category.all
    for category in categories
      @search_options << [category.tittle,category.id]
    end
    text=params[:search_value]
    category=params[:search_category]
    for jobopening in jobopenings
        if jobopening.tittle.downcase.include? text.downcase
          if jobopening.profession.category.id==category.to_i
            @jobopenings << jobopening
          end
        end
    end
    render :index
  end
  
  def edit
    @grouped_options = []
    categories = Category.all 
    professions = Profession.all
     for category in categories
        auxCategory = [category.tittle]
       @grouped_options << auxCategory
         auxOptions = []
         auxCategory << auxOptions
        for profession in professions
          if category.id == profession.category.id
            auxOptions << [profession.tittle, profession.id]
          end
        end
     end
    #id=params[:id]
    id=2
    @jobopening=Jobopening.find id   
  end
  
  def update_jobopening
    id=params[:id]
    jobopening=Jobopening.find id.to_i 
    jobopening.tittle=params[:tittle]
    jobopening.description=params[:description]
    #jobopening.image=params[:image]
    jobopening.requirement=params[:requirement]
    jobopening.salary_min=params[:salary_min]
    jobopening.salary_max=params[:salary_max]
    #jobopening.province=params[:province]
    jobopening.profession=Profession.find params[:profession].to_i
    jobopening.save
    render :dashboard
  end
  
end
