class TodosController < ApplicationController

  before_action :authorize_access_request!
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = current_user.todos
    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params.merge!({ownerable: current_user}))
    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private

  def set_todo
    @todo = Todo.by_owner_params(owner_params).find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :status, :ownerable_type, :ownerable_id)
  end

  def owner_params
    params.permit(:ownerable_id, :ownerable_type)
  end
end