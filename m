Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4494FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 23:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfHSVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 17:30:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49491 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfHSVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:30:11 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hzpDw-0004ki-IF; Mon, 19 Aug 2019 23:29:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] printk-rb: fix test module macro usage
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-7-john.ogness@linutronix.de>
Date:   Mon, 19 Aug 2019 23:29:54 +0200
In-Reply-To: <20190807222634.1723-7-john.ogness@linutronix.de> (John Ogness's
        message of "Thu, 8 Aug 2019 00:32:31 +0206")
Message-ID: <87blwkvo6l.fsf_-_@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DECLARE_PRINTKRB() now requires a wait queue argument, used
by the blocking reader interface.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 For RFCv4 the macro prototype changed. The fixup for the
 test module didn't make it into the series.

 kernel/printk/test_prb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/test_prb.c b/kernel/printk/test_prb.c
index 0157bbdf051f..49bcf831af7e 100644
--- a/kernel/printk/test_prb.c
+++ b/kernel/printk/test_prb.c
@@ -6,8 +6,11 @@
 #include <linux/delay.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
 #include "ringbuffer.h"
 
+DECLARE_WAIT_QUEUE_HEAD(test_wait);
+
 /*
  * This is a test module that starts "num_online_cpus() - 1" writer threads
  * and 1 reader thread. The writer threads each write strings of varying
@@ -63,7 +66,7 @@ static void dump_rb(struct printk_ringbuffer *rb)
 	trace_printk("END full dump\n");
 }
 
-DECLARE_PRINTKRB(test_rb, 5, 7);
+DECLARE_PRINTKRB(test_rb, 5, 7, &test_wait);
 
 static int prbtest_writer(void *data)
 {
-- 
2.20.1
