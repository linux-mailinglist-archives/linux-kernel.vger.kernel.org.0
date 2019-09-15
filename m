Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45647B30E8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfIOQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 12:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIOQop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:44:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647D0214AF;
        Sun, 15 Sep 2019 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568565885;
        bh=hEQXdMAbwkHnERbTjFk2P2TA7lNKIjElywZgrhust1A=;
        h=From:To:Cc:Subject:Date:From;
        b=EIuV/oaq7S+hsRpHeNArUe1gnATwjw0o0F5tpx/OTCelxRPDbXH2Jlcp0DnVD7vpv
         ZlPgPWBKTdgjnEf0FlvLxZi/lhfs6ZeDqi7IFASXkkb+2cU9BvgSL6szl8tzIvUVip
         kr3OUIAeEBpb1J/5KQustc/6NgptWvEfn1MSS9ps=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH] perf/probe: Fix to clear tev->nargs in clear_probe_trace_event()
Date:   Mon, 16 Sep 2019 01:44:40 +0900
Message-Id: <156856587999.25775.5145779959474477595.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since add_probe_trace_event() can reuse tf->tevs[i] after
calling clear_probe_trace_event(), this can make perf-probe
crash if the 1st attempt of probe event finding fails to find
an event argument, and the 2nd attempt fails to find probe point.

E.g.
  $ perf probe -D "task_pid_nr tsk"
  Failed to find 'tsk' in this function.
  Failed to get entry address of warn_bad_vsyscall
  Segmentation fault (core dumped)


Fixes: 092b1f0b5f9f ("perf probe: Clear probe_trace_event when add_probe_trace_event() fails")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
---
 tools/perf/util/probe-event.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b8e0967c5c21..91cab5f669d2 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2331,6 +2331,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 		}
 	}
 	zfree(&tev->args);
+	tev->nargs = 0;
 }
 
 struct kprobe_blacklist_node {

