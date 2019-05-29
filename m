Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42CA2DE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfE2Njj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:34 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE96227B7;
        Wed, 29 May 2019 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137174;
        bh=3GgCPxhekUV44Ra9EUUPkPDn9SbXslu3KvGLOTPrmhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OILOSBABJ+nkhHfylypdpeXGQhNhfJwMV+bXXE8TyQ6NWJTFbxMqDFZZjYkXCg+mM
         NBIFbiAYET0evLrLFi3Dpl/PR6Qypr7Q/conv8nluf1KR1WRf9B7laddfUnu42eRYK
         v4K8Gjf95ZkfbzdWtnDW3Ok3SLqMtnvVin3c7NEM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/41] perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
Date:   Wed, 29 May 2019 10:36:05 -0300
Message-Id: <20190529133605.21118-42-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Returning 1 from intel_pt_sync_switch() causes the current tid to be
set. That negates the need to keep next_tid anymore. Rationalize the
code to that effect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6aaba1146fc8..7a70693c1b91 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1859,7 +1859,6 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 
 	switch (ptq->switch_state) {
 	case INTEL_PT_SS_NOT_TRACING:
-		ptq->next_tid = -1;
 		break;
 	case INTEL_PT_SS_UNKNOWN:
 	case INTEL_PT_SS_TRACING:
@@ -1879,13 +1878,14 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		ptq->switch_state = INTEL_PT_SS_TRACING;
 		break;
 	case INTEL_PT_SS_EXPECTING_SWITCH_IP:
-		ptq->next_tid = tid;
 		intel_pt_log("ERROR: cpu %d expecting switch ip\n", cpu);
 		break;
 	default:
 		break;
 	}
 
+	ptq->next_tid = -1;
+
 	return 1;
 }
 
-- 
2.20.1

