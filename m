Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3277010F961
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 09:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLCICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 03:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfLCICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:02:00 -0500
Received: from localhost.localdomain (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B722205ED;
        Tue,  3 Dec 2019 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575360119;
        bh=bpn6u+EoyQiX3G5mTrjZu67knISQ+TQ5fK8aXHN7ILU=;
        h=From:To:Cc:Subject:Date:From;
        b=2rEPm30+ecBK+Md0iFUSc0NydCdrV1ITK9Ae6/c3dSi8VPlMdBdM/+FsiHZKpG8Du
         xBlk01JkZSOHdKx8wFYGSxnIIa90+pOaKwe1Ya0XQz1exYHUTGVPrN/bhE2REcJ1sv
         tZ8w1bQ9YqedmB9GIOdWkqpJWfcKrjndqVB6qc5c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf probe: Fix to delete multiple probe event
Date:   Tue,  3 Dec 2019 17:01:54 +0900
Message-Id: <157536011452.29277.3647564438675346431.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to delete multiple probe event with filter correctly.

When we put an event with multiple probes, perf-probe fails
to delete with filters. This comes from a failure to list
up the event name because of overwrapping its name.

To fix this issue, skip to list up the event which has
same name.

Without this patch:
  # perf probe -l \*
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:21@
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:25@
    probe_perf:map__map_ip (on append_inlines:12@util/machine.c in
    probe_perf:map__map_ip (on unwind_entry:19@util/machine.c in /
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
  # perf probe -d \*
  "*" does not hit any event.
    Error: Failed to delete events. Reason: No such file or directory (Code: -2)

With this:
  # perf probe -d \*
  Removed event: probe_perf:map__map_ip

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-file.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba403345..c03a591d41a4 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -206,6 +206,9 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
 		} else
 			ret = strlist__add(sl, tev.event);
 		clear_probe_trace_event(&tev);
+		/* Skip if there is same name multi-probe event in the list */
+		if (ret == -EEXIST)
+			ret = 0;
 		if (ret < 0)
 			break;
 	}

