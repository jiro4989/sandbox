const Log4js = require("log4js");
Log4js.configure("log-config.json");
const syslog = Log4js.getLogger("system");
const errlog = Log4js.getLogger("error");

syslog.info("info");
syslog.info("hogehoge");
errlog.info("info");

syslog.error("error");
errlog.error("error");
