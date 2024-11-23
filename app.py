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

def getContent(query, params=()):
    connect = pymysql.connect(host="localhost", db="social", port=3306, user="root")

    cursor = connect.cursor()

    cursor.execute(query, params)
    output = cursor.fetchall()

    connect.close()
    return output

def setContent(query, params=()):
    connect = pymysql.connect(host="localhost", db="social", port=3306, user="root")

    cursor = connect.cursor()

    cursor.execute(query, params)
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

    userLikes = getContent(f"select post_id from likes where name = %s", (session['name']))

    return render_template("home.html", content=content, pfp=pfp, postLikes=postLikes, userLikes=userLikes, postComments=postComments)

@app.route('/handlelike', methods = ["POST"])
def like():

    req = json.loads(request.data.decode('utf-8'))
    print(req)
    name = session['name']

    if req["like"] == "like":
        if not getContent(f"select * from likes where post_id = %s and name = %s", (req['post'], name)):
            setContent(f"insert into likes values(%s, %s)", (req['post'], name))
    else:
        setContent(f"delete from likes where post_id = %s and name = %s", (req['post'], name))
    
    return "200"

@app.route("/chat&global", methods=["GET", "POST"])
def globalChat():
    if not session.get("name"):
        return redirect("/signup")
    
    error = None

    if request.method == "POST":
        name = request.form.get("name")

        if getContent(f"select name from auth where name = %s", (name)):
            return redirect(f"/chat&u&{name}")
        else:
            error = f"{name} does not exist"

    messages = getContent("select * from messages where receiver = 'global'")
    name = session['name']
    pfp = getContent("select name, pfp from auth")
    chats = getContent("select sender, receiver from messages order by id desc")

    userChats = []

    messages1 = list(messages)

    for i in range(len(messages1)):
        messages1[i] = list(messages1[i])
        for j in range (1, len(messages1[i])):
            messages1[i][j] = messages1[i][j].replace('"', 'quot;')
            messages1[i][j] = messages1[i][j].replace("'", 'apos;')

    for i in chats:
        if name == i[0]:
            if i[1] not in userChats:
                userChats.append(i[1])
        elif name == i[1]:
            if i[0] not in userChats:
                userChats.append(i[0])

    return render_template("chat.html", messages=messages, messages1=json.dumps(messages1), name=name, pfp=pfp, chats=userChats, error=error, user="global")

@app.route("/chat&u&<user>", methods=["GET", "POST"])
def userChat(user):
    if not session.get("name"):
        return redirect("/signup")
    
    error = None

    if request.method == "POST":
        name = request.form.get("name").strip()

        if name and getContent(f"select name from auth where name = %s", (name)):
            return redirect(f"/chat&u&{name}")
        else:
            error = f"{name} does not exist"

    if not getContent(f"select name from auth where name = %s", (user)):
        return redirect(f"/chat&global")
    
    user = getContent(f"select name from auth where name = %s", {user})[0][0]

    name = session['name']
    messages = getContent(f"select * from messages where (receiver = %s and sender = %s) or (sender = %s and receiver = %s)", (user, name, user, name))
    pfp = getContent("select name, pfp from auth")
    chats = getContent("select sender, receiver from messages order by id desc")

    userChats = []

    messages1 = list(messages)

    for i in range(len(messages1)):
        messages1[i] = list(messages1[i])
        for j in range (1, len(messages1[i])):
            messages1[i][j] = messages1[i][j].replace('"', 'quot;')
            messages1[i][j] = messages1[i][j].replace("'", 'apos;')

    for i in chats:
        if name == i[0]:
            if i[1] not in userChats:
                userChats.append(i[1])
        elif name == i[1]:
            if i[0] not in userChats:
                userChats.append(i[0])

    return render_template("chat.html", messages=messages, messages1=json.dumps(messages1), name=name, pfp=pfp, chats=userChats, error=error, user=user)

@app.route("/handlemessage", methods=["GET", "POST"])
def handleMessageGlobal():
    if request.method == "POST":
        req = json.loads(request.data.decode('utf-8'))
        name = session['name']
        setContent(f"insert into messages (sender, receiver, time, text) values(%s, %s, NOW(), %s);", (name, "global", req['message']))
        return "200"
    
    if request.method == "GET":
        name = session['name']
        messages = getContent(f"select * from messages where receiver = 'global'")
        pfp = getContent("select name, pfp from auth")
        
        return {'messages':messages, 'pfp':pfp}

@app.route("/handlemessage&<user>", methods=["GET", "POST"])
def handleMessage(user):
    if request.method == "POST":
        req = json.loads(request.data.decode('utf-8'))
        name = session['name']
        setContent(f"insert into messages (sender, receiver, time, text) values(%s, %s, NOW(), %s);", (name, user, req['message']))
        return "200"
    
    if request.method == "GET":
        name = session['name']
        messages = getContent(f"select * from messages where (receiver = %s and sender = %s) or (sender = %s and receiver = %s)", (user, name, user, name))
        pfp = getContent("select name, pfp from auth")

        return {'messages':messages, 'pfp':pfp}

@app.route("/deletepost", methods=["GET", "POST"])
def deletePost():
    if not session.get("name"):
        return redirect("/signup")
    
    if request.method == "POST":
        post = request.data.decode('utf-8')
        name = session['name']
        setContent(f"delete from content where msg_id = %s and name = %s", (post, name))
        setContent(f"delete from comments where post_id = %s", (post))
        setContent(f"delete from likes where post_id = %s", (post))

        if not getContent(f"select * from comments where msg_id = %s", (post)):
            return "200"

@app.route("/edit&post&<post_id>", methods=["GET", "POST"])
def aditPost(post_id):
    if not session.get("name"):
        return redirect("/signup")
    
    name = session['name']

    if request.method == "POST":
        file = request.files["file"]
        caption = request.form.get("caption")

        path = app.config["UPLOAD_FOLDER"] + "/" + secure_filename(file.filename)
        if file:
            file.save(path)
            setContent(f"update content set path = %s, caption = %s where msg_id = %s", (path, caption, post_id))

        else:
            setContent(f"update content set caption = %s where msg_id = %s", (caption, post_id))

        return redirect("/")
    post = getContent(f"select * from content where msg_id = %s and name = %s", (post_id, name))
    return render_template("upload.html", post=post)


@app.route("/comment&<int:msg_id>", methods=["GET", "POST"])
def comment(msg_id):
    if not session.get("name"):
        return redirect("/signup")
    
    if request.method == "POST":
        comment = request.form.get("comment")
        name = session['name']
        time = str(datetime.datetime.now().date()) + " " + str(datetime.datetime.now().time())[:5]
        setContent(f"insert into comments (post_id, name, time, comment) values(%s, %s, %s, %s)", (msg_id, name, time, comment))

    post = getContent(f"select * from content where msg_id = %s", (msg_id))
    comments = getContent(f"select * from comments where post_id = %s", (msg_id))
    pfp = getContent("select name, pfp from auth")
    mainPfp = getContent(f"select pfp from auth where name = %s", (post[0][1]))
    likes = getContent(f"select * from likes where post_id = %s", (msg_id))
    userLikes = getContent(f"select post_id from likes where post_id = %s and name = %s", (msg_id, session['name']))

    postLikes = len(likes)

    return render_template("comment.html", post=post, comments=comments, pfp=pfp, mainPfp=mainPfp, postLikes=postLikes, userLikes=userLikes)

@app.route("/profile")
def profile():
    if not session.get("name"):
        return redirect("/signup")
    
    name = session['name']
    pfp = getContent(f"select pfp from auth where name = %s", (name))[0][0]
    posts = getContent(f"select msg_id, path from content where name = %s order by msg_id desc", (name))

    print(pfp, posts)

    return render_template("profile.html", pfp=pfp, posts=posts, name=name)

@app.route("/profile&<user>")
def profileUser(user):
    if not session.get("name"):
        return redirect("/signup")
    
    if not getContent(f"select * from auth where name = %s", (user)):
        return redirect("/")
    
    pfp = getContent(f"select pfp from auth where name = %s", (user))[0][0]
    posts = getContent(f"select msg_id, path from content where name = %s order by msg_id desc", (user))

    print(pfp, posts)

    return render_template("profile.html", pfp=pfp, posts=posts, name=user)

@app.route("/edit-profile", methods=["GET", "POST"])
def editProfile():
    if not session.get("name"):
        return redirect("/signup")
    
    originalName = session['name']
    info = getContent(f"select name, email, password from auth where name = %s", (originalName))[0]
    
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        password = request.form.get("password")
        curPassword = request.form.get("curPassword")
        pfp = request.files['pfp']

        if not getContent(f"select * from auth where name = %s and password = %s", (originalName, curPassword)):
            return render_template("signup.html", error="Incorrect current password", info=info)
        
        if getContent(f"select * from auth where name = %s", (name)) and name != originalName:
            return render_template("signup.html", error="Username already used", info=info)

        path = app.config["UPLOAD_FOLDER_PFP"] + "/" + secure_filename(pfp.filename)
        if pfp:
            pfp.save(path)
            setContent(f"update auth set pfp = %s where name = %s", (path, originalName))

        if password:
            setContent(f"update auth set password = %s where name = %s", (password, originalName))

        setContent(f"update auth set name = %s, email = %s where name = %s", (name, email, originalName))
        setContent(f"update comments set name = %s where name = %s", (name, originalName))
        setContent(f"update content set name = %s where name = %s", (name, originalName))
        setContent(f"update likes set name = %s where name = %s", (name, originalName))
        setContent(f"update messages set sender = %s where sender = %s", (name, originalName))
        setContent(f"update messages set receiver = %s where receiver = %s", (name, originalName))

        session["name"] = name
        return redirect("/profile")

    return render_template("signup.html", info=info)

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
        setContent(f"insert into content (name, time, path, caption) values(%s, NOW(), %s, %s)", (name, path, caption))

        return redirect("/")

    return render_template("upload.html")

@app.route("/signup", methods=["GET","POST"])
def signup():
    if session.get("name"):
        return redirect("/")
    
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        password = request.form.get("password")
        pfp = request.files['pfp']

        path = app.config["UPLOAD_FOLDER_PFP"] + "/" + secure_filename(pfp.filename)
        if pfp:
            pfp.save(path)

        if not getContent(f"select * from auth where name = %s", (name)):
            setContent(f"insert into auth values(%s, %s, %s, %s)", (name, email, password, path))
            session["name"] = name
            return redirect("/")
        else:
            return render_template("signup.html", error="Username already used")
        
    return render_template("signup.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    if session.get("name"):
        return redirect("/")
    
    if request.method == "POST":
        name = request.form.get("name")
        password = request.form.get("password")
        if getContent(f"select * from auth where name = %s and password = %s", (name, password)):
            session["name"] = getContent(f"select name from auth where name = %s and password = %s", (name, password))[0][0]
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
    app.run(host="0.0.0.0",port=12345,debug=True)

