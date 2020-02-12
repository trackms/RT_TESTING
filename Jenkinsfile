@Library("shared-libraries")
import io.libs.Utils


def utils = new Utils()

pipeline {

    parameters {
        string(defaultValue: "${env.jenkinsAgent}", description: 'Нода дженкинса, на которой запускать пайплайн. По умолчанию master', name: 'jenkinsAgent')
        string(defaultValue: "${env.server1c}", description: 'Имя сервера 1с, по умолчанию localhost', name: 'server1c')
        string(defaultValue: "${env.server1cPort}", description: 'Порт рабочего сервера 1с. По умолчанию 1540. Не путать с портом агента кластера (1541)', name: 'server1cPort')
        string(defaultValue: "${env.agent1cPort}", description: 'Порт агента кластера 1с. По умолчанию 1541', name: 'agent1cPort')
        string(defaultValue: "${env.platform1c}", description: 'Версия платформы 1с, например 8.3.12.1685. По умолчанию будет использована последня версия среди установленных', name: 'platform1c')
        string(defaultValue: "${env.admin1cUser}", description: 'Имя администратора с правом открытия вншних обработок (!) для базы тестирования 1с Должен быть одинаковым для всех баз', name: 'admin1cUser')
        string(defaultValue: "${env.admin1cPwd}", description: 'Пароль администратора базы тестирования 1C. Должен быть одинаковым для всех баз', name: 'admin1cPwd')
        string(defaultValue: "${env.templatebases}", description: 'Список баз для тестирования через запятую. Например work_erp,work_upp', name: 'templatebases')
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
        // stage("Тестирование ADD") {
        //     steps {
        //         timestamps {
        //             script {
        //                 templatebasesList = utils.lineToArray(templatebases.toLowerCase())

        //                 if (templatebasesList.size() == 0) {
        //                     return
        //                 }
                        
        //                 templateDb = templatebasesList[0]
        //                 testbase = "${templateDb}"
        //                 testbaseConnString = utils.getConnString(server1c, testbase, agent1cPort)

        //                 platform1cLine = ""
        //                 if (platform1c != null && !platform1c.isEmpty()) {
        //                     platform1cLine = "--v8version ${platform1c}"
        //                 }

        //                 admin1cUsrLine = ""
        //                 if (admin1cUser != null && !admin1cUser.isEmpty()) {
        //                     admin1cUsrLine = "--db-user ${admin1cUser}"
        //                 }

        //                 admin1cPwdLine = ""
        //                 if (admin1cPwd != null && !admin1cPwd.isEmpty()) {
        //                     admin1cPwdLine = "--db-pwd ${admin1cPwd}"
        //                 }
        //                 // Запускаем ADD тестирование на произвольной базе, сохранившейся в переменной testbaseConnString
        //                 returnCode = utils.cmd("runner vanessa --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathvanessa tools/add/bddRunner.epf")

        //                 if (returnCode != 0) {
        //                     //utils.raiseError("Возникла ошибка при запуске ADD на сервере ${server1c} и базе ${testbase}")
        //                     utils.raiseError("runner vanessa --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathvanessa tools/add/bddRunner.epf")
        //                 }
        //             }
        //         }
        //     }
        // }
        stage("Дымовое тестирование") {
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

                        //utils.raiseError("runner xunit tests --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathxunit tools/add/xddTestRunner.epf --TestClient ${admin1cUsr}:${admin1cPwd}:1538")    

                        // Запускаем ADD тестирование на произвольной базе, сохранившейся в переменной testbaseConnString
                        //returnCode = utils.cmd("runner xunit tests --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathxunit tools/add/xddTestRunner.epf")

                        //if (returnCode != 0) {
                            //utils.raiseError("Возникла ошибка при запуске XUNIT на сервере ${server1c} и базе ${testbase}")
                        //    utils.raiseError("runner xunit tests --settings tools/vrunner.json ${platform1cLine} --ibconnection \"${testbaseConnString}\" ${admin1cUsrLine} ${admin1cPwdLine} --pathxunit tools/add/xddTestRunner.epf")
                        //}
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