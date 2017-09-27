#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
import sys, getopt
import os
import requests
import json
import urllib

RESOURCE_URL="https://maps.googleapis.com/maps/api/geocode/json?"
LIMIT_PER_KEY=2449
#LIMIT_PER_KEY=2
KEYS=('AIzaSyDbfKw4-tMvrLOp-YoT6_McH-g5JzvR6qw', 
      'AIzaSyDYkAcWdeMC1enTvCGNyiOwteWL1RJeFrk',
      'AIzaSyDKsGo2rCZk30EHMu7fdZ4845vAreIAHPA',
      'AIzaSyBVHNiZHU1ewmACv86uePVkp9ggfLPMfwM',
      'AIzaSyAW9AaGNRk3L4gjv_Rg-OHajyLoSRKV98E',
      'AIzaSyD6EOZyw5PgUNNAzOwRN0lPRvPNmhCU4Tg',
      'AIzaSyB8n5725e9YdP-CuGa5giyaw-TP4y-H4s8',
      'AIzaSyCHmmRNrgNWXjAPUN5JRnfLEuI3lpXf5pA',
      'AIzaSyDt5CadGNd5QU4RQyO-RH26ik03CiwyDf0',
      'AIzaSyDKkdzLFTF6tJ_ZhL34bb9H22cmB-y_B80',
      'AIzaSyAh2ZXhHAuFZO5R_7nNVMUYz51xmN1AsaE',
      'AIzaSyBvwW4fXmGjHpbE4Ts4OE4fZQ4CdHAkDJU',
      'AIzaSyAMgGv6yimf3OJk7rEVTsPl8fnJ84BlU7A',
      'AIzaSyAoaJMZTwvm26KRicDB2Pv4Y2iVXtiSqiM',
      'AIzaSyBlqTDXOSGZWNdl-s4jTSdvCEfUefVMCYQ',
      'AIzaSyCmYKxsLBPuFqs0-fZ65PL-Qrwc27_KGGc',
      'AIzaSyAr1n9eyhIyY9O1y-w-W1U2o2wMK74bDkc',
      'AIzaSyB76Qk9mwBxvUmEgCekyvvckZtCRdqw67g',
      'AIzaSyAfSrhHG5xadSld0G2HWy0yGMEbjAX6bQM',
      'AIzaSyDV_Lg7hyxHFiHtxV5uFsvm2e_2DUolxSQ',
      'AIzaSyAZc9hLOlU0_8WqYdFpse6c0fZp2LTv8MQ',
      'AIzaSyAH7071FX3_nXboV6nBxGm5dgpNhfKR_LM',
      'AIzaSyCUVCudQsbrUvaj3ZuDYK-LpVSBpkSy2AQ',
      'AIzaSyBh-GeVOxRdoRQ8XtopOmcFgUmcNHJod_0'
 )

# https://maps.googleapis.com/maps/api/geocode/json?address=%E6%96%B0%E5%8C%97%E5%B8%82%E4%B8%89%E9%87%8D%E5%8D%80%E9%81%8E%E5%9C%B3%E8%A1%977%E5%B7%B720%E8%99%9F&key=AIzaSyBh-GeVOxRdoRQ8XtopOmcFgUmcNHJod_0

def printHelp():
    print("Usage: getLon_for_stolen_addr.py -f FILE_NAME")

def getLatLon(filePath):
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36'}
    outFile=open(filePath+"_latlon", 'w')
    inFile=open(filePath,'r')
    errorCount=0
    count=0
    index=0
    print("Processing the file: " + filePath)
    for line in inFile:
        key=KEYS[index]
        if line.find("北市") > 1:
            addr=line.split(',')[4].split("~")[0]+'號'
            urlencodeUrl=urllib.parse.quote(addr)
            url=RESOURCE_URL+"key="+key+"&address="+urlencodeUrl
            r=requests.post(url, headers=headers)
            if r.status_code == requests.codes.ok:
                outFile.write(line.strip()+","+addr+","+ str(r.json()['results'][0]['geometry']['location']['lat'])+","+str(r.json()['results'][0]['geometry']['location']['lng'])+"\n")
            else:
                errorCount+=1

            if count < LIMIT_PER_KEY:      
                count+=1
            else:
                count=0
                index+=1

    inFile.close()
    outFile.close()
    print("Error count:" + str(errorCount))
def main(argv):
    # 1. verify input
    inputFile = None
    try:
        opts, args = getopt.getopt(argv,"hf:",["fileName="])
    except getopt.GetoptError:
       printHelp()
       sys.exit(2)
    for opt, arg in opts:
       if opt == '-h':
           printHelp()
           sys.exit()
       elif opt in ("-f", "--fileName"):
           inputFile = arg
    if inputFile == None:
        if inputFile == None:
            print("Missing necessary parameters: FILE_NAME")
        printHelp()
        sys.exit(1)

    # 2. really process
    getLatLon(inputFile)

if __name__ == "__main__":
   main(sys.argv[1:])
