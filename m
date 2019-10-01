Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46DC3348
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfJALrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:47:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:47:46 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFGd6-00077f-4c; Tue, 01 Oct 2019 11:47:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/2] sched: add kernel-doc for struct clone_args
Date:   Tue,  1 Oct 2019 13:47:02 +0200
Message-Id: <20191001114701.24661-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001114701.24661-1-christian.brauner@ubuntu.com>
References: <20191001114701.24661-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc for struct clone_args for the clone3() syscall.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/uapi/linux/sched.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 851ff1feadd5..3d8f03bfd428 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -34,8 +34,30 @@
 #define CLONE_IO		0x80000000	/* Clone io context */
 
 #ifndef __ASSEMBLY__
-/*
- * Arguments for the clone3 syscall
+/**
+ * struct clone_args - arguments for the clone3 syscall
+ * @flags:       Flags for the new process as listed above.
+ *               All flags are valid except for CSIGNAL and
+ *               CLONE_DETACHED.
+ * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
+ *               returned in this argument.
+ * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
+ *               child process will be returned in the child's
+ *               memory.
+ * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
+ *               the child process will be returned in the
+ *               parent's memory.
+ * @exit_signal: The exit_signal the parent process will be
+ *               sent when the child exits.
+ * @stack:       Specify the location of the stack for the
+ *               child process.
+ * @stack_size:  The size of the stack for the child process.
+ * @tls:         If CLONE_SETTLS is set, the tls descriptor
+ *               is set to tls.
+ *
+ * The structure is versioned by size and thus extensible.
+ * New struct members must go at the end of the struct and
+ * must be properly 64bit aligned.
  */
 struct clone_args {
 	__aligned_u64 flags;
-- 
2.23.0

