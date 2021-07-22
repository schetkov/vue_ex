require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:user) { create(:user) }

  let(:owner_attributes) {
    { ownerable_id: user.id, ownerable_type: user.class.name }
  }

  let(:valid_attributes) {
    { title: 'new title', status: 'Created', ownerable_id: user.id, ownerable_type: user.class.name }
  }

  let(:invalid_attributes) {
    { title: nil, status: nil}
  }

  let!(:todo) { create(:todo, ownerable_id: user.id, ownerable_type: user.class.name) }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @token = session.login
  end

  describe 'GET #index' do
    #let!(:todo) { create(:todo, ownerable_id: user.id, ownerable_type: user.class.name) }

    it 'returns a success response' do
      cookies[JWTSessions.access_cookie] = @token[:access]
      get todos_path, params: owner_attributes
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq todo.id
    end

    # usually there's no need to test this kind of stuff 
    # within the resources endpoints
    # the quick spec is here only for the presentation purposes
    it 'unauth without cookie' do
      get todos_path
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET #show' do
    #let!(:todo) { create(:todo, ownerable_id: user.id, ownerable_type: user.class.name) }

    it 'returns a success response' do
      cookies[JWTSessions.access_cookie] = @token[:access]
      get todo_path(id: todo.id)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new Todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        expect {
          post todos_path, params: { todo: valid_attributes }, headers: { JWTSessions.csrf_header => @token[:csrf] }
        }.to change(Todo, :count).by(1)
      end

      it 'renders a JSON response with the new todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        post todos_path, params: { todo: valid_attributes }, headers: { JWTSessions.csrf_header => @token[:csrf] }
        response
        expect(response).to have_http_status(:created)
        # sends charset along which is strange
        expect(response.content_type).to include('application/json')
        # could not cast downcase on Hash, checks with x.downcase == which is screwed
        # expect(response.headers).to include(
        #   "Content-Type" => "application/json; charset=utf-8"
        # )
        expect(response.location).to eq(todo_url(Todo.last))
      end
    end


    context 'with invalid params' do
      it 'renders a JSON response with errors for the new todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        post todos_path, params: { todo: invalid_attributes }, headers: { JWTSessions.csrf_header => @token[:csrf]}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'PUT #update' do
    #let!(:todo) { create(:todo, ownerable_id: user.id, ownerable_type: user.class.name) }

    context 'with valid params' do
      let(:new_attributes) {
        { title: 'Super secret title' }
      }

      it 'updates the requested todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        put todo_path(todo.id), params: {todo: new_attributes }, headers: { JWTSessions.csrf_header => @token[:csrf] }
        todo.reload
        expect(todo.title).to eq new_attributes[:title]
      end

      it 'renders a JSON response with the todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        put todo_path(todo.id), params: { todo: valid_attributes }, headers: {  JWTSessions.csrf_header => @token[:csrf] }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the todo' do
        cookies[JWTSessions.access_cookie] = @token[:access]
        #request.headers[JWTSessions.csrf_header] = @token[:csrf]
        put todo_path(todo.id), params: { todo: invalid_attributes }, headers: {  JWTSessions.csrf_header => @token[:csrf] }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    #let!(:todo) { create(:todo, ownerable_id: user.id, ownerable_type: user.class.name) }

    it 'destroys the requested todo' do
      cookies[JWTSessions.access_cookie] = @token[:access]
      #request.headers[JWTSessions.csrf_header] = @token[:csrf]
      expect {
        delete todo_path(todo.id), headers: {  JWTSessions.csrf_header => @token[:csrf] }
      }.to change(Todo, :count).by(-1)
    end
  end
end