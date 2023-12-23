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

@app.route('/get_heart_rate_data', methods=['GET'])
def get_heart_rate_data():
    # 가상의 심박수 데이터 생성 (여기서는 무작위 데이터 생성)
    df = pd.read_excel('./data.xlsx')
    df.set_index('Date', inplace=True)
    df_resampled = df.resample('1Min').mean()
    df_resampled = df_resampled.round(1)
    df_resampled = df_resampled.drop(['Unnamed: 0'],axis=1)
    heart = df_resampled.drop(['Temp','Walk'],axis = 1)
    heart = heart.reset_index()
    #data = heart.to_json(orient='records', date_format='iso')
    data = heart.to_dict(orient='records')
    pretty_data = json.dumps(data, indent=4, default=str)

    return Response(pretty_data)

@app.route('/get_temp_rate_data', methods=['GET'])
def get_temp_rate_data():
    # 가상의 심박수 데이터 생성 (여기서는 무작위 데이터 생성)
    df = pd.read_excel('./data.xlsx')
    df.set_index('Date', inplace=True)
    df_resampled = df.resample('1Min').mean()
    df_resampled = df_resampled.round(1)
    df_resampled = df_resampled.drop(['Unnamed: 0'],axis=1)
    heart = df_resampled.drop(['Heart','Walk'],axis = 1)
    heart = heart.reset_index()
    #data = heart.to_json(orient='records', date_format='iso')
    data = heart.to_dict(orient='records')
    pretty_data = json.dumps(data, indent=4, default=str)

    return Response(pretty_data)


@app.route('/get_live_bio', methods=['POST'])
def get_live_bio():
    input_file_path = './sensor_value.txt'  # 입력 파일 경로에 맞게 수정

    data_groups = []

    current_data_group = []


    with open(input_file_path, 'r') as input_file, open("./temp_file.txt", 'w') as temp_file:
        current_datetime = None  # 현재 데이터 묶음의 시작 시간
        lines_count = 0
        for line in input_file:
            if len(line) == 1:
                lines_count = 0
            else:
                lines_count += 1
                if lines_count == 1:
                    date_string = line.strip()
                    date_format = "%Y-%m-%d %H:%M:%S"
                    datetime_object = datetime.strptime(date_string, date_format)
                    current_data_group.append(datetime_object)
                elif lines_count == 2:
                    temperature_match = line.replace("Temperature = ","")
                    current_data_group.append(float(temperature_match.rstrip()))
                elif lines_count == 3:
                    walk_match = line.replace("Walk = ","")
                    current_data_group.append(walk_match.rstrip())
                elif lines_count == 4:
                    if len(line) == 3:
                        pass
                    else:
                        heart_rate_match = line.replace("HeartRate =","")
                        current_data_group.append(int(heart_rate_match.rstrip()))
                        data_groups.append(current_data_group)
                        current_data_group = []
                elif lines_count == 5:
                    line = line.rstrip()
                    heart_rate_matc = line.split('=')[1]
                    current_data_group.append(int(heart_rate_match.rstrip()))
                    data_groups.append(current_data_group)
                    current_data_group = []

    with open(input_file_path, 'w') as input_file:
        input_file.write('\n\n')

    return jsonify(data_groups[-1]), 200
    
if __name__ == '__main__':
    app.run(debug=True)
