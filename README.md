# Rails를 이용해 asked 홈페이지 만들어보기 Revenge!!!

Table of contents
==============
* [Rails](#rails)
* [MVC Architecture](#mvc-architecture )
	* [models](#models)
	* [Views](#views)
	* [Controllers](#controllers)
* [Revenge Create a web site](#revenge-create-a-web-site)
	* [Preferences](#preferences)
		* [Gemfile Settings](#gemfile-settings)
		* [Controller Settings](#controller-settings)

Rails
=======
레일즈는 루비 언어로 작성된 웹 어플리케이션 프레임워크이다.  <br/>
레일즈는 모든 개발자가 개발을 시작 할 때 필요한 초기 준비나 가정들을 쉽게 만들 수 있는 도구를 제공하여, 웹 어플리케이션 프로그래밍을 더 쉽게 만들 수 있도록 설계되어 있다. <br/>
[레일즈 시작하기 참고사이트](https://rubykr.github.io/rails_guides/getting_started.html)
<br/><br/>

MVC Architecture
=================
레일즈의 중심에는 MVC 라고 불리는 모델, 뷰, 컨트롤러 아키텍처가 있다.
###Models
  : 어플리케이션의 데이터를 다루는 규칙을 의미
  * Modle은 데이터 베이스 테이블과 상호 작용하는 규칙을 관리
  * 데이터 베이스의 하나의 테이블은 어플리케이션의 하나의 모델과 대응


###Views
  : 어플리케이션 유저 인터페이스를 의미
  * View는 주로 데이터 표현에 관련된 **루비 코드가 삽입되어 있는 HTML** 파일이다.
  * 데이터를 웹 브라우저나 다른 기기에서 데이터를 제공하는 일을 담당


###Controllers
  : 모델과 뷰를 **연결**하는 역할
  * Controller는 웹브라우저의 요청을 받아서, 모델을 통해서 데이터를 조회하여, 출력을 위해 뷰에게 데이터를 넘겨준다.
    <br/><br/>

Revenge Create a web site
==============
### Preferences
* Gemfile Settings
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
  ```

  ```
* Controller Settings
  * controller 설정
  ```
  $ rails g controller question index show
  ```
  index, show가 routes.rb에 저절로 설정<br/>
  veiw에는 index.erb와 show.erb가 생성<br/>
  controller에는 index, show 메소드가 정의된다.

    * config에 생성된 routes.rb를 확인
      이곳에서 **라우팅**을 한다. 
      <br/>
      기본root를 index로 설정
      ```
      root 'question#index'
      ```
        get 'question/index'
        get 'question/show'
      ```
      다른 index와 show는 이런식으로 라우팅 된다. <br/>
      이후에 정의되는 method들은 수동으로 추가!
      ```

  * views의 question폴더 확인
    * controller를 만들 때 입력한 question으로, 폴더가 생성된 것을 볼 수 있고, index와 show veiw가 생성되어 있는 것을 확인 할 수 있다. <br/><br/>

* 모델 설치
  * model 설정
   ```
   $ rails g moder questionr
   ```
   * db의 migrate에 생겨난 create_questions.rb가 생성되었는지 확인 후, 칼럼 정의<br/>
   * 칼럼 정의
  ```
  t.string :name
  t.stirng :content
  ```
  * name과 content라는 col을 정의하였다. 

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
  rake db:migrate
  ```
  * Table에는 기본적으로 제공되는 id칼럼과 name, content, created_at, updated_at 총 5칼럼이 생성되게 된다. <br/>
    즉, 2개의 컬럼을 만들었지만, 5개의 컬럼을 이용할 수 있게된다.
    <br/><br/>


기본적인 설치작업이 끝나면 본격적으로 Website를 구현한다. 


* 라우트 설정
  * 기본적으로 순서는 이러하다. <br/> 
    (1) routes.rb에서 라우팅을 한다.<br/>
    (2) question_controller.rb에서 method를 정의한다. <br/>
    (3) 그 후, view파일을 만들면 web이 동작하게 된다.<br/>
    <br/>
    ```
    	  root 'question#index'

    	  get 'question/index'

    	  get 'question/show'
    ```
    root를 설정하고, index와 show가 정의되어 있는 것을 확인

* method 정의
  * method를 정의한다
  ```
  def index
  end

  def show
  end

  ```
  * index와 show안에 method 내용을 정의한다.
  * index method
    * user에게 입력받은 값을 보여준다. 
    * ​
  * show method


  * asked를 Homepage 구성을 위한 method 정의

    ```
     def index

    @questions = Question.all

    end

    def show

      @name = params[:name]

      @question = params[:question]

      Question.create(
       name: @name,
       question: @question
      )
    ```

    * User들을 위한 회원가입과 login method 정의	

  ```
  def sign_up
  end

  def sing_up_process

    params[:email]

    params[:name]

    params[:password]

    User.create(
    
    email: @email,
    name: @name, 
    password: @password
    )
    
  end

  def login
  end

  def login_process
  	@email = params[:@email]

       @password = params[:@password]

       @message = ""
       )
           
      # 유저 인증
      user = User.find_by(email: @email)
      # => nil
      # => email: dkfldjfkjd , name: akjdkfj, password: dkjfadfj
      
      #해당하는 email을 가진 user가 있다면?
      if user # 존재한다, nil이 아닌 값은 모두 True가 된다. 
        if user.password == @password
          session[:user_email] = user.email
          redirect_to '/'
        else
          @message = "비밀번호가 틀렸습니다."
        end
      else
        @message = "가입이 되어있지 않거나, 이메일이 틀렸습니다."
      end

      def logout
        session.clear

        redirect_to '/'
  end
  ```


* view 파일 만들기


### sign_up
* Database 유저 정보를 저장하는 것
  * 새로운 model을 설정 
  1. User 테이블 생성
        - User model
        ```ruby
        $ rails g model user
        ```
        - create_users.rb에서 컬럼 생성
        ```
        t.string :email
        t.string :name
        t.string :password
        ```
        * schema.rb를 확인하면 새로운 Users 테이블이 추가되어있다.

  2. User 정보를 저장
    - 회원정보를 받아, DB에 저장 

### login
* session 유저 정보를 검증을 거친 후 저장하는 것
   1. User 정보를 받는다.
   2. 받은 User 정보와 DB의 User 정보가 일치하는지 확인
   3. if 일치, session에 유저 정보를 넣는다. 
     else, 이유를 말해주고 로그인 안시킨다.
     session[:email] = 유저 정보를 넣는다.
   4. 로그아웃
     session.clear










