Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E472075
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfGWUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 16:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:06:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16403229EC;
        Tue, 23 Jul 2019 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912382;
        bh=BY5qLLhXbHaOpnN4vy7dPRKfNlb0SY89m8uSlsUQNac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+fvqk+RrHu2jqSMfMo2rj/7b8eMliKJbahFBKEzIn86EzXN90z8VzdLrSDA65FFe
         zl3Qb3wLp9RrM5I0apvpAqiPm5tLdbJpQFs2K+kYAM54k1eN/9btr6fW0roo4OYLxG
         HvHaO9h+xA7XUTiT2t6Npfps/qWiB4WlN7VbzvCM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 08/10] perf probe: Set pev->nargs to zero after freeing pev->args entries
Date:   Tue, 23 Jul 2019 17:05:28 -0300
Message-Id: <20190723200530.14090-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that, when perf_add_probe_events() fails, like in:

  # perf probe icmp_rcv:64 "type=icmph->type"
  Failed to find 'icmph' in this function.
    Error: Failed to add events.
  Segmentation fault (core dumped)
  #

We don't segfault.

clear_perf_probe_event() was zeroing the whole pev, and since the switch
to zfree() for the members in the pev, that memset() was removed, which
left nargs with its original value, in the above case 1.

With the memset the same pev could be passed to clear_perf_probe_event()
multiple times, since all it would have would be zeroes, and free()
accepts zero, the loop would not happen and we would just memset it
again to zeroes.

Without it we got that segfault, so zero nargs to keep it like it was,
next cset will avoid calling clear_perf_probe_event() for the same pevs
in case of failure.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
Link: https://lkml.kernel.org/n/tip-802f2jypnwqsvyavvivs8464@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0c3b55d0617d..4acd3457d39d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2219,6 +2219,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
+	pev->nargs = 0;
 	zfree(&pev->args);
 }
 
-- 
2.21.0

