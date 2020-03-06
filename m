Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8917C60F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 20:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCFTMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 14:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgCFTM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:28 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895ED20656;
        Fri,  6 Mar 2020 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521947;
        bh=BY9+Zp5BXszJew6adZ55ehy4GPcyXxYtYJnWnwXUF9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiVKVwGfeYtXWGxSCP/FaWD2P2La28FmT1UmDnZWmv+JfwKBJOgcjfbfECiN5ebZk
         5vM7pDrZ1x0wAD1ohMXrCb1jsQ9e6Pm9W07u9J/krAynUYU8jNV9Ssv3qP+Bo75GC3
         mR4emeCputNnsxM2yuITNB/BjeNM71Na7AGtwEJE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 5/5] perf symbols: Don't try to find a vmlinux file when looking for kernel modules
Date:   Fri,  6 Mar 2020 16:11:43 -0300
Message-Id: <20200306191144.12762-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The dso->kernel value is now set to everything that is in
machine->kmaps, but that was being used to decide if vmlinux lookup is
needed, which ended up making that lookup be made for kernel modules,
that now have dso->kernel set, leading to these kinds of warnings when
running on a machine with compressed kernel modules, like fedora:31:

  [root@five ~]# perf record -F 10000 -a sleep 2
  [ perf record: Woken up 1 times to write data ]
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  [ perf record: Captured and wrote 1.024 MB perf.data (1366 samples) ]
  [root@five ~]#

This happens when collecting the buildid, when we find samples for
kernel modules, fix it by checking if the looked up DSO is a kernel
module by other means.

Fixes: 02213cec64bb ("perf maps: Mark module DSOs with kernel type")
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200302191007.GD10335@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1077013d8ce2..26bc6a0096ce 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1622,7 +1622,12 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (dso->kernel) {
+	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+
+	if (dso->kernel && !kmod) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
@@ -1650,12 +1655,6 @@ int dso__load(struct dso *dso, struct map *map)
 	if (!name)
 		goto out;
 
-	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
-
-
 	/*
 	 * Read the build id if possible. This is required for
 	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
-- 
2.21.1

