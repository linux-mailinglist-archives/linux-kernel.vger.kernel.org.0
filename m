Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3956BB2864
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbfIMW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 18:28:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbfIMW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:28:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id x2so4210994wmj.2;
        Fri, 13 Sep 2019 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGeuD+sEgwestY+QfSRqtVae+dkCrd0C5Kw6xlGoBtE=;
        b=kbmST97n7ifZMIxFSMVWHNUEVbHqYHj+S4/C5TXxaToLekOmg77nd9nxP2FBjEbJCW
         tpSpPyVsOtihQBylK+i5dGQE9678Qf+MZsCbg+FteZrDhF3/pYO0tmloOm1jwjZEzSMX
         GG8CtWMJvxxFTmMIDF2hB45CnruwG9pemPXeJPM97HF743BNP19/VqUijJpRLMhnvECc
         UQ6e7thbyCpJ0g44DD0l+AF7XUEncay/LUvo4m6Zagx6RiFd5kdZTFYlSXlfJLIhZYgQ
         s/Cwwf0+qcgE2lpn7BMOTV+Fpo/OcvRawFn4IjO3GT75qEDNhCAMgSNOlkAaVwujcfXF
         cx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGeuD+sEgwestY+QfSRqtVae+dkCrd0C5Kw6xlGoBtE=;
        b=I4ycINbV7vKC20qPI813/xWHYB3hSdhjDzSDzu8qUrLrinhteYxrjtMn1Fmxr91HJb
         pTSTb0aCQxF+3RRmUOyU4JC2NHDcLR27hOyGgmhBionN/CMsmpXUfxgu1kKa+JP0kD6U
         OzWwQmUvsiaxQ4SzM52Xacw1Tlfx0p888jxzBFubEYCnkJB2nTYeik1C2r1Kqyrajpxo
         NhNZRQ7R7133knxitzvfl9fKy8seuUQkhJgDqDg7G1w3bfDBUgZHZfOfcjFm81nLGuI/
         V8FPNo3rcmhG8yZA+VB0iX8fvCxnnzvh2gEmrDn8jJuTMR/oHYLX0jLhiYc+byXeMtnx
         RRrg==
X-Gm-Message-State: APjAAAVZO9xGYt2tQVFFX6Ee0P85htBVDDMQYePk9Q4FeWPPwKgbxP7L
        wZ6vBhY5GkAZuCphnWQ/+qYz2oRVbYg=
X-Google-Smtp-Source: APXvYqy8wrJ5nhJ4PwoPi14LXd7kudFuNh2fo7MKgGVQO+mgZKr7jU+djcW1+hX+Alap/nDwyR1ZDQ==
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr5084171wmb.76.1568413699029;
        Fri, 13 Sep 2019 15:28:19 -0700 (PDT)
Received: from localhost.localdomain ([109.126.151.137])
        by smtp.gmail.com with ESMTPSA id d12sm3456107wme.33.2019.09.13.15.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:28:18 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 1/2] sched/wait: Add wait_threshold
Date:   Sat, 14 Sep 2019 01:28:01 +0300
Message-Id: <a177257673556d7bc41cf9cbd25f24aceb7804d5.1568413210.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1568413210.git.asml.silence@gmail.com>
References: <cover.1568413210.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Add wait_threshold -- a custom wait_event derivative, that waits until
a value is equal to or greater than the specified threshold.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/wait_threshold.h | 64 ++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile          |  2 +-
 kernel/sched/wait_threshold.c  | 26 ++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/wait_threshold.h
 create mode 100644 kernel/sched/wait_threshold.c

diff --git a/include/linux/wait_threshold.h b/include/linux/wait_threshold.h
new file mode 100644
index 000000000000..01798c3aae1f
--- /dev/null
+++ b/include/linux/wait_threshold.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WAIT_THRESHOLD_H
+#define _LINUX_WAIT_THRESHOLD_H
+
+#include <linux/wait.h>
+
+struct wait_threshold_queue_entry {
+	struct wait_queue_entry wq_entry;
+	unsigned int threshold;
+};
+
+void init_wait_threshold_entry(struct wait_threshold_queue_entry *wtq_entry,
+				unsigned int threshold);
+
+static inline void wake_up_threshold(struct wait_queue_head *wq_head,
+					unsigned int val)
+{
+	void *arg = (void *)(unsigned long)val;
+
+	__wake_up(wq_head, TASK_NORMAL, 1, arg);
+}
+
+#define ___wait_threshold_event(q, thresh, condition, state,		\
+				exclusive, ret, cmd)			\
+({									\
+	__label__ __out;						\
+	struct wait_queue_head *__wq_head = &q;				\
+	struct wait_threshold_queue_entry __wtq_entry;			\
+	struct wait_queue_entry *__wq_entry = &__wtq_entry.wq_entry;	\
+	long __ret = ret; /* explicit shadow */				\
+									\
+	init_wait_threshold_entry(&__wtq_entry, thresh);		\
+	for (;;) {							\
+		long __int = prepare_to_wait_event(__wq_head,		\
+						   __wq_entry,		\
+						   state);		\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret = __int;					\
+			goto __out;					\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_wait(__wq_head, __wq_entry);				\
+__out:	__ret;								\
+})
+
+#define __wait_threshold_interruptible(q, thresh, condition)		\
+	___wait_threshold_event(q, thresh, condition, TASK_INTERRUPTIBLE, 0, 0,\
+			  schedule())
+
+#define wait_threshold_interruptible(q, threshold, val)		\
+({								\
+	int __ret = 0;						\
+	might_sleep();						\
+	if ((val) < (threshold))				\
+		__ret = __wait_threshold_interruptible(q,	\
+			threshold, ((val) >= (threshold)));	\
+	__ret;							\
+})
+#endif /* _LINUX_WAIT_THRESHOLD_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..bb895a3184f9 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -18,7 +18,7 @@ endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
-obj-y += wait.o wait_bit.o swait.o completion.o
+obj-y += wait.o wait_bit.o wait_threshold.o swait.o completion.o
 
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
diff --git a/kernel/sched/wait_threshold.c b/kernel/sched/wait_threshold.c
new file mode 100644
index 000000000000..80a027c02ff3
--- /dev/null
+++ b/kernel/sched/wait_threshold.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "sched.h"
+#include <linux/wait_threshold.h>
+
+static int wake_threshold_function(struct wait_queue_entry *wq_entry,
+				   unsigned int mode, int sync, void *arg)
+{
+	unsigned int val = (unsigned int)(unsigned long)arg;
+	struct wait_threshold_queue_entry *wtq_entry =
+		container_of(wq_entry, struct wait_threshold_queue_entry,
+			wq_entry);
+
+	if (val < wtq_entry->threshold)
+		return 0;
+
+	return default_wake_function(wq_entry, mode, sync, arg);
+}
+
+void init_wait_threshold_entry(struct wait_threshold_queue_entry *wtq_entry,
+			       unsigned int threshold)
+{
+	init_wait_entry(&wtq_entry->wq_entry, 0);
+	wtq_entry->wq_entry.func = wake_threshold_function;
+	wtq_entry->threshold = threshold;
+}
+EXPORT_SYMBOL(init_wait_threshold_entry);
-- 
2.22.0

