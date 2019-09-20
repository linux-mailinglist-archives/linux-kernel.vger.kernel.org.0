Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD77B951E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393043AbfITQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 12:20:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387644AbfITQU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49A1918C892A;
        Fri, 20 Sep 2019 16:20:28 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD5CD5D6B0;
        Fri, 20 Sep 2019 16:20:25 +0000 (UTC)
Date:   Fri, 20 Sep 2019 18:20:03 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi, posix-timers: provide clockid-related macros and
 functions to UAPI
Message-ID: <20190920162003.GA31301@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 20 Sep 2019 16:20:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now, there is no interface exposed for converting pid/fd into
clockid and vice versa; linuxptp, for example, has been carrying these
definitions in missing.h header for quite some time[1].

[1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/linux/posix-timers.h | 47 +-------------------------------------------
 include/uapi/linux/time.h    | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 3d10c84..ddc7e6e6 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,58 +4,13 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/time.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
 
-/*
- * Bit fields within a clockid:
- *
- * The most significant 29 bits hold either a pid or a file descriptor.
- *
- * Bit 2 indicates whether a cpu clock refers to a thread or a process.
- *
- * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
- *
- * A clockid is invalid if bits 2, 1, and 0 are all set.
- */
-#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
-#define CPUCLOCK_PERTHREAD(clock) \
-	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
-
-#define CPUCLOCK_PERTHREAD_MASK	4
-#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
-#define CPUCLOCK_CLOCK_MASK	3
-#define CPUCLOCK_PROF		0
-#define CPUCLOCK_VIRT		1
-#define CPUCLOCK_SCHED		2
-#define CPUCLOCK_MAX		3
-#define CLOCKFD			CPUCLOCK_MAX
-#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
-
-static inline clockid_t make_process_cpuclock(const unsigned int pid,
-		const clockid_t clock)
-{
-	return ((~pid) << 3) | clock;
-}
-static inline clockid_t make_thread_cpuclock(const unsigned int tid,
-		const clockid_t clock)
-{
-	return make_process_cpuclock(tid, clock | CPUCLOCK_PERTHREAD_MASK);
-}
-
-static inline clockid_t fd_to_clockid(const int fd)
-{
-	return make_process_cpuclock((unsigned int) fd, CLOCKFD);
-}
-
-static inline int clockid_to_fd(const clockid_t clk)
-{
-	return ~(clk >> 3);
-}
-
 #ifdef CONFIG_POSIX_TIMERS
 
 /**
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 958932e..41a004c 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,4 +70,51 @@ struct itimerval {
  */
 #define TIMER_ABSTIME			0x01
 
+/*
+ * Bit fields within a clockid:
+ *
+ * The most significant 29 bits hold either a pid or a file descriptor.
+ *
+ * Bit 2 indicates whether a cpu clock refers to a thread or a process.
+ *
+ * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
+ *
+ * A clockid is invalid if bits 2, 1, and 0 are all set.
+ */
+#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
+#define CPUCLOCK_PERTHREAD(clock) \
+	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PROF		0
+#define CPUCLOCK_VIRT		1
+#define CPUCLOCK_SCHED		2
+#define CPUCLOCK_MAX		3
+#define CLOCKFD			CPUCLOCK_MAX
+#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
+
+static inline clockid_t make_process_cpuclock(const unsigned int pid,
+		const clockid_t clock)
+{
+	return ((~pid) << 3) | clock;
+}
+static inline clockid_t make_thread_cpuclock(const unsigned int tid,
+		const clockid_t clock)
+{
+	return make_process_cpuclock(tid, clock | CPUCLOCK_PERTHREAD_MASK);
+}
+
+static inline clockid_t fd_to_clockid(const int fd)
+{
+	return make_process_cpuclock((unsigned int) fd, CLOCKFD);
+}
+
+static inline int clockid_to_fd(const clockid_t clk)
+{
+	return ~(clk >> 3);
+}
+
+
 #endif /* _UAPI_LINUX_TIME_H */
-- 
2.1.4

