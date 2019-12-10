Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918EE1186C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfLJLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:44:15 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38962 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfLJLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:44:13 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2D4C1241838;
        Tue, 10 Dec 2019 12:44:11 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 1FEE0843353; Tue, 10 Dec 2019 12:44:11 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 04/10] PCMCIA/i82092: insert blank line after declarations
Date:   Tue, 10 Dec 2019 12:43:29 +0100
Message-Id: <20191210114333.12239-5-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability of the code by inserting a blank line
after variable declarations.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 0adac6b24915..b9366adfe087 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -188,6 +188,7 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg += socket * 0x40;
 	port = sockets[socket].io_base;
@@ -203,6 +204,7 @@ static unsigned short indirect_read16(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned short tmp;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg  = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -220,6 +222,7 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -233,6 +236,7 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -250,6 +254,7 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -266,6 +271,7 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -318,6 +324,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 		for (i = 0; i < socket_count; i++) {
 			int csc;
+
 			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
 				continue;
 
@@ -363,6 +370,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 static int card_present(int socketno)
 {
 	unsigned int val;
+
 	enter("card_present");
 
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
-- 
2.20.1

