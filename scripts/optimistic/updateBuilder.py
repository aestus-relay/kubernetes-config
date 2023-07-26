import argparse
import requests

def builderStatus(url, builder_pubkey, high_prio, blacklisted, optimistic, method):
    url = f"{url}/{builder_pubkey}"
    if method == 'get':
        response = requests.get(url)
        if response.status_code == 200:
            print("Success:", response.json())
        else:
            print("Error:", response.status_code, response.text)
    else:
        data = {
            "high_prio": high_prio,
            "blacklisted": blacklisted,
            "optimistic": optimistic,
        }
        response = requests.post(url, params=data)
        if response.status_code == 200:
            print("Success:", response.json())
        else:
            print("Error:", response.status_code, response.text)

def builderCollateral(url, builder_pubkey, collateral, value):
    url = f"{url}/{builder_pubkey}"
    data = {
        "collateral": collateral,
        "value": value,
    }
    response = requests.post(url, params=data)
    if response.status_code == 200:
        print("Success:", response.json())
    else:
        print("Error:", response.status_code, response.text)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", required=True, help="URL of the service within the Kubernetes cluster")
    parser.add_argument("--pubkey", required=True, help="Builder's public key")
    parser.add_argument("--high_prio", default="false", help="High priority status (true or false)")
    parser.add_argument("--blacklisted", default="false", help="Blacklisted status (true or false)")
    parser.add_argument("--optimistic", default="false", help="Optimistic status (true or false)")
    parser.add_argument("--collateral", default="", help="Collateral")
    parser.add_argument("--value", default="", help="Value")
    parser.add_argument("--method", default='get', choices=['get', 'post'], help="HTTP method (get or post)")
    parser.add_argument("--function", default='builderStatus', choices=['builderStatus', 'builderCollateral'], help="Function to call")

    args = parser.parse_args()
    
    if args.function == 'builderStatus':
        builderStatus(args.url, args.pubkey, args.high_prio, args.blacklisted, args.optimistic, args.method)
    else:
        builderCollateral(args.url, args.pubkey, args.collateral, args.value)
