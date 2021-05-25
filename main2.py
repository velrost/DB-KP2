import psycopg2
import psycopg2.errorcodes
import csv

database = input('Input db name: ')
user = input("Input username: ")
password = input("Input password: ")
host = input("Input host: ")
port = input("Input port: ")
print("--------------------------")
print("--------------------------\n")

con = psycopg2.connect(
    database=database, user=user, password=password, host=host, port=port)

cur = con.cursor()


def result_func():
    select_query = '''
    SELECT Location.RegName, ZNO_Result.Year, min(ZNO_Result.Ball_100)
    FROM ZNO_Result JOIN Participant ON
        ZNO_Result.OutID = Participant.OutID
    JOIN Location ON
        Participant.location_ID = Location.location_ID
    WHERE ZNO_Result.TestName = 'Математика' AND
        ZNO_Result.TestStatus = 'Зараховано'
    GROUP BY Location.RegName, ZNO_Result.Year
    '''

    cur.execute(select_query)

    with open('result_2.csv', 'w', encoding="utf-8") as new_csv_file:
        csv_writer = csv.writer(new_csv_file)
        csv_writer.writerow(['Область', 'Рік', 'Найгірший бал з Математики'])
        for row in cur:
            csv_writer.writerow(row)


result_func()

print("Result was wrote to 'result_2.csv' ")

cur.close()
con.close()