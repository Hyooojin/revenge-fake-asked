# Rails를 이용해 asked 홈페이지 만들어보기 Revenge!!!

### Rails
레일즈는 루비 언어로 작성된 웹 어플리케이션 프레임워크이다.  <br/>
레일즈는 모든 개발자가 개발을 시작 할 때 필요한 초기 준비나 가정들을 쉽게 만들 수 있는 도구를 제공하여, 웹 어플리케이션 프로그래밍을 더 쉽게 만들 수 있도록 설계되어 있다. <br/>
[레일즈 시작하기 참고사이트](https://rubykr.github.io/rails_guides/getting_started.html)
<br/><br/>

### MVC 아키텍쳐
레일즈의 중심에는 MVC 라고 불리는 모델, 뷰, 컨트롤러 아키텍처가 있다.
* Models
  : 어플리케이션의 데이터를 다루는 규칙을 의미
  * Modle은 데이터 베이스 테이블과 상호 작용하는 규칙을 관리
  * 데이터 베이스의 하나의 테이블은 어플리케이션의 하나의 모델과 대응


* Views
  : 어플리케이션 유저 인터페이스를 의미
  * View는 주로 데이터 표현에 관련된 **루비 코드가 삽입되어 있는 HTML** 파일이다.
  * 데이터를 웹 브라우저나 다른 기기에서 데이터를 제공하는 일을 담당


* Controllers
  : 모델과 뷰를 **연결**하는 역할
  * Controller는 웹브라우저의 요청을 받아서, 모델을 통해서 데이터를 조회하여, 출력을 위해 뷰에게 데이터를 넘겨준다.
    <br/><br/>

### 임시로 asked 사이트 만들기
* 환경설치

  * 컨트롤러 설치
    * $ rails g controller question<br/>
    * config에 생성된 routes.rb를 확인
      이곳에서 **라우팅**을 한다. 
      <br/>
    * views의 입력한 question 확인
       입력한 이름(이곳에서는 question)으로, 폴더가 생성된 것을 볼 수 있고, 이곳에 view파일들을 작성 
  * 모델 설치
    * rails g moder questionr<br/>

    * db의 migrate에 생겨난 create_questions.rb에 칼럼 정의<br/>
      t.[데이터타입] :컬럼명<br/>
      예시) t.string :name<br/>
      ```ruby
      class CreateQuestions < ActiveRecord::Migration
        def change
          create_table :questions do |t|
            
            # 추가 -----
            t.string :name
            t.string :question
            # ----
            t.timestamps null: false
          end
        end
      end
      ```

      저장 후, 다음 명령문을 실행<br/> 

    * 다음 명령문을 실행하면 table을 생성한다. 

      ```$ rake db:migrate```

      <br/>

    * db에 schema.rb를 확인 
      새로운 컬럼을 추가한 Schema가 생성된 것을 확인 할 수 있다. 
      <br/><br/>

* 라우트 설정
  * 기본적으로 순서는 이러하다. <br/> 
    : routes.rb에서 라우팅을 한 후, question_controller.rb에서 method를 정의한다. 그 후, view파일을 만들면 web이 동작하게 된다. 

  * routes 설정

    ``````
    root 'question#index'
      
      get 'question/index'

      get 'question/show'

      get 'question/sign_up'
      
      get 'question/sign_up_process'
      
      get 'question/login'
      
      get 'question/login_process'
      
      get 'question/logout'
    ``````

* method 정의
  * method를 정의한다
    ```
    def # 메소드 이름
    # 메소드 정의
    end
    ```

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










