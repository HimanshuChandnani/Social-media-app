from flask import Flask, render_template, request, redirect, session
from werkzeug.utils import secure_filename
from flask_session import Session
import pymysql
import datetime
import json

app = Flask(__name__)
app.config["UPLOAD_FOLDER"] = "static/media"
app.config["UPLOAD_FOLDER_PFP"] = "static/media/pfp"
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

def getContent(query):
    connect = pymysql.connect(host="localhost", db="social", port=3306, user="root")

    cursor = connect.cursor()

    cursor.execute(query)
    output = cursor.fetchall()

    connect.close()
    return output

def setContent(query):
    connect = pymysql.connect(host="localhost", db="social", port=3306, user="root")

    cursor = connect.cursor()

    cursor.execute(query)
    connect.commit()

    connect.close()

@app.context_processor
def globalVariables():
    data = {
        "username": session.get('name')
    }
    return data

@app.route("/")
@app.route("/home")
def home():
    if not session.get("name"):
        return redirect("/signup")

    content = getContent("select * from content order by msg_id desc")
    pfp = getContent("select name,pfp from auth")
    likes = getContent("select * from likes")
    comments = getContent("select * from comments")

    postLikes = {}
    postComments = {}

    for i in content:
        postLikes[i[0]] = 0
        postComments[i[0]] = 0

    for i in likes:
        postLikes[i[0]] += 1
    
    for i in comments:
        postComments[i[1]] += 1

    print(postLikes)

    userLikes = getContent(f"select post_id from likes where name = '{session['name']}'")



    print(content)
    return render_template("home.html", content=content, pfp=pfp, postLikes=postLikes, userLikes=userLikes, postComments=postComments)

@app.route('/handlelike', methods = ["POST"])
def like():

    req = json.loads(request.data.decode('utf-8'))
    print(req)
    name = session['name']

    if req["like"] == "like":
        if not getContent(f"select * from likes where post_id = '{req['post']}' and name = '{name}'"):
            setContent(f"insert into likes values('{req['post']}', '{name}')")
    else:
        setContent(f"delete from likes where post_id = '{req['post']}' and name = '{name}'")
    
    return "200"



@app.route("/comment&<int:msg_id>", methods=["GET", "POST"])
def comment(msg_id):
    if not session.get("name"):
        return redirect("/signup")
    
    if request.method == "POST":
        comment = request.form.get("comment")
        name = session['name']
        time = str(datetime.datetime.now().date()) + " " + str(datetime.datetime.now().time())[:5]
        setContent(f"insert into comments (post_id, name, time, comment) values('{msg_id}', '{name}', '{time}', '{comment}')")

    post = getContent(f"select * from content where msg_id = '{msg_id}'")
    comments = getContent(f"select * from comments where post_id = '{msg_id}'")
    pfp = getContent("select name, pfp from auth")
    mainPfp = getContent(f"select pfp from auth where name = '{post[0][1]}'")
    likes = getContent(f"select * from likes where post_id = {msg_id}")
    userLikes = getContent(f"select post_id from likes where post_id = {msg_id} and name = '{session['name']}'")

    postLikes = len(likes)
    print(postLikes)

    return render_template("comment.html", post=post, comments=comments, pfp=pfp, mainPfp=mainPfp, postLikes=postLikes, userLikes=userLikes)

@app.route("/upload", methods=["GET", "POST"])
def upload():
    if not session.get("name"):
        return redirect("/signup")

    if request.method == "POST":
        file = request.files["file"]
        caption = request.form.get("caption")

        path = app.config["UPLOAD_FOLDER"] + "/" + secure_filename(file.filename)
        if file:
            file.save(path)

        name = session['name']
        time = str(datetime.datetime.now().date()) + " " + str(datetime.datetime.now().time())[:5]
        setContent(f"insert into content (name, time, path, caption) values('{name}', '{time}', '{path}', '{caption}')")

        return redirect("/")

    return render_template("upload.html")

@app.route("/signup", methods=["GET","POST"])
def signup():
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        password = request.form.get("password")
        pfp = request.files['pfp']

        path = app.config["UPLOAD_FOLDER_PFP"] + "/" + secure_filename(pfp.filename)
        if pfp:
            pfp.save(path)

        if not getContent(f"select * from auth where name = '{name}'"):
            setContent(f"insert into auth values('{name}', '{email}', '{password}', '{path}')")
            session["name"] = name
            return redirect("/")
        else:
            return render_template("signup.html", error="Username already used")
        
    return render_template("signup.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        name = request.form.get("name")
        password = request.form.get("password")
        if getContent(f"select * from auth where name = '{name}' and password = '{password}'"):
            session["name"] = getContent(f"select name from auth where name = '{name}' and password = '{password}'")[0][0]
            return redirect("/")
        else:
            return render_template("login.html", error="Invalid username or password")
            
    return render_template("login.html")

@app.route("/logout")
def logout():
    if not session.get("name"):
        return redirect("/signup")
    
    session["name"] = None
    return redirect("/")
    
        


if __name__ == "__main__":
    app.run(host="localhost",port=12345,debug=True)

