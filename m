Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBB679D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfGMLF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 07:05:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:05:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB5F8X3840827
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:05:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB5F8X3840827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015916;
        bh=njQoAtpsOTN3ydOHz+RomNxHuhy2whW4+IYVmtasUcY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rJtTyXNAFdLvxscRTkVt0VsfeGdK/0O+S/Z1OdJPu/xxTx+j2VANzf1fVzdfwfjMT
         qge3AXjk3d7LBztcCq1km2chtsiorsqdfvmgnBqKvZZjJHOiSOhOjK2uQwTNaCNqlq
         k9OxNmcka8RE0R0ljsKQ7vVwGv7oEYpuvXPaHFNElS187DxRLQJW6tzBf7HErrM3Tk
         MIo9CZ2Yz4frA6csHC8vJ6fuFth4RPxBA2ZLSBAjghOa4qZAxJ/rLdpvd668p1PRFN
         aLiaEJx/ioJQGm7GAqLJDZyvN7m5TPxj8AcpY8BVg1aGYGxdkDrsjv6J1KfCFR1yvn
         uAKqLivXE+39A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB5FJr3840824;
        Sat, 13 Jul 2019 04:05:15 -0700
Date:   Sat, 13 Jul 2019 04:05:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-0702f23c983b8a921853c33a9f59b9cf0975d36e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        hpa@zytor.com, jolsa@redhat.com, ak@linux.intel.com,
        acme@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, tglx@linutronix.de, namhyung@kernel.org
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          mathieu.poirier@linaro.org, ak@linux.intel.com, mingo@kernel.org,
          adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com,
          suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
          leo.yan@linaro.org, namhyung@kernel.org, acme@redhat.com
In-Reply-To: <20190708143937.7722-5-leo.yan@linaro.org>
References: <20190708143937.7722-5-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: 0702f23c983b8a921853c33a9f59b9cf0975d36e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0702f23c983b8a921853c33a9f59b9cf0975d36e
Gitweb:     https://git.kernel.org/tip/0702f23c983b8a921853c33a9f59b9cf0975d36e
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 8 Jul 2019 22:39:37 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf cs-etm: Fix potential NULL pointer dereference found by the smatch tool

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

  tools/perf/util/cs-etm.c:2545
  cs_etm__process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 2541)

  tools/perf/util/cs-etm.c
  2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
  2542                 etm->synth_opts = *session->itrace_synth_opts;
  2543         } else {
  2544                 itrace_synth_opts__set_default(&etm->synth_opts,
  2545                                 session->itrace_synth_opts->default_no_sample);
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
  2546                 etm->synth_opts.callchain = false;
  2547         }

'session->itrace_synth_opts' is impossible to be a NULL pointer in
cs_etm__process_auxtrace_info(), thus this patch removes the NULL
test for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190708143937.7722-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 508e4a3ddc8c..67b88b599a53 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2538,7 +2538,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
