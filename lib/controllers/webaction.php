<?php
    header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
    header("Access-Control-Allow-Origin: *");

    $dns= 'localhost';
    $database='ccpgroup_gonaira';
    $username = 'ccpgroup_admin';
    $password = 'survey101#';
    $pageTitle="Survey.io";

    $action = $_POST['action'];

    /// Connect to Database
    try
    {
        $pdo = new PDO("mysql:host=$dns;dbname=$database",$username,$password);
        $status= $pdo->getAttribute(PDO::ATTR_CONNECTION_STATUS);
    }
    catch(PDOException $e)
    {

        $message = "Unable to load page resource.<br>Contact Admin.";

        echo "Unable to connect to DB.".$e->getMessage();
    }
    if($status==TRUE)
    {
        //echo "Database connection Successful.";
    }
    ///

    ///Get all Options
    try{
       $sql ="Select surveyId, questionId,option from options";
       $result = $pdo->query($sql);
       foreach($result as $row)
       {
           $options[] = array(
           'surveyId'=>$row['surveyId'],
           'questionId' => $row['questionId'],
           'option' => $row['option']
           );
       }
    }
    catch(PDOException $e)
    {
       echo 'error '.$e->getMessage();
    }

    ///GET SURVEYS
      if($action=="GET_SURVEYS")
      {
          $surveys = [];
          $sql="select survey.id,title,description,completed, count(survey.title) as numberOfQuestions,amount,population from survey INNER join questions on survey.id = questions.surveyId GROUP by survey.id ORDER BY survey.id DESC";
          //$sql ="Select id,title,description,completed from survey";
           $result = $pdo->query($sql);

           foreach($result as $row)
           {
               $surveys[] = array(
               'id'=>''.$row['id'].'',//Converts to String
               'title' => $row['title'],
               'description' => $row['description'],
               'completed' => $row['completed'],
               'numberOfQuestions' => ''.$row['numberOfQuestions'].'',//Converts to String,
               'amount' => $row['amount'],
               'population' => $row['population'],//Converts to String
               );
           }
           if(count($surveys)>0)
            {
                echo json_encode($surveys);
            }
            else{
                echo "error";
            }
        $pdo = null;
	    return;
      }

    //


    ///  GET SURVEY QUESTIONS

    if($action == "GET_SURVEY_QUESTIONS")
    {
       try
       {

          $sql = "SELECT questions.id as id,surveyId,question,title,description,response FROM questions inner join survey on survey.id=questions.surveyId WHERE surveyId=:surveyId";
          //$sql = "SELECT id,surveyId,question,title,description FROM questions inner join survey WHERE surveyId=:surveyId";
          $stmt = $pdo->prepare($sql);
          $stmt->bindValue(':surveyId',  htmlspecialchars($_POST['surveyId'],ENT_QUOTES,'UTF-8'));
          $stmt->execute();
       }
       catch(PDOException $e)
       {
          echo 'error '.$e->getMessage();
       }

        $questions= array();
        foreach($stmt as $row)
        {
            $questions[]=array(
            'questionNumber'=>''.$row['id'].'',
            'surveyId' =>''.$row['surveyId'].'',
            'title' => $row['title'],
            'description'=>$row['description'],
            'question' =>$row['question'],
            'response' =>$row['response'] ,
            );
        }


        $opts = [];
        $surveyQuestions = array();
        foreach($questions as $question)
        {
            foreach($options as $option)
            {
              if($option['surveyId'] == $question['surveyId'] and $option['questionId']==$question['questionNumber'])
              {
                  $opts[]=$option['option'] ;
              }

            }
            $question['options']= $opts;
            $surveyQuestions[] = $question;
            $opts = array(); //Empty the array
        }
        if(count($surveyQuestions)>0)
        {
            echo json_encode($surveyQuestions);
        }
        else{
            echo "error";
        }
        $pdo = null;
	    return;
    }

    if($action=='POST_RESPONSE')
    {
        try{
        $sql = "Insert into response set userId=:userId,surveyId=:surveyId,title=:title,description=:description,questionNumber=:questionNumber,question=:question,response=:response";
            $s = $pdo->prepare($sql);
            $s->bindValue(':userId',  htmlspecialchars($_POST['userId'],ENT_QUOTES,'UTF-8'));
            $s->bindValue(':surveyId',  htmlspecialchars($_POST['surveyId'],ENT_QUOTES,'UTF-8'));            
            $s->bindValue(':title',  htmlspecialchars($_POST['title'],ENT_QUOTES,'UTF-8'));
            $s->bindValue(':description',htmlspecialchars($_POST['description'],ENT_QUOTES,'UTF-8'));
            $s->bindValue(':questionNumber',htmlspecialchars($_POST['questionNumber'],ENT_QUOTES,'UTF-8'));
            $s->bindValue(':question',htmlspecialchars($_POST['question'],ENT_QUOTES,'UTF-8'));
            $s->bindValue(':response',htmlspecialchars($_POST['response'],ENT_QUOTES,'UTF-8'));
            $s->execute();
        }
        catch(PDOException $e)
        {
            echo "error";
        }
        echo "success";
    }

    if($action=='COUNT_RESPONSE')
    {
        try
        {
          $sql = "Select count(*) from (SELECT COUNT(userId) as users from response where surveyId =:surveyId GROUP BY userId) x";  
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(':surveyId',htmlspecialchars($_POST['surveyId'],ENT_QUOTES,'UTF-8'));
            $stmt->execute();
            $row = $stmt -> fetch();

            echo $row[0];
            
        } catch (PDOException $e) {
            echo 'error';
        }
        $pdo = null;
	    return;
    }

    ///Users

    if($action=='GET_USER')
    {       

        try
        {
            $sql = "SELECT id,email,password from user where email=:email";
            $stmt =$pdo->prepare($sql);
            $stmt->bindValue(':email',strtolower(htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8')));
            $stmt->execute();
            $row=$stmt->fetch();

        }
        catch(PDOException $e)
        {
            echo 'error';
        }
        echo json_encode($row[0]);
    }

    if($action == "ALL_USERS")
    {
        try
        {
           $sql = "SELECT id,email,password from user";
           $result = $pdo->query($sql);
           $users = array();
           foreach($result as $row)
           {
               $users[]=array(
                   'id'=> ''.$row['id'].'',//Converts to String 
                   'email'=>$row['email'],
                   'password'=>$row['password']
               ); 
           } 
           echo json_encode($users);
        } 
        catch (PDOException $e) {
            echo "error: $e";
        }
        $pdo = null;
	    return;
    }

    ///User has done survey
    if($action=="HAS_DONE_SURVEY")
    {
        try
        {
            $sql ="SELECT count(*) FROM response WHERE surveyId=:surveyId and userId=:userId";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(':surveyId',htmlspecialchars($_POST['surveyId'],ENT_QUOTES,'UTF-8'));
            $stmt->bindValue(':userId',htmlspecialchars($_POST['userId'],ENT_QUOTES,'UTF-8'));
            $stmt->execute();
            $row = $stmt->fetch();
            if($row[0]>0)
            {
                echo 'true';
            }
            else
            {
                echo 'false';
            }

        }
        catch(PDOException $e)
        {
            echo $e;
        }
        $pdo = null;
	    return;
    }

    if($action =='GEN_TOKEN')
    {
        /***
         * Token
        //1)Generates cryptographically secure pseudo-random bytes
        //2) Convert binary data into hexadecimal representation
        
        **/
        $token = bin2hex(random_bytes(32)); //64 byte/Character token
        echo $token;    
    }

    if($action=='VERIFY_WALLET')
    {
                                                                    
    }




?>