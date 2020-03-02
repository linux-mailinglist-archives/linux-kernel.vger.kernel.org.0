Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAD1758BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 11:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCBKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 05:55:22 -0500
Received: from sym2.noone.org ([178.63.92.236]:42044 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCBKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:55:21 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48WH366PCBzvjc1; Mon,  2 Mar 2020 11:49:54 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is enabled
Date:   Mon,  2 Mar 2020 11:49:53 +0100
Message-Id: <20200302104954.2812-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pattern used with other *_show_fdinfo functions and only
define and use pty_show_fdinfo if CONFIG_PROC_FS is set.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/pty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..dceaff332ca5 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -756,10 +756,12 @@ static void pty_unix98_remove(struct tty_driver *driver, struct tty_struct *tty)
 	}
 }
 
+#ifdef CONFIG_PROC_FS
 static void pty_show_fdinfo(struct tty_struct *tty, struct seq_file *m)
 {
 	seq_printf(m, "tty-index:\t%d\n", tty->index);
 }
+#endif
 
 static const struct tty_operations ptm_unix98_ops = {
 	.lookup = ptm_unix98_lookup,
@@ -776,7 +778,9 @@ static const struct tty_operations ptm_unix98_ops = {
 	.compat_ioctl = pty_unix98_compat_ioctl,
 	.resize = pty_resize,
 	.cleanup = pty_cleanup,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo = pty_show_fdinfo,
+#endif
 };
 
 static const struct tty_operations pty_unix98_ops = {
-- 
2.25.0

