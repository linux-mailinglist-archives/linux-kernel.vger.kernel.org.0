Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAF855C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbfHGW1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 18:27:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:13 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOW-0007mg-H9; Thu, 08 Aug 2019 00:26:57 +0200
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
Subject: [RFC PATCH v4 3/9] printk-rb: fix missing includes/exports
Date:   Thu,  8 Aug 2019 00:32:28 +0206
Message-Id: <20190807222634.1723-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing includes and exports.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/dataring.c   | 1 +
 kernel/printk/numlist.c    | 1 +
 kernel/printk/ringbuffer.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index 911bac593ec1..6642e085a05d 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include "dataring.h"
 
 /**
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
index df3f89e7f7fd..d5e224dafc0c 100644
--- a/kernel/printk/numlist.c
+++ b/kernel/printk/numlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include <linux/sched.h>
 #include "numlist.h"
 
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index 59bf59aba3de..b9fc13597b10 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include <linux/irqflags.h>
 #include <linux/string.h>
 #include <linux/err.h>
@@ -222,6 +223,7 @@ struct nl_node *prb_desc_node(unsigned long id, void *arg)
 
 	return &d->list;
 }
+EXPORT_SYMBOL(prb_desc_node);
 
 /**
  * prb_desc_busy() - Numbered list callback to report if a node is busy.
@@ -262,6 +264,7 @@ bool prb_desc_busy(unsigned long id, void *arg)
 	/* hC: */
 	return (id == atomic_long_read(&d->id));
 }
+EXPORT_SYMBOL(prb_desc_busy);
 
 /**
  * prb_getdesc() - Data ringbuffer callback to lookup a descriptor from an ID.
@@ -296,6 +299,7 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg)
 	/* iB: */
 	return &d->desc;
 }
+EXPORT_SYMBOL(prb_getdesc);
 
 /**
  * assign_desc() - Assign a descriptor to the caller.
-- 
2.20.1

