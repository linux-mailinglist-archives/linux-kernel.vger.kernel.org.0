Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D211103B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfLCRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:37:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:37:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1icC7V-00056u-PJ; Tue, 03 Dec 2019 18:37:53 +0100
Date:   Tue, 3 Dec 2019 18:37:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT] printk: hack out emergency loglevel usage
Message-ID: <20191203173753.lz2rkumwq632kfms@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

Instead of using an emergency loglevel to determine if atomic
messages should be printed, use oops_in_progress. This conforms
to the decision that latency-causing atomic messages never be
generated during normal operation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/printk/printk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9d9523431178b..2b4616fd4fd4b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1767,15 +1767,8 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 			con->wrote_history = 1;
 			con->printk_seq = seq - 1;
 		}
-		if (con->write_atomic && level < emergency_console_loglevel &&
-		    facility == 0) {
-			/* skip emergency messages, already printed */
-			if (con->printk_seq < seq)
-				con->printk_seq = seq;
-			continue;
-		}
 		if (con->flags & CON_BOOT && facility == 0) {
-			/* skip emergency messages, already printed */
+			/* skip boot messages, already printed */
 			if (con->printk_seq < seq)
 				con->printk_seq = seq;
 			continue;
@@ -3161,7 +3154,7 @@ static bool console_can_emergency(int level)
 	for_each_console(con) {
 		if (!(con->flags & CON_ENABLED))
 			continue;
-		if (con->write_atomic && level < emergency_console_loglevel)
+		if (con->write_atomic && oops_in_progress)
 			return true;
 		if (con->write && (con->flags & CON_BOOT))
 			return true;
@@ -3177,7 +3170,7 @@ static void call_emergency_console_drivers(int level, const char *text,
 	for_each_console(con) {
 		if (!(con->flags & CON_ENABLED))
 			continue;
-		if (con->write_atomic && level < emergency_console_loglevel) {
+		if (con->write_atomic && oops_in_progress) {
 			con->write_atomic(con, text, text_len);
 			continue;
 		}
-- 
2.24.0

