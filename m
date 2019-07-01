Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19BC2F838
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfE3IEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:04:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:04:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U841l62901451
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:04:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U841l62901451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203442;
        bh=ZsyCYOwVVwRN8mj+XE51ybfLC6iuurvyY9gof8DOK9A=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=D7RvpqWt1jRq6HQd8CSN1KP62sR5Arl8joER7y+UnOH8Kkx259KxUObbdTHm5+px0
         IRTXxddVYRlT4byXsStdY0dftWHKsgEJKt3OoTJ2IgLBhgyGZ+Kr31AZ4BlPaEis9q
         di/kRS6KkRoDbEKPKERbkwdT11D+w6NUbj+OJtlTviygV602mCbtJgTp4mRhI0Ebae
         T8//EgD9YOSIDqNCEhi6yjw7sIyWMq0xdVITLPatH+68W+VsVbCdUfyKHLpU+tg1Ie
         ZOHEiUapWcTkbi0HVQGVPtaDRST1u61DfZCdYZ8SXrK/VwWrktdGrZEd66dlg2Pc19
         uRs7E+fr+qhzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U841Gj2901435;
        Thu, 30 May 2019 01:04:01 -0700
Date:   Thu, 30 May 2019 01:04:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-w71uge0sfo6ns9uclhwtthca@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, lclaudio@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adrian.hunter@intel.com, jolsa@kernel.org,
        brendan.d.gregg@gmail.com
Reply-To: adrian.hunter@intel.com, brendan.d.gregg@gmail.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, viro@zeniv.linux.org.uk,
          lclaudio@redhat.com, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify 'fsmount' arguments
Git-Commit-ID: f6af095668b7799a7514378824dcc74869df3994
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f6af095668b7799a7514378824dcc74869df3994
Gitweb:     https://git.kernel.org/tip/f6af095668b7799a7514378824dcc74869df3994
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 16:34:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf trace: Beautify 'fsmount' arguments

Use existing beautifiers for the first arg, fd, assigned using the
heuristic that looks for syscall arg names and associates SCA_FD with
'fd' named argumes, and wire up the recently introduced fsmount
attr_flags table generator.

Now it should be possible to just use:

   perf trace -e fsmount

As root and see all fsmount syscalls with its args beautified.

  # cat sys_fsmount.c
  #define _GNU_SOURCE        /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */

  #define __NR_fsmount 432

  #define MOUNT_ATTR_RDONLY	 0x00000001 /* Mount read-only */
  #define MOUNT_ATTR_NOSUID	 0x00000002 /* Ignore suid and sgid bits */
  #define MOUNT_ATTR_NODEV	 0x00000004 /* Disallow access to device special files */
  #define MOUNT_ATTR_NOEXEC	 0x00000008 /* Disallow program execution */
  #define MOUNT_ATTR__ATIME	 0x00000070 /* Setting on how atime should be updated */
  #define MOUNT_ATTR_RELATIME	 0x00000000 /* - Update atime relative to mtime/ctime. */
  #define MOUNT_ATTR_NOATIME	 0x00000010 /* - Do not update access times. */
  #define MOUNT_ATTR_STRICTATIME 0x00000020 /* - Always perform atime updates */
  #define MOUNT_ATTR_NODIRATIME	 0x00000080 /* Do not update directory access times */

  static inline int sys_fsmount(int fs_fd, int flags, int attr_flags)
  {
  	syscall(__NR_fsmount, fs_fd, flags, attr_flags);
  }

  int main(int argc, char *argv[])
  {
  	int attr_flags = 0, fs_fd = 0;

  	sys_fsmount(fs_fd++, 0, attr_flags);
  	attr_flags |= MOUNT_ATTR_RDONLY;
  	sys_fsmount(fs_fd++, 1, attr_flags);
  	attr_flags |= MOUNT_ATTR_NOSUID;
  	sys_fsmount(fs_fd++, 0, attr_flags);
  	attr_flags |= MOUNT_ATTR_NODEV;
  	sys_fsmount(fs_fd++, 1, attr_flags);
  	attr_flags |= MOUNT_ATTR_NOEXEC;
  	sys_fsmount(fs_fd++, 0, attr_flags);
  	attr_flags |= MOUNT_ATTR_NOATIME;
  	sys_fsmount(fs_fd++, 1, attr_flags);
  	attr_flags |= MOUNT_ATTR_STRICTATIME;
  	sys_fsmount(fs_fd++, 0, attr_flags);
  	attr_flags |= MOUNT_ATTR_NODIRATIME;
  	sys_fsmount(fs_fd++, 0, attr_flags);
  	return 0;
  }
  #
  # perf trace -e fsmount ./sys_fsmount
  fsmount(0, 0, MOUNT_ATTR_RELATIME)      = -1 EINVAL (Invalid argument)
  fsmount(1, FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY|MOUNT_ATTR_RELATIME) = -1 EINVAL (Invalid argument)
  fsmount(2, 0, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_RELATIME) = -1 EINVAL (Invalid argument)
  fsmount(3, FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV|MOUNT_ATTR_RELATIME) = -1 EBADF (Bad file descriptor)
  fsmount(4, 0, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV|MOUNT_ATTR_NOEXEC|MOUNT_ATTR_RELATIME) = -1 EBADF (Bad file descriptor)
  fsmount(5, FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV|MOUNT_ATTR_NOEXEC|MOUNT_ATTR_NOATIME) = -1 EBADF (Bad file descriptor)
  fsmount(6, 0, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV|MOUNT_ATTR_NOEXEC|MOUNT_ATTR_NOATIME|MOUNT_ATTR_STRICTATIME) = -1 EINVAL (Invalid argument)
  fsmount(7, 0, MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV|MOUNT_ATTR_NOEXEC|MOUNT_ATTR_NOATIME|MOUNT_ATTR_STRICTATIME|MOUNT_ATTR_NODIRATIME) = -1 EINVAL (Invalid argument)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w71uge0sfo6ns9uclhwtthca@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf          |  8 ++++++++
 tools/perf/builtin-trace.c        | 12 ++++++++++++
 tools/perf/trace/beauty/Build     |  1 +
 tools/perf/trace/beauty/beauty.h  |  3 +++
 tools/perf/trace/beauty/fsmount.c | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 22e92a9ee871..326ca5d6a7ef 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -419,6 +419,12 @@ fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
 $(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
 	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
 
+fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
+fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
+
+$(fsmount_arrays): $(linux_uapi_dir)/fs.h $(fsmount_tbls)
+	$(Q)$(SHELL) '$(fsmount_tbls)' $(linux_uapi_dir) > $@
+
 fspick_arrays := $(beauty_outdir)/fspick_arrays.c
 fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 
@@ -647,6 +653,7 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(fadvise_advice_array) \
 	$(fsconfig_arrays) \
+	$(fsmount_arrays) \
 	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
@@ -944,6 +951,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
+		$(OUTPUT)$(fsmount_arrays) \
 		$(OUTPUT)$(fspick_arrays) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 16bb8c04c689..3a2ab68a8b85 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -487,6 +487,11 @@ static const char *bpf_cmd[] = {
 };
 static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
+static const char *fsmount_flags[] = {
+	[1] = "CLOEXEC",
+};
+static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
+
 #include "trace/beauty/generated/fsconfig_arrays.c"
 
 static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
@@ -651,6 +656,10 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .parm	= &strarray__##array, }
 
+#define STRARRAY_FLAGS(name, array) \
+	  { .scnprintf	= SCA_STRARRAY_FLAGS, \
+	    .parm	= &strarray__##array, }
+
 #include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
@@ -724,6 +733,9 @@ static struct syscall_fmt {
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
 	{ .name     = "fsconfig",
 	  .arg = { [1] = STRARRAY(cmd, fsconfig_cmds), }, },
+	{ .name     = "fsmount",
+	  .arg = { [1] = STRARRAY_FLAGS(flags, fsmount_flags),
+		   [2] = { .scnprintf = SCA_FSMOUNT_ATTR_FLAGS, /* attr_flags */ }, }, },
 	{ .name     = "fspick",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
 		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index c2d38b2b606b..338c61b8ed22 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,6 +1,7 @@
 perf-y += clone.o
 perf-y += fcntl.o
 perf-y += flock.o
+perf-y += fsmount.o
 perf-y += fspick.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 perf-y += ioctl.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index ad874e0beba5..9385d1cb121a 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -144,6 +144,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FLOCK syscall_arg__scnprintf_flock
 
+size_t syscall_arg__scnprintf_fsmount_attr_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FSMOUNT_ATTR_FLAGS syscall_arg__scnprintf_fsmount_attr_flags
+
 size_t syscall_arg__scnprintf_fspick_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FSPICK_FLAGS syscall_arg__scnprintf_fspick_flags
 
diff --git a/tools/perf/trace/beauty/fsmount.c b/tools/perf/trace/beauty/fsmount.c
new file mode 100644
index 000000000000..30c8c082a3c3
--- /dev/null
+++ b/tools/perf/trace/beauty/fsmount.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/fsmount.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+#include <uapi/linux/mount.h>
+
+static size_t fsmount__scnprintf_attr_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/fsmount_arrays.c"
+       static DEFINE_STRARRAY(fsmount_attr_flags, "MOUNT_ATTR_");
+       size_t printed = 0;
+
+       if ((flags & ~MOUNT_ATTR__ATIME) != 0)
+	       printed += strarray__scnprintf_flags(&strarray__fsmount_attr_flags, bf, size, show_prefix, flags);
+
+       if ((flags & MOUNT_ATTR__ATIME) == MOUNT_ATTR_RELATIME) {
+	       printed += scnprintf(bf + printed, size - printed, "%s%s%s",
+			            printed ? "|" : "", show_prefix ? "MOUNT_ATTR_" : "", "RELATIME");
+       }
+
+       return printed;
+}
+
+size_t syscall_arg__scnprintf_fsmount_attr_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return fsmount__scnprintf_attr_flags(flags, bf, size, arg->show_string_prefix);
+}
