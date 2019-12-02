import requests
import json , ast
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

response = requests.get('https://localhost:5554/mgmt/config/test/APIPath', auth=('admin', 'admin'), verify=False)
APIPathJSON = json.loads(response.content)
APIPathJSON = ast.literal_eval(json.dumps(APIPathJSON))
APIPathLIST = APIPathJSON['APIPath']
listPath = []
jsonPath = {}
for i in APIPathLIST:
    listPath.append(i['Path'])

print(listPath)
