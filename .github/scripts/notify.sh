#!/bin/bash

# notify.sh
send_telegram_notification() {
    local status=$1
    local version=$2
    local commit_sha=$3
    local build_date=$4

    case $status in
        "start")
            MESSAGE="🚀 *Nuevo Despliegue Iniciado*
            
            📦 *Proyecto:* ${GITHUB_REPOSITORY}
            🔄 *Branch:* ${GITHUB_REF#refs/heads/}
            🏷️ *Version:* ${version}
            🔨 *Commit:* \`${commit_sha}\`
            ⏰ *Inicio:* $(date +"%Y-%m-%d %H:%M:%S")
            👨‍💻 *Autor:* ${GITHUB_ACTOR}
            
            📝 *Etapas Completadas:*
            ✅ Code Quality Check
            ✅ Unit Tests
            ✅ Security Audit
            ✅ SonarCloud Analysis
            
            🔗 *Commit:* ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}
            
            ⚡️ *Estado:* Deployment en progreso..."
            ;;
            
        "success")
            MESSAGE="✅ *Despliegue Exitoso*
            
            📦 *Proyecto:* ${GITHUB_REPOSITORY}
            🔄 *Branch:* ${GITHUB_REF#refs/heads/}
            🏷️ *Version:* ${version}
            🔨 *Commit:* \`${commit_sha}\`
            ⏰ *Fin:* $(date +"%Y-%m-%d %H:%M:%S")
            👨‍💻 *Autor:* ${GITHUB_ACTOR}
            
            📝 *Detalles:*
            🐳 *Imagen:* \`${REGISTRY}/${REPOSITORY}:${version}\`
            📅 *Build Date:* ${build_date}
            
            🔗 *Commit:* ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}
            
            🎉 *Estado:* ¡Deployment completado con éxito!"
            ;;
            
        "failure")
            MESSAGE="❌ *Despliegue Fallido*
            
            📦 *Proyecto:* ${GITHUB_REPOSITORY}
            🔄 *Branch:* ${GITHUB_REF#refs/heads/}
            🏷️ *Version:* ${version}
            🔨 *Commit:* \`${commit_sha}\`
            👨‍💻 *Autor:* ${GITHUB_ACTOR}
            
            ⚠️ *Posibles causas:*
            - Fallos en las pruebas unitarias
            - Problemas de seguridad detectados
            - Error en el build de Docker
            - Error en el despliegue a Kubernetes
            
            🔗 *Commit:* ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}
            
            🚨 *Estado:* El deployment ha fallado
            
            Por favor, revisa los logs para más detalles."
            ;;
    esac

    curl -s -X POST ${BOT_URL} \
        -d chat_id=${TELEGRAM_CHAT_ID} \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
}