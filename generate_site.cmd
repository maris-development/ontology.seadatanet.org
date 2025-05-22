@echo off
SETLOCAL

:: This script generates a website for the ontology using Widoco.
:: It requires Java 11 to run. (%JAVA11_HOME%)


:: URL and target filename
set "widocoUrl=https://github.com/dgarijo/Widoco/releases/download/v1.4.25/widoco-1.4.25-jar-with-dependencies_JDK-11.jar"
set "widocoJarFile=widoco-1.4.25-jar-with-dependencies_JDK-11.jar"

:: Check and download if missing
if not exist "%widocoJarFile%" (
    echo [%date% %time%] %widocoJarFile% not found. Downloading...
    powershell -Command "try { Invoke-WebRequest -Uri '%widocoUrl%' -OutFile '%widocoJarFile%' -UseBasicParsing; Write-Host 'Download complete.' } catch { Write-Error 'Download failed.'; exit 1 }"
) else (
    echo [%date% %time%] %widocoJarFile% already exists. Skipping download.
)

:: Generate the website
"%JAVA11_HOME%\bin\java.exe" -jar widoco-1.4.25-jar-with-dependencies_JDK-11.jar -rewriteAll -ontFile ontology.ttl -confFile config/config.properties -outFolder public

ENDLOCAL