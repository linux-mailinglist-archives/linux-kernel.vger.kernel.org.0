Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EDACE708
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfJGPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:14:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfJGPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:14:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHUio-00078t-71; Mon, 07 Oct 2019 17:14:50 +0200
Date:   Mon, 7 Oct 2019 17:14:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT] printk: handle iterating while buffer changing
Message-ID: <20191007151450.pox2wys5zlzzmhke@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

The syslog and kmsg_dump readers are provided buffers to fill.
Both try to maximize the provided buffer usage by calculating the
maximum number of messages that can fit. However, if after the
calculation, messages are dropped and new messages added, the
calculation will no longer match.

For syslog, add a check to make sure the provided buffer is not
overfilled.

For kmsg_dump, start over by recalculating the messages
available.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This reassembles the behaviour that commit
   c9dccacfccc72 ("printk: Do not lose last line in kmsg buffer dump")

did for the "old" printk code.

 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 58c545a528b3b..9d9523431178b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1436,6 +1436,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
+		if (len + textlen > size)
+			break;
+
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
@@ -3075,7 +3078,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		ret = prb_iter_next(&iter, msgbuf, PRINTK_RECORD_MAX, &seq);
 		if (ret == 0) {
 			break;
-		} else if (ret < 0) {
+		} else if (ret < 0 || seq >= end_seq) {
 			prb_iter_init(&iter, &printk_rb, &seq);
 			goto retry;
 		}
-- 
2.23.0

