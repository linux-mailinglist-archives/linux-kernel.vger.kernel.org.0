Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E119C163F65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgBSImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:42:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:44320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBSIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00008AEAC;
        Wed, 19 Feb 2020 08:41:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/24] n_hdlc: remove spaces between function name and (
Date:   Wed, 19 Feb 2020 09:41:15 +0100
Message-Id: <20200219084118.26491-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index ee27573b0624..d52bcfa7f8e4 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -152,7 +152,7 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *list);
 
 /* Local functions */
 
-static struct n_hdlc *n_hdlc_alloc (void);
+static struct n_hdlc *n_hdlc_alloc(void);
 
 /* max frame size for memory allocations */
 static int maxframe = 4096;
@@ -222,7 +222,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
  *
  * Returns 0 if success, otherwise error code
  */
-static int n_hdlc_tty_open (struct tty_struct *tty)
+static int n_hdlc_tty_open(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
@@ -347,7 +347,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	n_hdlc_send_frames (n_hdlc, tty);
+	n_hdlc_send_frames(n_hdlc, tty);
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
@@ -406,7 +406,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	n_hdlc_buf_put(&n_hdlc->rx_buf_list, buf);
 
 	/* wake up any blocked reads and perform async signalling */
-	wake_up_interruptible (&tty->read_wait);
+	wake_up_interruptible(&tty->read_wait);
 	if (tty->fasync != NULL)
 		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
 
-- 
2.25.0

