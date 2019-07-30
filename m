Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E417B100
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfG3R6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:58:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbfG3R6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:58:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHwdHe3321570
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:58:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHwdHe3321570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509520;
        bh=WU7YxVwxjUGuodwCCcTuiKST8w/G4JsOD6C3emgUUQw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=THIxhZDM9GYlpq3S4/2CcfYifNCdwEkKjtlJaRHof+zZ/AVOouunFRHpNSXrFUWRM
         wuNBL4WafP8luiRaz0LRK5LBDxSGB/km03PGxsuaphAtaJGJz7Cn4ynxq/Qh3EbRZY
         QjELuyZ2ADoJlWchED2Pt0hj3KvJatTV8kVzp5lkpsrqU29/R+Jc/MO74pcWBK2wLK
         Llllfh4TM92vOzynqs2078k3DERaZ8xH3RJGUMo6TisMspfjG4rR417ji+WppPoV8q
         WTaJDkNzkhntDzkFb96cob/4cPlOcOuinfUrYFRmGWpi0TT+gYHnkK1n/LzvTNPJp0
         CjKO9+RLMIPdw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHwcRo3321562;
        Tue, 30 Jul 2019 10:58:38 -0700
Date:   Tue, 30 Jul 2019 10:58:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5xkrbcpjsgnr3zt1aqdd7nvc@git.kernel.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        lclaudio@redhat.com, mingo@kernel.org, namhyung@kernel.org
Reply-To: acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          lclaudio@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Augment sockaddr arg
 in 'connect'
Git-Commit-ID: 212b9ab6775b5f340de848b5b6eef6968ccf7f20
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  212b9ab6775b5f340de848b5b6eef6968ccf7f20
Gitweb:     https://git.kernel.org/tip/212b9ab6775b5f340de848b5b6eef6968ccf7f20
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 16:28:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf augmented_raw_syscalls: Augment sockaddr arg in 'connect'

We already had a beautifier for an augmented sockaddr payload, but that
was when we were hooking on each syscalls:sys_enter_foo tracepoints,
since now we're almost doing that by doing a tail call from
raw_syscalls:sys_enter, its almost the same, we can reuse it straight
away.

  # perf trace -e connec* ssh www.bla.com
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(4<socket:[16604782]>, { .family: PF_LOCAL, path: /var/lib/sss/pipes/nss }, 0x6e) = 0
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_INET, port: 53, addr: 192.168.44.1 }, 0x10) = 0
  connect(5</etc/hosts>, { .family: PF_INET, port: 22, addr: 146.112.61.108 }, 0x10) = 0
  connect(5</etc/hosts>, { .family: PF_INET6, port: 22, addr: ::ffff:146.112.61.108 }, 0x1c) = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5xkrbcpjsgnr3zt1aqdd7nvc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 35 ++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 77bb6a0edce3..d7a292d7ee2f 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -16,6 +16,7 @@
 
 #include <unistd.h>
 #include <linux/limits.h>
+#include <linux/socket.h>
 #include <pid_filter.h>
 
 /* bpf-output associated map */
@@ -69,10 +70,13 @@ pid_filter(pids_filtered);
 
 struct augmented_args_payload {
        struct syscall_enter_args args;
-       struct {
-	       struct augmented_filename filename;
-	       struct augmented_filename filename2;
-       };
+       union {
+		struct {
+			struct augmented_filename filename,
+						  filename2;
+		};
+		struct sockaddr_storage saddr;
+	};
 };
 
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
@@ -112,11 +116,32 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 }
 
 /*
- * This will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
+ * These will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
  * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
+SEC("!syscalls:sys_enter_connect")
+int sys_enter_connect(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *sockaddr_arg = (const void *)args->args[1];
+	unsigned int socklen = args->args[2];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	if (socklen > sizeof(augmented_args->saddr))
+		socklen = sizeof(augmented_args->saddr);
+
+	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+}
+
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
