Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA0A493E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfIAMZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfIAMZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5D72342E;
        Sun,  1 Sep 2019 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340738;
        bh=NJHLU7RbjHiyI5fjQ6QTYYw2CB63Gn343ICPy1E1uHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q79gTpp8xw0ly2rxtTj7TDamW/xQhb+V7dGXMuPPPCUpcf1hnIOhsYbNOatpLNAed
         6NU5rSUbNBu6AsLY6rVfI/PinAjcwGZQmcDgiebaljSxXo+ou4mopGzv0vF9sA66bB
         A54ps2xuvGC54cFqM3OusLQT8gU0zfCdR6v6eBfc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/47] perf: Update .gitignore file
Date:   Sun,  1 Sep 2019 09:23:21 -0300
Message-Id: <20190901122326.5793-43-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

After a "make tools/perf", git reports the following untracked files:

  tools/perf/feature/
  tools/perf/fixdep
  tools/perf/libtraceevent-dynamic-list

Add these generated files to perf's .gitignore file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/03acbc6c2fbc72054861f6c301875db75db33030.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3e5135dded16..bf1252dc2cb0 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -34,3 +34,6 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
+feature/
+fixdep
+libtraceevent-dynamic-list
-- 
2.21.0

