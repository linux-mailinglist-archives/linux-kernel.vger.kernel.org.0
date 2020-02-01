Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C366014F72D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 09:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBAIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 03:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAIEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:04:00 -0500
Received: from quaco.parlament.guest (catv-212-96-54-169.catv.broadband.hu [212.96.54.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DE620723;
        Sat,  1 Feb 2020 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580544239;
        bh=W/755d3QcV+q1eeioser7DkTzTXRCmheRXblZS4m5+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVB+HJffzOA7CSJS5srxwnoih81Pss1Gjr+vuIbZK03JNn43TqDDrmjWEr9Dxfwyl
         IbCkGVx+o2Yv7toNP1yJ0ENvDtqcIGRvBEH4GM9qK/juElYj7yEquj9aRiE2FdIrcU
         sCd4BDtNRhth0a+/c8Gwv0/AqeppqCuRdvZ/G+Uk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/6] perf probe: Add ustring support for perf probe command
Date:   Sat,  1 Feb 2020 09:03:29 +0100
Message-Id: <20200201080330.13211-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Kernel commit 88903c464321 ("tracing/probe: Add ustring type for user-space string")
adds support for user-space strings when type 'ustring' is specified.

Here is an example using sysfs command line interface
for kprobes:

Function to probe:
  struct filename *
  getname_flags(const char __user *filename, int flags, int *empty)

Setup:
  # cd /sys/kernel/debug/tracing/
  # echo 'p:tmr1 getname_flags +0(%r2):ustring' > kprobe_events
  # cat events/kprobes/tmr1/format | fgrep print
  print fmt: "(%lx) arg1=\"%s\"", REC->__probe_ip, REC->arg1
  # echo 1 > events/kprobes/tmr1/enable
  # touch /tmp/111
  # echo 0 > events/kprobes/tmr1/enable
  # cat trace|fgrep /tmp/111
  touch-5846  [005] d..2 255520.717960: tmr1:\
	  (getname_flags+0x0/0x400) arg1="/tmp/111"

Doing the same with the perf tool fails.
Using type 'string' succeeds:
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:string)
   ....
 # perf probe -d probe:vfs_getname
 Removed event: probe:vfs_getname

However using type 'ustring' fails (output before):
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Failed to write event: Invalid argument
   Error: Failed to add events.
 #

Fix this by adding type 'ustring' in function
convert_variable_type().

Using ustring succeeds (output after):
 # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:ustring)

 You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

 #

Note: This issue also exists on x86, it is not s390 specific.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: sumanthk@linux.ibm.com
Link: http://lore.kernel.org/lkml/20200120132011.64698-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c470c49a804f..1c817add6ca4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -303,7 +303,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	char prefix;
 
 	/* TODO: check all types */
-	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "x") != 0 &&
+	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "ustring") &&
+	    strcmp(cast, "x") != 0 &&
 	    strcmp(cast, "s") != 0 && strcmp(cast, "u") != 0) {
 		/* Non string type is OK */
 		/* and respect signedness/hexadecimal cast */
-- 
2.21.1

