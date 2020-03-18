Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A158A189DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCRO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 10:27:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37356 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgCRO1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZen-0004YX-Ay; Wed, 18 Mar 2020 15:26:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/7] serial: 8250: Make em485_rts_after_send() set mctrl according to rts state.
Date:   Wed, 18 Mar 2020 15:26:34 +0100
Message-Id: <20200318142640.982763-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

When rs485 enabled and RTS_AFTER_SEND set on startup, need to preserve
mctrl status, because later functions will call set_mctrl passing
port->mctrl=0 overriding rts status, resulting in rts pin in
transmission when idle.

Make mctrl reflect rts pin state.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8407166610ce..67aa3a2a9afa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -565,10 +565,13 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
 		mcr |= UART_MCR_RTS;
-	else
+		p->port.mctrl |= TIOCM_RTS;
+	} else {
 		mcr &= ~UART_MCR_RTS;
+		p->port.mctrl &= ~TIOCM_RTS;
+	}
 	serial8250_out_MCR(p, mcr);
 }
 
-- 
2.24.1

