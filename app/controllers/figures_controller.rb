class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])

    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title|
        title = Title.find_by_id(title.to_i)
        figure.titles << title
      end
    else
      figure.titles = []
    end

    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark_id|
        landmark = Landmark.find_by_id(landmark_id.to_i)
        figure.landmarks << landmark
      end
    else
      figure.landmarks = []
    end

    if params[:title][:name] != ""
      figure.titles.create(name: params[:title][:name])
    end

    if params[:landmark][:name] != ""
      figure.landmarks.create(params[:landmark])
    end

    redirect "/figures/#{ figure.id }"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find_by_id(params[:id])
    figure.update(params[:figure])

    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title_id|
        title = Title.find_by_id(title_id.to_i)
        figure.titles << title
      end
    else
      figure.titles = []
    end

    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark_id|
        landmark = Landmark.find_by_id(landmark_id.to_i)
        figure.landmarks << landmark
      end
    else
      figure.landmarks = []
    end

    if params[:title][:name] != ""
      figure.titles.create(name: params[:title][:name])
    end

    if params[:landmark][:name] != ""
      figure.landmarks.create(params[:landmark])
    end

    redirect "/figures/#{ figure.id }"
  end

  delete '/figures/:id' do

  end
end
