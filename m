Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4904EE4621
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436812AbfJYIrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408325AbfJYIrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:47:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A7821D7B;
        Fri, 25 Oct 2019 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993233;
        bh=039HuaFgcdGT65Y6FWPIC8uOq0spz2Q7eWMRchOOfPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbQPyi/hluNPR0aOxEgL6H+rBFTtk94aHiaqS1B5VaB+7TDmu9i+Do4uVGlmFFekt
         9X+Bp+pMdZ0P0z5SE53nBG/KQojohc2qDKKj8MZloAd1dlKCERUKqHEJc78Q0AOXRE
         gfEg2owzK0aJaA9gmL7LPgYGaiacvIdrG+oCcwNU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 6/6] perf/probe: Fix to show ranges of variables in functions without entry_pc
Date:   Fri, 25 Oct 2019 17:47:10 +0900
Message-Id: <157199323018.8075.8179744380479673672.stgit@devnote2>
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

Fix to show ranges of variables (--range and --vars option) in
functions which DIE has only ranges but no entry_pc attribute.

Without this fix,
  # tools/perf/perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
  	@<clear_tasks_mm_cpumask+0>
  		(No matched variables)

With this fix,
  # tools/perf/perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
	@<clear_tasks_mm_cpumask+0>
		[VAL]	int	cpu	@<clear_tasks_mm_cpumask+[0-35,317-317,2052-2059]>

Fixes: 349e8d261131 ("perf probe: Add --range option to show a variable's location range")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index e0c507d6b3b4..ac82fd937e4b 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1019,7 +1019,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1082,7 +1082,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 

