@Library("shared-libraries")
import io.libs.Utils


def utils = new Utils()

pipeline {

    parameters {
        string(defaultValue: "${env.jenkinsAgent}", description: '���� ��������, �� ���ன ����᪠�� ��������. �� 㬮�砭�� master', name: 'jenkinsAgent')
        string(defaultValue: "${env.server1c}", description: '��� �ࢥ� 1�, �� 㬮�砭�� localhost', name: 'server1c')
        string(defaultValue: "${env.server1cPort}", description: '���� ࠡ�祣� �ࢥ� 1�. �� 㬮�砭�� 1540. �� ����� � ���⮬ ����� ������ (1541)', name: 'server1cPort')
        string(defaultValue: "${env.agent1cPort}", description: '���� ����� ������ 1�. �� 㬮�砭�� 1541', name: 'agent1cPort')
        string(defaultValue: "${env.platform1c}", description: '����� ������� 1�, ���ਬ�� 8.3.12.1685. �� 㬮�砭�� �㤥� �ᯮ�짮���� ��᫥��� ����� �।� ��⠭��������', name: 'platform1c')
        string(defaultValue: "${env.admin1cUser}", description: '��� ����������� � �ࠢ�� ������ ��譨� ��ࠡ�⮪ (!) ��� ���� ���஢���� 1� ������ ���� ��������� ��� ��� ���', name: 'admin1cUser')
        string(defaultValue: "${env.admin1cPwd}", description: '��஫� ����������� ���� ���஢���� 1C. ������ ���� ��������� ��� ��� ���', name: 'admin1cPwd')
        string(defaultValue: "${env.templatebases}", description: '���᮪ ��� ��� ���஢���� �१ �������. ���ਬ�� work_erp,work_upp', name: 'templatebases')
    }

    agent {
        label "${(env.jenkinsAgent == null || env.jenkinsAgent == 'null') ? "master" : env.jenkinsAgent}"
    }
    options {
        timeout(time: 8, unit: 'HOURS') 
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    stages {
        stage("Подготовка") {
            steps {
                timestamps {
                    script {
                        templatebasesList = utils.lineToArray(templatebases.toLowerCase())
                        
                        server1c = server1c.isEmpty() ? "localhost" : server1c
                                               
                        server1cPort = server1cPort.isEmpty() ? "1540" : server1cPort
                        agent1cPort = agent1cPort.isEmpty() ? "1541" : agent1cPort
                        
                        testbase = null

                        // создаем пустые каталоги
                        dir ('build') {
                            writeFile file:'dummy', text:''
                        }
                    }
                }
            }
        }
        stage("Тестирование ADD") {
            steps {
                timestamps {
                    script {
                        templatebasesList = utils.lineToArray(templatebases.toLowerCase())

                        if (templatebasesList.size() == 0) {
                            return
                        }
                        
                        templateDb = templatebasesList[0]
                        testbase = "${templateDb}"
                        testbaseConnString = utils.getConnString(server1c, testbase, agent1cPort)

                        platform1cLine = ""
                        if (platform1c != null && !platform1c.isEmpty()) {
                            platform1cLine = "--v8version ${platform1c}"
                        }

                        admin1cUsrLine = ""
                        if (admin1cUser != null && !admin1cUser.isEmpty()) {
                            admin1cUsrLine = "--db-user ${admin1cUser}"
                        }

                        admin1cPwdLine = ""
                        if (admin1cPwd != null && !admin1cPwd.isEmpty()) {
                            admin1cPwdLine = "--db-pwd ${admin1cPwd}"
                        }
                        // Запускаем ADD тестирование на произвольной базе, сохранившейся в переменной testbaseConnString
                        returnCode = utils.cmd("runner vanessa --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathvanessa tools/add/bddRunner.epf")

                        if (returnCode != 0) {
                            utils.raiseError("Возникла ошибка при запуске ADD на сервере ${server1c} и базе ${testbase}")
                        }
                    }
                }
            }
        }
    }   
    post {
        always {
            script {
                if (currentBuild.result == "ABORTED") {
                    return
                }

                dir ('build/out/allure') {
                    writeFile file:'environment.properties', text:"Build=${env.BUILD_URL}"
                }

                allure includeProperties: false, jdk: '', results: [[path: 'build/out/allure']]
            }
        }
    }
}