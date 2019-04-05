require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "renders the new users page" do
            get :new

            expect(response).to render_template("new")
            expect(response).to have_http_status(200)
        end
    end
    
    describe "POST #create" do
        context "with valid params" do
            before(:each) {post :create, params: {user: {username: 'brian2', password: 'password2'} }}
            
            it "should add new user to database" do
                expect(User.last.username).to eq("brian2")
            end
            
            it "should redirect to the new user's show page" do
                expect(response).to redirect_to(user_url(User.last))
            end

            it "should log in the new user" do
                expect(session[:session_token]).to eq(User.last.session_token)
            end
        end

        context "with invalid params" do
            it "should validate the presence of username, password" do
                post :create, params: {user: {username: 'bogus', password: 'bog'} }
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end
        end
    end
    
    describe "GET #show" do
        subject(:user) {User.create(username: "brian3", password: "password")}
        it "renders the user's show page" do
            get :show, params:{id: user.id}

            expect(response).to render_template("show")
            expect(response).to have_http_status(200)
        end

        it "displays an error if invalid user id" do
            get :show, params:{id: 0}
            expect(flash[:errors]).to be_present
        end
    end

    describe "GET #index" do
        it "renders a users index page" do
            get :index

            expect(response).to render_template("index")
            expect(response).to have_http_status(200)
        end
    end
end
