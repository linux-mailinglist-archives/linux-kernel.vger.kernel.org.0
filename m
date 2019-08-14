Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9038D764
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfHNPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 11:46:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfHNPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:46:14 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxvTY-0005XX-TB; Wed, 14 Aug 2019 15:46:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc:     oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 1/1] waitid: Add support for waiting for the current process group
Date:   Wed, 14 Aug 2019 17:44:00 +0200
Message-Id: <20190814154400.6371-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814154400.6371-1-christian.brauner@ubuntu.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

It was recently discovered that the linux version of waitid is not a
superset of the other wait functions because it does not include
support for waiting for the current process group.  This has two
downsides.  An extra system call is needed to get the current process
group, and a signal could come in between the system call that
retrieved the process gorup and the call to waitid that changes the
current process group.

Allow userspace to avoid both of those issues by defining
idtype == P_PGID and id == 0 to mean wait for the caller's process
group at the time of the call.

Arguments can be made for using a different choice of idtype and id
for this case but the BSDs already use this P_PGID and 0 to indicate
waiting for the current process's process group.  So be nice to user
space programmers and don't introduce an unnecessary incompatibility.

Some people have noted that the posix description is that
waitpid will wait for the current process group, and that in
the presence of pthreads that process group can change.  To get
clarity on this issue I looked at XNU, FreeBSD, and Luminos.  All of
those flavors of unix waited for the current process group at the
time of call and as written could not adapt to the process group
changing after the call.

At one point Linux did adapt to the current process group changing but
that stopped in 161550d74c07 ("pid: sys_wait... fixes").  It has been
over 11 years since Linux has that behavior, no programs that fail
with the change in behavior have been reported, and I could not
find any other unix that does this.  So I think it is safe to clarify
the definition of current process group, to current process group
at the time of the wait function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Zong Li <zongbox@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: GNU C Library <libc-alpha@sourceware.org>
---
v1:
- Christian Brauner <christian.brauner@ubuntu.com>:
  - move find_get_pid() calls into the switch statements to minimize
    merge conflicts with P_PIDFD changes and adhere to coding style
    discussions we had for P_PIDFD

v2:
- Oleg Nesterov <oleg@redhat.com>:
  - take rcu_read_lock() around task_pgrp() so that we don't race with
    another thread changing the pgrp
- Christian Brauner <christian.brauner@ubuntu.com>:
  - introduce find_get_pgrp()

v3:
- Oleg Nesterov <oleg@redhat.com>:
  - use get_task_pid()
---
 kernel/exit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..8e4e357fddc8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1576,19 +1576,23 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		type = PIDTYPE_PID;
 		if (upid <= 0)
 			return -EINVAL;
+
+		pid = find_get_pid(upid);
 		break;
 	case P_PGID:
 		type = PIDTYPE_PGID;
-		if (upid <= 0)
+		if (upid < 0)
 			return -EINVAL;
+
+		if (upid)
+			pid = find_get_pid(upid);
+		else
+			pid = get_task_pid(current, PIDTYPE_PGID);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (type < PIDTYPE_MAX)
-		pid = find_get_pid(upid);
-
 	wo.wo_type	= type;
 	wo.wo_pid	= pid;
 	wo.wo_flags	= options;
-- 
2.22.0

