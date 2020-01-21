require 'rails_helper'

if RUBY_VERSION>='2.6.0'
    if Rails.version < '5'
      class ActionController::TestResponse < ActionDispatch::TestResponse
        def recycle!
          # hack to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    else
      puts "Monkeypatch for ActionController::TestResponse no longer needed"
    end
  end
  
RSpec.describe TodosController do
    login_user
  
    it "should have a current_user" do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end
  
    it "should get index" do
      # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
      # the valid_session overrides the devise login. Remove the valid_session from your specs
      get 'index'
      response.should be_success
    end
    describe "GET #show" do
      it "assigns the requested todo to @todo" do
        todo = create(:todo)
        get :show, id: todo
        assigns(:todo).should eq(todo)
      end
      
      it "renders the #show view" do
        get :show, id: create(:todo)
        response.should render_template :show
      end
    end
  
    describe "POST create" do
      context "with valid attributes" do
        it "creates a new todo" do
          expect{
            post :create, todo: FactoryBot.attributes_for(:todo)
          }.to change{Todo.count}.by(1)
        end
        
      end
      context "with invalid attributes" do
        it "does not save the new todo" do
          expect{
            post :create, todo: FactoryBot.attributes_for(:invalid_todo)
          }.to_not change{Todo.count}
        end
        
      
      
    end
  end
    describe 'PUT update' do
      before :each do
        @todo = create(:todo, content: "Lawrence")
      end
      
      context "valid attributes" do
        it "located the requested @todo" do
          put :update, id: @todo, todo: FactoryBot.attributes_for(:todo)
          assigns(:todo).should eq(@todo)      
        end
      
        it "changes @todo's attributes" do
          put :update, id: @todo, 
            todo: FactoryBot.attributes_for(:todo, content: "Larry")
          @todo.reload
          @todo.content.should eq("Larry")
        end
      
        it "redirects to the updated todo" do
          put :update, id: @todo, todo: FactoryBot.attributes_for(:todo)
          response.should redirect_to @todo
        end
      end
      context "invalid attributes" do
        it "locates the requested @todo" do
          put :update, id: @todo, todo: FactoryBot.attributes_for(:invalid_todo)
          assigns(:todo).should eq(@todo)      
        end
        
       
        
        it "re-renders the edit method" do
          put :update, id: @todo, todo: FactoryBot.attributes_for(:invalid_todo)
          response.should render_template :edit
        end
      end
      
      
    end
    describe 'DELETE destroy' do
      before :each do
        @todo = FactoryBot.create(:todo)
      end
      
      it "deletes the todo" do
        expect { delete :destroy, id: @todo }.to change { Todo.count }.by(-1)
      end
        
      it "redirects to todos#index" do
        delete :destroy, id: @todo
        response.should redirect_to todos_url
      end
    end

  end