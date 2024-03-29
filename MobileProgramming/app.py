import sqlite3
from flask import Flask, request, jsonify, render_template, Response, g
from flask_cors import CORS
import plotly.express as px
import plotly.offline as pyo
import pandas as pd
import random
import json
import re
from datetime import datetime
import os


SUBJECT_DATA = {
    "모바일 프로그래밍" : 1,
    "멀티코어 컴퓨팅" : 2,
    "알고리즘" : 3,
    "데이터베이스 설계" : 4,
    "이산수학" : 5
}

BOARDTYPE = {
    'question' : 1,
    'sharenote' : 2,
    'board' : 3
}

app = Flask(__name__)
CORS(app)

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    print(username,password)
    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM user WHERE id = ?;", (username,))

    result = cursor.fetchone()
    print(result)
    if result is None:
        conn.close()
        return jsonify({'success': False, 'message': '아이디가 없습니다.'}), 400

    saved_password = result[1]

    if password == saved_password:
        conn.close()
        return jsonify({'success': True, 'message': '로그인 성공'}), 200
    else:
        conn.close()
        return jsonify({'success': False, 'message': '비밀번호가 다릅니다.'}), 400


@app.route('/check_username', methods=['POST'])
def check_username():
    data = request.json
    username = data.get('username')

    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM user WHERE id = ?;", (username,))
    result = cursor.fetchone()

    if result is None:
        conn.close()
        return jsonify({'available': True}), 200
    else:
        conn.close()
        return jsonify({'available': False}), 200


@app.route('/register', methods=['POST'])
def register():
    data = request.json
    print(data)
    username = data.get('username')
    password = data.get('password')
    name = data.get('name')
    studentid = data.get('studentid')
    print(data)
    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()
    print(username,password,name,studentid)
    cursor.execute("INSERT INTO user (id, password, name, studentid) VALUES (?, ?, ?, ?);",(username, password, name, studentid))
    conn.commit()
    conn.close()

    return jsonify({'success': True, 'message': '회원가입 성공'}), 200


@app.route('/get_board',methods=['POST'])
def get_board():
    data = request.json
    print(data)
    subject = data.get('subject')
    board_type = data.get('boardtype')
    
    board_code = BOARDTYPE[board_type]
    subject_code = SUBJECT_DATA[subject]
    
    print(board_code,subject_code)
    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM board WHERE boardtype = ? AND subject = ?', (board_code, subject_code))
    rows = cursor.fetchall()
    
    board_list = []
    for row in rows:
        board_dict = {
            'id': row[0],
            'user': row[3],
            'title': row[4],
            'content': row[5],
            'date': row[6],
            'like': row[7],
            'dislike': row[8],
            'anonymous': row[9]
        }
        board_list.append(board_dict)
    return jsonify({'success' : True, 'message' : "조회 성공",'data': board_list})

@app.route('/get_comment',methods=['POST'])
def get_comment():
    data = request.json
    boardid = data.get('boardid')
    
    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()
    
    cursor.execute('SELECT * FROM boardcomment WHERE questionid = ?', (boardid,))
    rows = cursor.fetchall()
    
    comment_list = []
    for row in rows:
        comment_dict = {
            'questionid': row[0],
            'user': row[1],
            'content': row[2],
            'time': row[3],
            'anonymous': row[4]
        }
        comment_list.append(comment_dict)
    
    return jsonify({'success' : True, 'message' : "조회 성공",'commentdata' : comment_list})


@app.route('/get_board_content',methods=['POST'])
def get_board_content():
    data = request.json
    
    boardid = data.get('boardid')

    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM board WHERE boardid = ? ', (boardid, ))
    a = cursor.fetchone()
    print(a)


    board_dict = {
        'id': a[0],
        'user': a[3],
        'title': a[4],
        'content': a[5],
        'date': a[6],
        'like': a[7],
        'dislike': a[8],
        'anonymous': a[9]
    }
    board_list = [board_dict]
    return jsonify({'success' : True, 'message' : "조회 성공",'data': board_list})



@app.route('/get_petInfo', methods=['POST'])
def get_pet_info():
    data = request.json
    username = data.get('username')

    conn = sqlite3.connect(host='34.64.117.42', user='root', password='1234', db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT PetName, PetGender,DATE_FORMAT(PetBirth, '%%Y-%%m-%%d'), PetSort FROM DeviceInfo WHERE ID = %s;", (username,))
    result = cursor.fetchone()

    conn.close()

    if result is None:
        return jsonify({'error': 'Pet information not found'}), 404

    pet_info = {
        'PetName': result[0],
        'PetGender': result[1],
        'PetBirth': result[2],
        'PetSort': result[3]
    }

    return jsonify(pet_info), 200


@app.route('/get_comment', methods=['POST'])
def get_pet_info_Home():
    data = request.json
    username = data.get('username')

    conn = sqlite3.connect(host='34.64.117.42', user='root', password='1234', db='data')
    cursor = conn.cursor()

    cursor.execute("SELECT PetName, DATE_FORMAT(PetBirth, '%%Y-%%m-%%d') FROM DeviceInfo WHERE ID = %s;", (username,))
    result = cursor.fetchone()

    conn.close()

    if result is None:
        return jsonify({'error': 'Pet information not found'}), 404

    pet_info = {
        'PetName': result[0],
        'PetBirth': result[1]
    }

    return jsonify(pet_info), 200

@app.route('/make_quiz',methods=['POST'])
def make_quiz():
    data = request.json
    subject = data.get('subject')
    
    conn = sqlite3.connect('./database.db')
    cursor = conn.cursor()
    
    cursor.execute('SELECT * FROM quiz WHERE subject = ?', (SUBJECT_DATA[subject],))
    rows = cursor.fetchall()
    
    comment_list = []
    for row in rows:
        print(row)
        comment_dict = {
            'quizid': row[0],
            'subject': row[1],
            'question': row[2],
            'answersheet': row[3],
            'answer': row[4]
        }
        comment_list.append(comment_dict)
    
    return jsonify({'success' : True, 'message' : "조회 성공",'data' : comment_list})
    
if __name__ == '__main__':
    app.run(debug=True)
