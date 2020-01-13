Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D513896F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 03:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgAMCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 21:09:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732676AbgAMCJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:09:14 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34C6269FA4BC4A197AD5;
        Mon, 13 Jan 2020 10:09:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 10:09:02 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH RESEND 4/4] tty/serial: 8250_exar: use true,false for bool variable
Date:   Mon, 13 Jan 2020 10:16:17 +0800
Message-ID: <1578881777-65475-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
References: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/tty/serial/8250/8250_exar.c:189:6-17: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/8250/8250_exar.c:197:3-14: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/8250/8250_exar.c:199:3-14: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 108cd55..91e9b07 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -186,7 +186,7 @@ static int xr17v35x_startup(struct uart_port *port)
 static void exar_shutdown(struct uart_port *port)
 {
 	unsigned char lsr;
-	bool tx_complete = 0;
+	bool tx_complete = false;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct circ_buf *xmit = &port->state->xmit;
 	int i = 0;
@@ -194,9 +194,9 @@ static void exar_shutdown(struct uart_port *port)
 	do {
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-			tx_complete = 1;
+			tx_complete = true;
 		else
-			tx_complete = 0;
+			tx_complete = false;
 		usleep_range(1000, 1100);
 	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);

--
2.7.4

