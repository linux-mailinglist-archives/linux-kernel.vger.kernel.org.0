Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2582F828
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfE3H7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:59:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3H7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:59:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7wgvg2900493
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:58:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7wgvg2900493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203123;
        bh=lhMKLoKgMl1JRhJ4YzrI4R04glUs+KMP/TBUQE23cSI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=UcmVRwDR/t2eGVnmv5n6kUiKSPbiopblkPei5b4apkQ1qQZX5a3+QTuNn+RjCwEvN
         leuQM70Al+5+T1QSmu9a8xE+hQ8bvA4kfIiUgQUFIS54N6UK6eqqkSLuboXWspSKHj
         M/UalIgjHVF/RcN3F3+DPyeGEHDz69ll6IcTvhSwOGipUKYZgLZZonumvKKNM+GPXY
         DMkhZbtszLoRoIEsibBmbHs0d+GRymTqPEGFoF1Hot6pbtZ818Ns0CQDErwB5ky2V6
         lD+hT3E695UZZD5IfxW32u+Ry+qkLi8rXqcdZzIRlj9MBG+RYuAjv/xM6Tv9cdLtzx
         KPk3zRKrHXQZw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7wgc32900486;
        Thu, 30 May 2019 00:58:42 -0700
Date:   Thu, 30 May 2019 00:58:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-83rim8g4k0s4gieieh5nnlck@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        acme@redhat.com, dhowells@redhat.com, brendan.d.gregg@gmail.com,
        jolsa@kernel.org, viro@zeniv.linux.org.uk, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
          dhowells@redhat.com, acme@redhat.com, jolsa@kernel.org,
          viro@zeniv.linux.org.uk, brendan.d.gregg@gmail.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify 'move_mount' arguments
Git-Commit-ID: 566e30229e1f4be67c4771afc057152d62016c9c
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

Commit-ID:  566e30229e1f4be67c4771afc057152d62016c9c
Gitweb:     https://git.kernel.org/tip/566e30229e1f4be67c4771afc057152d62016c9c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 14:58:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf trace: Beautify 'move_mount' arguments

Use existing beautifiers for the first 4 args (to/from fds, pathnames)
and wire up the recently introduced move_mount flags table generator.

Now it should be possible to just use:

      perf trace -e move_mount

As root and see all move_mount syscalls with its args beautified, except
for the filenames, that need work in the augmented_raw_syscalls.c eBPF
helper to pass more than one, see comment in the
augmented_raw_syscalls.c source code, the other args should work in all
cases, i.e. all that is needed can be obtained directly from the
raw_syscalls:sys_enter tracepoint args.

Running without the strace "skin" (.perfconfig setting output formatting
switches to look like strace output + BPF to collect strings, as we
still need to support collecting multiple string args for the same
syscall, like with move_mount):

  # cat sys_move_mount.c
  #define _GNU_SOURCE         /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */

  #define __NR_move_mount 429

  #define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
  #define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
  #define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
  #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
  #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
  #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */

  static inline int sys_move_mount(int from_fd, const char *from_pathname,
  				 int to_fd, const char *to_pathname,
  				 int flags)
  {
  	  syscall(__NR_move_mount, from_fd, from_pathname, to_fd, to_pathname, flags);
  }

  int main(int argc, char *argv[])
  {
  	  int flags = 0, from_fd = 0, to_fd = 100;

  	  sys_move_mount(from_fd++, "/foo", to_fd++, "bar", flags);
  	  flags |= MOVE_MOUNT_F_SYMLINKS;
  	  sys_move_mount(from_fd++, "/foo1", to_fd++, "bar1", flags);
          flags |= MOVE_MOUNT_F_AUTOMOUNTS;
  	  sys_move_mount(from_fd++, "/foo2", to_fd++, "bar2", flags);
          flags |= MOVE_MOUNT_F_EMPTY_PATH;
  	  sys_move_mount(from_fd++, "/foo3", to_fd++, "bar3", flags);
          flags |= MOVE_MOUNT_T_SYMLINKS;
  	  sys_move_mount(from_fd++, "/foo4", to_fd++, "bar4", flags);
          flags |= MOVE_MOUNT_T_AUTOMOUNTS;
  	  sys_move_mount(from_fd++, "/foo5", to_fd++, "bar5", flags);
          flags |= MOVE_MOUNT_T_EMPTY_PATH;
  	  return sys_move_mount(from_fd++, "/foo6", to_fd++, "bar6", flags);
  }
  # mv ~/.perfconfig  ~/.perfconfig.OFF
  # perf trace -e move_mount ./sys_move_mount
       0.000 ( 0.009 ms): sys_move_mount/28971 move_mount(from_pathname: 0x402010, to_dfd: 100, to_pathname: 0x402015) = -1 ENOENT (No such file or directory)
       0.011 ( 0.003 ms): sys_move_mount/28971 move_mount(from_dfd: 1, from_pathname: 0x40201e, to_dfd: 101, to_pathname: 0x402019, flags: F_SYMLINKS) = -1 ENOENT (No such file or directory)
       0.016 ( 0.002 ms): sys_move_mount/28971 move_mount(from_dfd: 2, from_pathname: 0x402029, to_dfd: 102, to_pathname: 0x402024, flags: F_SYMLINKS|F_AUTOMOUNTS) = -1 ENOENT (No such file or directory)
       0.020 ( 0.002 ms): sys_move_mount/28971 move_mount(from_dfd: 3, from_pathname: 0x402034, to_dfd: 103, to_pathname: 0x40202f, flags: F_SYMLINKS|F_AUTOMOUNTS|F_EMPTY_PATH) = -1 ENOENT (No such file or directory)
       0.023 ( 0.002 ms): sys_move_mount/28971 move_mount(from_dfd: 4, from_pathname: 0x40203f, to_dfd: 104, to_pathname: 0x40203a, flags: F_SYMLINKS|F_AUTOMOUNTS|F_EMPTY_PATH|T_SYMLINKS) = -1 ENOENT (No such file or directory)
       0.027 ( 0.002 ms): sys_move_mount/28971 move_mount(from_dfd: 5, from_pathname: 0x40204a, to_dfd: 105, to_pathname: 0x402045, flags: F_SYMLINKS|F_AUTOMOUNTS|F_EMPTY_PATH|T_SYMLINKS|T_AUTOMOUNTS) = -1 ENOENT (No such file or directory)
       0.031 ( 0.017 ms): sys_move_mount/28971 move_mount(from_dfd: 6, from_pathname: 0x402055, to_dfd: 106, to_pathname: 0x402050, flags: F_SYMLINKS|F_AUTOMOUNTS|F_EMPTY_PATH|T_SYMLINKS|T_AUTOMOUNTS|T_EMPTY_PATH) = -1 ENOENT (No such file or directory)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-83rim8g4k0s4gieieh5nnlck@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                         |  8 ++++++++
 tools/perf/builtin-trace.c                       |  6 ++++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 11 +++++++++++
 tools/perf/trace/beauty/Build                    |  1 +
 tools/perf/trace/beauty/beauty.h                 |  3 +++
 tools/perf/trace/beauty/move_mount.c             | 24 ++++++++++++++++++++++++
 6 files changed, 53 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c706548d5b10..20448d8cc162 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -493,6 +493,12 @@ mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
 $(mount_flags_array): $(linux_uapi_dir)/fs.h $(mount_flags_tbl)
 	$(Q)$(SHELL) '$(mount_flags_tbl)' $(linux_uapi_dir) > $@
 
+move_mount_flags_array := $(beauty_outdir)/move_mount_flags_array.c
+move_mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/move_mount_flags.sh
+
+$(move_mount_flags_array): $(linux_uapi_dir)/fs.h $(move_mount_flags_tbl)
+	$(Q)$(SHELL) '$(move_mount_flags_tbl)' $(linux_uapi_dir) > $@
+
 prctl_option_array := $(beauty_outdir)/prctl_option_array.c
 prctl_hdr_dir := $(srctree)/tools/include/uapi/linux/
 prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
@@ -638,6 +644,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(madvise_behavior_array) \
 	$(mmap_flags_array) \
 	$(mount_flags_array) \
+	$(move_mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
 	$(usbdevfs_ioctl_array) \
@@ -925,6 +932,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
+		$(OUTPUT)$(move_mount_flags_array) \
 		$(OUTPUT)$(drm_ioctl_array) \
 		$(OUTPUT)$(pkey_alloc_access_rights_array) \
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f5b3a1e9c1dd..b76c950e4393 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -775,6 +775,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
 		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
 			   .mask_val  = SCAMV_MOUNT_FLAGS, /* flags */ }, }, },
+	{ .name	    = "move_mount",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* from_dfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME, /* from_pathname */ },
+		   [2] = { .scnprintf = SCA_FDAT,	/* to_dfd */ },
+		   [3] = { .scnprintf = SCA_FILENAME, /* to_pathname */ },
+		   [4] = { .scnprintf = SCA_MOVE_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index b292e763f3c7..8d0c0976696e 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -117,6 +117,7 @@ struct augmented_filename {
 #define SYS_RENAMEAT2          316
 #define SYS_EXECVEAT           322
 #define SYS_STATX              332
+#define SYS_MOVE_MOUNT         429
 
 pid_filter(pids_filtered);
 
@@ -257,6 +258,16 @@ int sys_enter(struct syscall_enter_args *args)
 	case SYS_LINKAT:
 	case SYS_MKDIRAT:
 	case SYS_MKNODAT:
+	// case SYS_MOVE_MOUNT:
+	// For now don't copy move_mount first string arg, as it has two and
+	// 'perf trace's syscall_arg__scnprintf_filename() will use the one
+	// copied here, the first, for both args, duplicating the first and
+	// ignoring the second.
+	//
+	// We need to copy both here and make syscall_arg__scnprintf_filename
+	// skip the first when reading the second, using the size of the first, etc.
+	// Shouldn't be difficult, but now its perf/urgent time, lets wait for
+	// the next devel window.
 	case SYS_MQ_TIMEDSEND:
 	case SYS_NAME_TO_HANDLE_AT:
 	case SYS_NEWFSTATAT:
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 85f328ddf897..d84812c094ba 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -6,6 +6,7 @@ perf-y += ioctl.o
 endif
 perf-y += kcmp.o
 perf-y += mount_flags.o
+perf-y += move_mount.o
 perf-y += pkey_alloc.o
 perf-y += arch_prctl.o
 perf-y += prctl.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 139d485a6f16..dfb84032d8eb 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -156,6 +156,9 @@ unsigned long syscall_arg__mask_val_mount_flags(struct syscall_arg *arg, unsigne
 size_t syscall_arg__scnprintf_mount_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_MOUNT_FLAGS syscall_arg__scnprintf_mount_flags
 
+size_t syscall_arg__scnprintf_move_mount_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MOVE_MOUNT_FLAGS syscall_arg__scnprintf_move_mount_flags
+
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PKEY_ALLOC_ACCESS_RIGHTS syscall_arg__scnprintf_pkey_alloc_access_rights
 
diff --git a/tools/perf/trace/beauty/move_mount.c b/tools/perf/trace/beauty/move_mount.c
new file mode 100644
index 000000000000..78ed80395406
--- /dev/null
+++ b/tools/perf/trace/beauty/move_mount.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/move_mount.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+
+static size_t move_mount__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/move_mount_flags_array.c"
+       static DEFINE_STRARRAY(move_mount_flags, "MOVE_MOUNT_");
+
+       return strarray__scnprintf_flags(&strarray__move_mount_flags, bf, size, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_move_mount_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return move_mount__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
