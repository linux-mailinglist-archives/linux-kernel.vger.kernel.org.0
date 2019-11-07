Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8217F37D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfKGTC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfKGTC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:02:57 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8157F21D6C;
        Thu,  7 Nov 2019 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153376;
        bh=XIcDjKwPZAi4BJmV1+5q/4+5JS1244q3K8I1KxoFbNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKPf6mw9H00FQnw6nsVICiY0PiycZCX6uhA5I07bbQQRmam7tZ6YzynUsFrkmQ97S
         WUqXY4iagMCHcod0xsz2Jy1172njYLsBE0wWzzF7b3AUy652UtVQML47SiIGk/P6Rm
         1sYvJq/buEskL4+6WgievXRmAaQlTMy9ZHsyFoLk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/63] perf probe: Fix to show function entry line as probe-able
Date:   Thu,  7 Nov 2019 15:59:25 -0300
Message-Id: <20191107190011.23924-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix die_walk_lines() to list the function entry line correctly.  Since
the dwarf_entrypc() does not return the entry pc if the DIE has only
range attribute, __die_walk_funclines() fails to list the declaration
line (entry line) in that case.

To solve this issue, this introduces die_entrypc() which correctly
returns the entry PC (the first address range) even if the DIE has only
range attribute. With this fix die_walk_lines() shows the function entry
line is able to probe correctly.

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157190837419.1859.4619125803596816752.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 24 +++++++++++++++++++++++-
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 929b7c0567f4..063f71da6b63 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -307,6 +307,28 @@ bool die_is_func_def(Dwarf_Die *dw_die)
 		dwarf_attr(dw_die, DW_AT_declaration, &attr) == NULL);
 }
 
+/**
+ * die_entrypc - Returns entry PC (the lowest address) of a DIE
+ * @dw_die: a DIE
+ * @addr: where to store entry PC
+ *
+ * Since dwarf_entrypc() does not return entry PC if the DIE has only address
+ * range, we have to use this to retrieve the lowest address from the address
+ * range attribute.
+ */
+int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
+{
+	Dwarf_Addr base, end;
+
+	if (!addr)
+		return -EINVAL;
+
+	if (dwarf_entrypc(dw_die, addr) == 0)
+		return 0;
+
+	return dwarf_ranges(dw_die, 0, &base, addr, &end) < 0 ? -ENOENT : 0;
+}
+
 /**
  * die_is_func_instance - Ensure that this DIE is an instance of a subprogram
  * @dw_die: a DIE
@@ -713,7 +735,7 @@ static int __die_walk_funclines(Dwarf_Die *sp_die, bool recursive,
 	/* Handle function declaration line */
 	fname = dwarf_decl_file(sp_die);
 	if (fname && dwarf_decl_line(sp_die, &lineno) == 0 &&
-	    dwarf_entrypc(sp_die, &addr) == 0) {
+	    die_entrypc(sp_die, &addr) == 0) {
 		lw.retval = callback(fname, lineno, addr, data);
 		if (lw.retval != 0)
 			goto done;
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f204e5892403..506006e0cf66 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -29,6 +29,9 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 /* Get DW_AT_linkage_name (should be NULL for C binary) */
 const char *die_get_linkage_name(Dwarf_Die *dw_die);
 
+/* Get the lowest PC in DIE (including range list) */
+int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr);
+
 /* Ensure that this DIE is a subprogram and definition (not declaration) */
 bool die_is_func_def(Dwarf_Die *dw_die);
 
-- 
2.21.0

