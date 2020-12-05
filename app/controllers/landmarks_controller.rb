class LandmarksController < ApplicationController
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    @titles = Title.all
    @figures = Figure.all

    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    if params[:landmark][:figure_id] != nil
      landmark.figure_id = params[:landmark][:figure_id].to_i
      landmark.save
    end

    if params[:figure][:name] != ""
      figure = Figure.create(name: params[:figure][:name])
      landmark.figure_id = figure.id
      landmark.save
    end

    redirect "/landmarks/#{ landmark.id }"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    @figures = Figure.all
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find_by_id(params[:id])
    landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    if params[:landmark][:figure_id] != nil
      landmark.figure_id = params[:landmark][:figure_id].to_i
      landmark.save
    end

    if params[:figure][:name] != ""
      figure = Figure.create(name: params[:figure][:name])
      landmark.figure_id = figure.id
      landmark.save
    end

    redirect "/landmarks/#{ landmark.id }"
  end

  delete '/landmarks/:id' do

  end
end
