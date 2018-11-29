from jinja2 import Environment, FileSystemLoader
import pandas as pd
import os

env = Environment(loader=FileSystemLoader('./'))
template = env.get_template('test.html')

output_from_parsed_template = template.render(foo='Hello World!')
print output_from_parsed_template
names = ['name','age','addres','high','weigh']
df = pd.read_csv('csv.csv', names=names)
print df

for index, row in df.iterrows():
    print row["name"], row["high"]
    temp=[]
    data = row
    temp.append(data.tolist())
    print temp
    output_from_parsed_template = template.render(name=row["name"], high=row["high"],addres=row["addres"],age=row["age"],weigh=row["weigh"],names=names,temp=temp)
    # to save the results
    if not os.path.exists(str(index)):
      os.makedirs(str(index))
    with open(str(index)+"/dep.cfg", "wb") as fh:
      fh.write(output_from_parsed_template)

