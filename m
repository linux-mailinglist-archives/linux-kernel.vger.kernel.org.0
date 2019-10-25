Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2CFE4619
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408508AbfJYIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408483AbfJYIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39F621D71;
        Fri, 25 Oct 2019 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993197;
        bh=NaSIMsvr5bN7V9GDcs0rLIhE7/ss27EKQwvF38aiT2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcdcbnyt5ZmeP10NBAMrbl3M+yBZ0Sybma//I4vpU/30D4UevXL8J8ONPoEj0wFUJ
         54HHy9ESmxrP4nk3IXrs4KHFyRz+Oe2L6VZ8ep4AGcnuaKKORQK5RzhS9JczACB8sf
         lGUWmN574wJ2p/2y+3kFR5vqWyOJkk5nMwJ7vAuA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 2/6] perf/probe: Fix to probe a function which has no entry pc
Date:   Fri, 25 Oct 2019 17:46:34 +0900
Message-Id: <157199319438.8075.4695576954550638618.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157199317547.8075.1010940983970397945.stgit@devnote2>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix perf probe to probe a function which has no entry pc or
low pc but only has ranges attribute.

probe_point_search_cb() uses dwarf_entrypc() to get the
probe address, but that doesn't work for the function DIE
which has only ranges attribute. Use die_entrypc() instead.

Without this fix,
  # tools/perf/perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.

With this,
  # tools/perf/perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2b6513e5725c..71633f55f045 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -982,7 +982,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
-		dwarf_entrypc(sp_die, &pf->addr);
+		die_entrypc(sp_die, &pf->addr);
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",

