Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19273DEE14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfJUNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbfJUNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18851214AE;
        Mon, 21 Oct 2019 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665308;
        bh=o06HwTIBoANFbVnW10saHBtWOwJxyH/I6FhT63Nzevk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OF4Z43iZ+ehYi0kDTG6whz3XYa4FSvUVCsB4siu08/qnPmWlyH/icXcTdnqCDbSNB
         384OkVD7KPZZfqNpzgnaDmJswC4IvMQ4B1oycyq0sbN5Txwct2+R3FGURe7tsV4xkO
         79+dIBZcD9GZ1zPma/1jqib9e+hKqHWyBljgCeP0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 57/57] perf trace: Use STUL_STRARRAY_FLAGS with mmap
Date:   Mon, 21 Oct 2019 10:38:34 -0300
Message-Id: <20191021133834.25998-58-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'mmap' syscall has special needs so it doesn't use
SCA_STRARRAY_FLAGS, see its implementation in
syscall_arg__scnprintf_mmap_flags(), related to special handling of
MAP_ANONYMOUS, so set ->parm to the strarray__mmap_flags and hook up
with strarray__strtoul_flags manually, now we can filter by those or-ed
string expressions:

  # perf trace -e syscalls:sys_enter_mmap sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 134346, prot: READ, flags: PRIVATE, fd: 3, off: 0)
     0.026 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
     0.036 syscalls:sys_enter_mmap(addr: NULL, len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3, off: 0)
     0.046 syscalls:sys_enter_mmap(addr: 0x7fae003d9000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.052 syscalls:sys_enter_mmap(addr: 0x7fae00526000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.055 syscalls:sys_enter_mmap(addr: 0x7fae00573000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
     0.062 syscalls:sys_enter_mmap(addr: 0x7fae00579000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS)
     0.253 syscalls:sys_enter_mmap(addr: NULL, len: 217750512, prot: READ, flags: PRIVATE, fd: 3, off: 0)
  #

  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: 0x7f6ab3dcb000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.010 syscalls:sys_enter_mmap(addr: 0x7f6ab3f18000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.014 syscalls:sys_enter_mmap(addr: 0x7f6ab3f65000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
  #

  # perf trace -v -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1 |& grep "New filter"
  New filter for syscalls:sys_enter_mmap: flags==0x22
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-czw754b7m9rp9ibq2f6be2o1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7bb84c4a8f29..43c05eae1768 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1015,7 +1015,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */
+			   .strtoul   = STUL_STRARRAY_FLAGS,
+			   .parm      = &strarray__mmap_flags, },
 		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
-- 
2.21.0

