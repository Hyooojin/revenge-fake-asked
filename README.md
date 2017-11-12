# Rails를 이용해 asked 홈페이지 만들어보기 Revenge!!!

Table of contents
==============
* [Ruby](https://github.com/Hyooojin/sinatra/tree/master/sinatra_1)
* [Rails](#rails)
* [MVC Architecture](#mvc-architecture )
  * [models](#models)
  * [Views](#views)
  * [Controllers](#controllers)
* [Revenge Create a web site](#revenge-create-a-web-site)
  * [Settings](#settings)
    * [Gemfile Settings](#gemfile-settings)
    * [Controller Settings](#controller-settings)
    * [Model Settings](#modle-settings)
* [Fake Asked Homepage](#fake-asked-homepage)
  * [Basic Web Site](#basic-web-site)
    * [Basic Routing](#basic-routing)
    * [Basic Methods](#basic-methods)
    * [Basic Views](#basic-views)
  * [Use DataBase](#use-database)
     * [DB Models](#db-models)
     * [DB Routing](#db-routing)
     * [DB Methods](#db-methods)
     * [DB Views](#db-views)
  * [Sign Up](#sign-up)
    * [Sign Up Models](#sign-up-modles)
    * [Sign Up Routing](#sign-up-routing)
    * [Sign Up Methods](#sign-up-methods)
    * [Sign Up Views](#sign-up-views)
  * [Login](#login)
    * [Login Routing](#login-routing)
    * [Login Methods](#login-methods)
    * [Login Views](#login-views)

Rails
=======
레일즈는 루비 언어로 작성된 웹 어플리케이션 프레임워크이다.  <br/>
레일즈는 모든 개발자가 개발을 시작 할 때 필요한 초기 준비나 가정들을 쉽게 만들 수 있는 도구를 제공하여, 웹 어플리케이션 프로그래밍을 더 쉽게 만들 수 있도록 설계되어 있다. <br/>
[레일즈 시작하기 참고사이트](https://rubykr.github.io/rails_guides/getting_started.html)
<br/><br/>

MVC Architecture
=================
레일즈의 중심에는 MVC 라고 불리는 모델, 뷰, 컨트롤러 아키텍처가 있다.
### Models
  : 어플리케이션의 데이터를 다루는 규칙을 의미
  * Modle은 데이터 베이스 테이블과 상호 작용하는 규칙을 관리
  * 데이터 베이스의 하나의 테이블은 어플리케이션의 하나의 모델과 대응


### Views
  : 어플리케이션 유저 인터페이스를 의미
  * View는 주로 데이터 표현에 관련된 **루비 코드가 삽입되어 있는 HTML** 파일이다.
  * 데이터를 웹 브라우저나 다른 기기에서 데이터를 제공하는 일을 담당


### Controllers
  : 모델과 뷰를 **연결**하는 역할
  * Controller는 웹브라우저의 요청을 받아서, 모델을 통해서 데이터를 조회하여, 출력을 위해 뷰에게 데이터를 넘겨준다.
    <br/><br/>

Revenge Create a web site
==============
## Settings
#### Gemfile Settings 
* Gemfile에 gem을 install하여 기본적인 환경을 set-up 한다. 
```
  gem 'rails_db'
  gem 'awesome_print'
  gem 'pry-rails'
```

*  새로운 gem을 설치한 후, 다음 명령문으로 새로운 환경을 set-up 해준다.
```
  $ bundle install
```

#### Controller Settings
* Controller 설정 
```
  $ rails g controller question index show
```
index, show가 routes.rb에 저절로 설정!<br/>
veiw에는 index.erb와 show.erb가 생성!<br/>
controller에는 index, show 메소드가 정의된다.

* config에 생성된 routes.rb를 확인
  이곳에서 **라우팅**을 한다. 
  <br/>
* 기본root를 index로 설정
```
  root 'question#index'
```
* root 이외의 라우팅
```
  get 'question/index'
  get 'question/show'
```
다른 index와 show는 이런식으로 라우팅 된다. <br/>
이후에 정의되는 method들은 수동으로 추가!
<br/><br/>

* views의 question폴더 확인<br/>
  controller를 만들 때 입력한 question으로, 폴더가 생성된 것을 볼 수 있고, index와 show veiw가 생성되어 있는 것을 확인 할 수 있다. <br/><br/>

### Model Settings
* model 설정
```
  $ rails g moder question
```
db의 migrate에 생겨난 create_questions.rb가 생성되었는지 확인 후, 칼럼 정의<br/>
* 칼럼 정의
```
  t.string :name
  t.stirng :content
```
name과 content라는 col을 정의하였다. 

```
create_table "questions", force: :cascade do |t|
	t.string   "name"
	t.string   "content"
	t.datetime "created_at", null: false
 	t.datetime "updated_at", null: false
end
```
* 다음 명령문을 입력한 해 table을 생성 후, 생성된 스키마를 schema.rb에서 확인
```
$ rake db:migrate
```
Table에는 기본적으로 제공되는 id칼럼과 name, content, created_at, updated_at 총 5칼럼이 생성되게 된다. <br/>
즉, 2개의 컬럼을 만들었지만, 5개의 컬럼을 이용할 수 있게된다.
<br/><br/>


기본적인 설치작업이 끝나면 본격적으로 Website를 구현한다. 


Fake Asked Homepage
============
## Basic Web Site
* User에게 질문을 입력받는다.
* 질문을 입력한 후, 질문자에게 질문자의 질문과 이름을 보여지게 한다.
### Basic Routing

* 라우트 설정
  기본적으로 순서는 이러하다. <br/> 
  (1) routes.rb에서 라우팅을 한다.<br/>
  (2) question_controller.rb에서 method를 정의한다. <br/>
  (3) 그 후, view파일을 만들면 web이 동작하게 된다.<br/>
  <br/>

```
  root 'question#index'
  get 'question/index'
  get 'question/show'
```
root를 설정하고, index와 show가 정의되어 있는 것을 확인<br/>

### Basic Methods
* method 정의
  method를 정의한다
```
  def index
  end

  def show
  end
```
index와 show안에 method 내용을 정의한다.<br/>
* index method
```
def index
```
user에게 입력받은 값을 보여준다. <br/>

* show method<br/>
  User에게 입력받은 값을 User가 확인할 수 있도록 한다. 
```
def show
	@name = params[:name]
	@question = params[:question]
end
```
### Basic Views
* index.erb
```
<h1>fake-asked에 오신걸 환영합니다.</h1>
<p>질문을 작성해주세요.</p>

<form action="/question/show">
    작성자:<input type="text" name="name"><br/>
    질문:<input type="text" name="content"><br/>
    <input type="submit" value="질문하기">
</form>
```
* show.erb
```
작성자<%=@name%>
질문내용<%=@question%>
```

## Use DataBase
* User에게 입력받은 질문을 Database에 저장할 수 있도록 한다.
* 입력받은 값을 첫번째 root페이지에 계속 확인할 수 있도록 한다.

### DB Models
* Question 테이블 생성
```
$ rails g model question
```
* db폴더의 migrate에서 create_questions.rb에서 컬럼을 추가
```
t.string :name
t.string :content
```
name컬럼과 content컬럼을 추가한다.
* 명령문을 입력해, table을 재생성
```
$ rake db:maigrate
```
* db폴더의 schema.rb를 확인
```
  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

### DB Routing
* 라우팅은 변화 없다.<br/>
  index, show

### DB Methods
* 질문자가 입력한 질문들을 데이터 베이스에 저장한다.
* 받아 온 값들을 각각 컬럼의 row에 저장될 수 있도록 한다.
* root page에서 입력받은 값을 확인할 수 있기 때문에 show.erb는 없앤다. <br/>
  대신 root page로 갈 수 있도록 설정<br/>
  show method
```
def
	@name = params[:name]
	@content = params[:content]
	
	Question.create(
		name: @name,
		content: @content
	)
	redirect_to'/'
end
```
* 질문자가 작성한 질문들이 계속 보여지도록 한다.<br/>
  DB에 저장된 값들을 받아올 수 있도록 한다.<br/>
  index method
```
def
	@questions = Question.all
end
```
* 테이블을 불러와서, 그 값들을 quesions 변수에 저장

#### DB Views

index.erb
```
<h1>fake-asked에 오신걸 환영합니다.</h1>
<p>질문을 작성해주세요.</p>

<form action="/question/show">
    작성자:<input type="text" name="name"><br/>
    질문:<input type="text" name="content"><br/>
    <input type="submit" value="질문하기">
</form>

<!--<%#=@quiestions%>-->
<% @questions.each do |q| %>
    <p>작성자:<%=q.name%></p>
    <p>질문내용:<%=q.content%></p>
    <hr>
<% end %>
```

## Sign Up
* User들을 위한 회원가입과 Login method 정의를 할 것이다.
* 회원가입에 필요한 모든 행동을 수행한다.
* 새로운 Table을 생성.

<br/><br/>
* Database User 정보를 저장하기 위한,   새로운 model을 설정 
  - User 테이블 생성
  - 회원정보를 받아, DB에 저장 
* 회원가입 때, 이미 있는 email인지 확인 절차가 필요

### Sign Up Models
* User 테이블 생성
### Sign Up Routing
* sign_up과 sign_up_process 추가
### Sign Up Methods
```
def sign_up
end
```
```
def sign_up_process
end
```
### Sign Up Views
sign_up.erb<br/>

sign_up_process<br/>



## Login
* session값을 사용
* 암호화 설정
* session 유저 정보를 검증을 거친 후 저장하는 것
   1. User 정보를 받는다.
   2. 받은 User 정보와 DB의 User 정보가 일치하는지 확인
   3. if 일치, session에 유저 정보를 넣는다. 
     else, 이유를 말해주고 로그인 안시킨다.
     session[:email] = 유저 정보를 넣는다.
   4. 로그아웃
     session.clear
### Login Models
* User 테이블 생성
### Login Routing
* sign_up과 sign_up_process 추가
### Login Methods

```
def login
end
```
```
def login_process
end
```

### Login Views










