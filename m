Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA52A7CA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfGaRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:31:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40915 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfGaRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so32253317pfp.7;
        Wed, 31 Jul 2019 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+sTc8dGavXtiikWaqtiaNPd8S2TK4bk6dd25zLrAH8=;
        b=gksKLwTKLggIYe6QFOSAS3Qy/8+ZVZZ56mvMhQEiDxlzKqoTPU0XSW82evO0JJYElE
         rIVwhNfHGMHCgAhjfcFnS9krklB9vMX1dQOLiiw6EajEBYAvGgvtMYTcnSKQjEp3eaRS
         Mi6R/wqTYsY8XGWuMj4iwZWqheIGWIeaJdbf5yBGmU36BBAe05LPP8lpuKuMgQocRWOg
         auAWH1WVjA9BBbNE1geHTL1ZAcuU4gSThW6zNQivMhaWnZTaIMbJPR6GTvD4pRztZKZO
         DZs/in0WGeq73itpaxrOkJSWloj8Afc1E9Ib0PYKLQ9Nfm16Y2QPDrhC8pcfJJhcsawF
         Dbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+sTc8dGavXtiikWaqtiaNPd8S2TK4bk6dd25zLrAH8=;
        b=AfpQMlEDFdN1U4jB/tb1H0738L/XQfbRiJNGvPdAIiRn0VaWifznOBjvR7LTfUdmu3
         bUmYtPAcPD2qqot6Yv72yVlI0lS4bw1TYtMhMYQCeNYGMPBFuKF/ZK03HqCPm67EEKM1
         oE0wqs4rz5WBySRJt8apd2RGFtPzZqY67qZ/Eh1sV4pcVZ4wYDJnB5rhxQgS50tqdX6v
         ZPJj3VMYsKrl8scUPVHI58+R0PrnrudGM+sz2353ZkKWMQArOZhR/DaNFFYSI73G2VNP
         uGNKNDEaUZd8iKb8darEX1+K7J2WVjQdwlwbH3GBh/Wxs0gJnf1dcQ0+ocQcnmDfMvlH
         vhOQ==
X-Gm-Message-State: APjAAAWFidCxJzOplvOfv0YhCMQocdvhhTXkls2Fd3yKkLhtMFpDkjlA
        jp/kLlZRlyHcyImEa/1lOi/o0/axn+8=
X-Google-Smtp-Source: APXvYqwrKdYOAJsyD954TQ1hnihsZ7LKrKC7m/Y7iWnpHVNp0qUyjlkdkJAtZmpAbfsb85KVO6tqbA==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr4050102pjs.119.1564594287954;
        Wed, 31 Jul 2019 10:31:27 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:27 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/23] tty: serial: fsl_lpuart: Drop unnecessary extra parenthesis
Date:   Wed, 31 Jul 2019 10:30:32 -0700
Message-Id: <20190731173045.11718-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary extra parenthesis in the driver.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b3cc44548b34..79922f179b08 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1443,7 +1443,7 @@ static int lpuart_startup(struct uart_port *port)
 	lpuart_setup_watermark(sport);
 
 	temp = readb(sport->port.membase + UARTCR2);
-	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
 	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
@@ -1651,7 +1651,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 
@@ -1662,7 +1662,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS7)
 		termios->c_cflag |= PARENB;
 
-	if ((termios->c_cflag & PARENB)) {
+	if (termios->c_cflag & PARENB) {
 		if (termios->c_cflag & CMSPAR) {
 			cr1 &= ~UARTCR1_PE;
 			if (termios->c_cflag & PARODD)
@@ -1701,7 +1701,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSR1_FE | UARTSR1_PE);
+		sport->port.read_status_mask |= UARTSR1_FE | UARTSR1_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSR1_FE;
 
@@ -1815,7 +1815,7 @@ lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
 		tmp |= UARTBAUD_BOTHEDGE;
 
 	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= (((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT);
+	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
 	tmp &= ~UARTBAUD_SBR_MASK;
 	tmp |= sbr & UARTBAUD_SBR_MASK;
@@ -1868,7 +1868,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	if (termios->c_cflag & CRTSCTS) {
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	} else {
 		termios->c_cflag &= ~CRTSCTS;
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
@@ -1917,7 +1917,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSTAT_FE | UARTSTAT_PE);
+		sport->port.read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSTAT_FE;
 
@@ -2084,7 +2084,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr2 = old_cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= (UARTCR2_TE |  UARTCR2_RE);
+	cr2 |= UARTCR2_TE | UARTCR2_RE;
 	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
@@ -2115,7 +2115,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr = old_cr = lpuart32_read(&sport->port, UARTCTRL);
-	cr |= (UARTCTRL_TE |  UARTCTRL_RE);
+	cr |= UARTCTRL_TE | UARTCTRL_RE;
 	cr &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(&sport->port, cr, UARTCTRL);
 
@@ -2572,7 +2572,7 @@ static int lpuart_resume(struct device *dev)
 	} else {
 		lpuart_setup_watermark(sport);
 		temp = readb(sport->port.membase + UARTCR2);
-		temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
-- 
2.21.0

