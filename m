Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C463D64E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405809AbfFKTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405486AbfFKTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5EC2183E;
        Tue, 11 Jun 2019 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279839;
        bh=oYshPBbJWRIM2JW/nFg2Xv5FmapQ6crdkKi+CwziObY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYJjAg/njvWnoHfqU46T33HQu1Uugr0OsPuln3jX/3brnNGQJwSDLllJ8+kcIStt5
         60XcbeT8Dasy5tLCkqdcyDotQ1ARO/+Kpl5QiHvS6Id4YHfPTy7Bq8bPer9cHjRnxA
         xOKqTtzdsL7c8oojdjMBv3IJseco8iD3PcFmI6jI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 64/85] perf script: Set perf time interval in itrace_synth_ops
Date:   Tue, 11 Jun 2019 15:58:50 -0300
Message-Id: <20190611185911.11645-65-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 80c722ade852..61f00055476a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3829,6 +3829,10 @@ int cmd_script(int argc, const char **argv)
 						  &script.range_num);
 		if (err < 0)
 			goto out_delete;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  script.ptime_range,
+						  script.range_num);
 	}
 
 	err = __cmd_script(&script);
@@ -3836,8 +3840,10 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	if (script.ptime_range)
+	if (script.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&script.ptime_range);
+	}
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
-- 
2.20.1

