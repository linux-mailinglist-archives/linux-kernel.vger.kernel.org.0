Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99822A89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 05:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfETDx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 23:53:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41790 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfETDx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:53:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so6036772plt.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBNcU7dtCYU00dN9icFSaU4lVFSngUnu9jAK5Jk7lkE=;
        b=YQSNJCcKM7WviKLmz7cKDDQ551lYaqh3ka6GsuFVnMdhbAJcv5YeKKfABVLz6AGuTW
         lFwJDX545/UN4fmoPbQeKDAZHe7/rEVNOLkNgOXnk53Csp4rl3Oqoo0kakKoxaazkCvK
         VE3q0cT/ObPibPKiSEqZT2szzLJ0aonUfjZNoXz0b8B6u5vrQ9WKCNKjliUntgNQCH1m
         Zo3b+x+OCfxBYocbwx2ZWCMM9CR6/OqkPVpXyc4meEXyXm8MM3GplEZqHq/yOb81G/8y
         LBK0MmgHyiXKvDiNOpYqZgcuTxYGuGePMZ2bth3KXF8BznuDHuYyyQT7YwG2mvugxbqV
         P8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tBNcU7dtCYU00dN9icFSaU4lVFSngUnu9jAK5Jk7lkE=;
        b=k8QPvVveolUDiSU8Le2WQzLNhd4pD2O7asab1n8VkepiNI7yWRVawk/wxr7FJKb/zl
         Gz6P2d0xJsoib8RMOoUz80BfblB0uQzqG+xj3af9rfriLdw1Os+r6/LTUa7VmosHbvDn
         joKHD9es2wQ0iHiRaMDyjG3P1tdwClEiD86GWiCTWCx92hny8vzHzz08AG0m24Um25K8
         X5tJjotfeMsKNfQXAuuH1MwQBXAHt2jET3wY6lLHhrAVX+e2Z2L2SSJwShagrlA0JXEY
         Smlzhem8lePPoYB+d4Obv2bp/GKAu+7sv13Kidb/PQrGbAY7MNiqm9TZT+PcADrs4NV1
         11oQ==
X-Gm-Message-State: APjAAAVGrDXNTxiXAE5rQrstkeRTDBPXVmOBiLDyypQhDFRc1MfWmEsv
        0jHT6emHsJnYpDsCjoIrwew=
X-Google-Smtp-Source: APXvYqz0+fnAnbc+xIx6Hyu1xzjAmscoSixfuxLRBCh1WPSoZBvSNF0PxhRQ0cIpCPfHKg1QdL/lIA==
X-Received: by 2002:a17:902:b490:: with SMTP id y16mr44075401plr.161.1558324406751;
        Sun, 19 May 2019 20:53:26 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x66sm3312779pfx.139.2019.05.19.20.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 20:53:25 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 5/7] mm: introduce external memory hinting API
Date:   Mon, 20 May 2019 12:52:52 +0900
Message-Id: <20190520035254.57579-6-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some usecase that centralized userspace daemon want to give
a memory hint like MADV_[COOL|COLD] to other process. Android's
ActivityManagerService is one of them.

It's similar in spirit to madvise(MADV_WONTNEED), but the information
required to make the reclaim decision is not known to the app. Instead,
it is known to the centralized userspace daemon(ActivityManagerService),
and that daemon must be able to initiate reclaim on its own without
any app involvement.

To solve the issue, this patch introduces new syscall process_madvise(2)
which works based on pidfd so it could give a hint to the exeternal
process.

int process_madvise(int pidfd, void *addr, size_t length, int advise);

All advises madvise provides can be supported in process_madvise, too.
Since it could affect other process's address range, only privileged
process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
gives it the right to ptrrace the process could use it successfully.

Please suggest better idea if you have other idea about the permission.

* from v1r1
  * use ptrace capability - surenb, dancol

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/proc_fs.h                |  1 +
 include/linux/syscalls.h               |  2 ++
 include/uapi/asm-generic/unistd.h      |  2 ++
 kernel/signal.c                        |  2 +-
 kernel/sys_ni.c                        |  1 +
 mm/madvise.c                           | 45 ++++++++++++++++++++++++++
 8 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..5b9dd55d6b57 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	process_madvise		sys_process_madvise		__ia32_sys_process_madvise
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..0e5ee78161c9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	process_madvise		__x64_sys_process_madvise
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 52a283ba0465..f8545d7c5218 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -122,6 +122,7 @@ static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
 
 #endif /* CONFIG_PROC_FS */
 
+extern struct pid *pidfd_to_pid(const struct file *file);
 struct net;
 
 static inline struct proc_dir_entry *proc_net_mkdir(
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..21c6c9a62006 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -872,6 +872,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long sys_process_madvise(int pid_fd, unsigned long start,
+				size_t len, int behavior);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..7ee82ce04620 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,6 +832,8 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_process_madvise 428
+__SYSCALL(__NR_process_madvise, sys_process_madvise)
 
 #undef __NR_syscalls
 #define __NR_syscalls 428
diff --git a/kernel/signal.c b/kernel/signal.c
index 1c86b78a7597..04e75daab1f8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3620,7 +3620,7 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
+struct pid *pidfd_to_pid(const struct file *file)
 {
 	if (file->f_op == &pidfd_fops)
 		return file->private_data;
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..5277421795ab 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -278,6 +278,7 @@ COND_SYSCALL(mlockall);
 COND_SYSCALL(munlockall);
 COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
+COND_SYSCALL(process_madvise);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL_COMPAT(mbind);
diff --git a/mm/madvise.c b/mm/madvise.c
index 119e82e1f065..af02aa17e5c1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -9,6 +9,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/page_idle.h>
+#include <linux/proc_fs.h>
 #include <linux/syscalls.h>
 #include <linux/mempolicy.h>
 #include <linux/page-isolation.h>
@@ -16,6 +17,7 @@
 #include <linux/hugetlb.h>
 #include <linux/falloc.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
@@ -1140,3 +1142,46 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return madvise_core(current, start, len_in, behavior);
 }
+
+SYSCALL_DEFINE4(process_madvise, int, pidfd, unsigned long, start,
+		size_t, len_in, int, behavior)
+{
+	int ret;
+	struct fd f;
+	struct pid *pid;
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_to_pid(f.file);
+	if (IS_ERR(pid)) {
+		ret = PTR_ERR(pid);
+		goto err;
+	}
+
+	ret = -EINVAL;
+	rcu_read_lock();
+	tsk = pid_task(pid, PIDTYPE_PID);
+	if (!tsk) {
+		rcu_read_unlock();
+		goto err;
+	}
+	get_task_struct(tsk);
+	rcu_read_unlock();
+	mm = mm_access(tsk, PTRACE_MODE_ATTACH_REALCREDS);
+	if (!mm || IS_ERR(mm)) {
+		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		if (ret == -EACCES)
+			ret = -EPERM;
+		goto err;
+	}
+	ret = madvise_core(tsk, start, len_in, behavior);
+	mmput(mm);
+	put_task_struct(tsk);
+err:
+	fdput(f);
+	return ret;
+}
-- 
2.21.0.1020.gf2820cf01a-goog

