Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1057CA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfGaRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:32:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32882 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbfGaRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so944525pgn.0;
        Wed, 31 Jul 2019 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHCaBoLQ/yEzfjkL6qf+EG0j5RyMmpKI4hNpa2fZRjM=;
        b=jwPcVakH0loQdnIvLgvlBrPNezeyb+fXZ2qcVlNfH9cgRcH08+8YAC8t8IACDi2Yjj
         ELgvJwZR+Q9kn66LvX+Jha8cIVUIngD2p1dFqRvey6Clfg6OjWI6Geb28+Q0Wq9K1v3m
         /3gsjRxUrX6knT+HhNvY0thYRGWSHu+hRT++9FbEWQtnPCH6TcY+b19Sl6j4hrS8ZiOw
         4ey/VJod75a4igyfJ/G7QBKDUQyVmjQvf5Zwoum6PzvcYXaNwOJHX2ylES4qA7r4i6x1
         uis02o8KsoHaf/ncYFVoI5SugUTXINYJ41XxU5jfAvfEjgzLA2HY9lZFzg/r1gmQN6Lm
         KYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHCaBoLQ/yEzfjkL6qf+EG0j5RyMmpKI4hNpa2fZRjM=;
        b=OAWTa4dZ3PRa60AbAp4gEgR7+ZrFVJzgICPVHugHgcs/WmgI9vC8Do0vZZyF+foFXI
         3WDMm3GMUfO6tbpp816IkpGlUHcBeqw16Dxkg4h+7I7+mp4tRraKBSW9ERJUiEXLqhWr
         9pO73I3sPA8wCXorJwYFns+/1IRdgET+k/S0/eTIaqcBaKN3wZ1QFSGdVBMdij3gJ+SX
         mUgLvPMWV6sS7Nr3kg4I04PyIYsVIVD4pmFFLpFixIFWITgFvqrP77gyWhJXaCMMk5PR
         eVGVAR0iqzjkK7PJE1N5pIy5tqgPLEmfElYWZvLx331AKLE/3MnEeH46A58yv40MwLdR
         nuew==
X-Gm-Message-State: APjAAAUN8BZ1gNJ0LiUVYIjNRz1g1y/GT0Qg2ChfKbK4RFKGju4+HBJS
        a+JBFqRx3U7Qtf8jSjK7f2g6vAZWazc=
X-Google-Smtp-Source: APXvYqz1tS2++AtZggozZDiqrf02IEYPnCcjpEcblaxZ+rsOeQlPyB4sYX4fCco/UKnTPX9DCWta+A==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr102563678pgn.200.1564594298777;
        Wed, 31 Jul 2019 10:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:38 -0700 (PDT)
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
Subject: [PATCH v2 15/23] tty: serial: fsl_lpuart: Introduce lpuart_stopped_or_empty()
Date:   Wed, 31 Jul 2019 10:30:37 -0700
Message-Id: <20190731173045.11718-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for

    uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)

appears in multiple places in the driver. Move it into a helper
function.

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
 drivers/tty/serial/fsl_lpuart.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 58043e01a242..e59dd90fc34c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -452,6 +452,11 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	dma_async_issue_pending(sport->dma_tx_chan);
 }
 
+static bool lpuart_stopped_or_empty(struct uart_port *port)
+{
+	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
+}
+
 static void lpuart_dma_tx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
@@ -479,7 +484,7 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+	if (!lpuart_stopped_or_empty(&sport->port))
 		lpuart_dma_tx(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -680,7 +685,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart_stop_tx(&sport->port);
 		return;
 	}
@@ -711,7 +716,7 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart32_stop_tx(&sport->port);
 		return;
 	}
@@ -739,14 +744,13 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned char temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
@@ -757,11 +761,10 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long temp;
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		temp = lpuart32_read(port, UARTCTRL);
-- 
2.21.0

