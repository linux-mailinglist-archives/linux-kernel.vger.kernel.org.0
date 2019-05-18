Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF5222B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfERJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:34:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:34:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9Y1Xt1742547
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:34:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9Y1Xt1742547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172042;
        bh=6P2dTH94rVsTHbN3+onRUIFfaXu47uRzGPAE+UWM1eg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OMC5xpll90c89chZ/608m6tByYrhuaWAQVZEh49nk0S4eFGsAZho5ZHg/BU90PLIi
         0HO0Xr+J7hRydPu9cM5AfkCWKiyz6enoD+vZluhEScUCSWDNeoqolHg0J2Rso9u3ex
         sicZaOYEm6+S48k44QFBdH+vuQ87zgVBs3dz6TkI7/ErmeMXBAVeJNx/GyRCKGQCoJ
         yt7BWl5gG3p12BIdXaAZtHeh7e+7+8JWIrLgscQ271voEOWGpvUp9Oz/wcqHUMA74R
         bGchP/6ZSbQFSsjeip2xcFK8/q2dx4XiZ1AhtXGNInETd9xOKEunQgJW1wfMLSEUEB
         t8Z3QtpaQJeSQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Y0mb1742544;
        Sat, 18 May 2019 02:34:00 -0700
Date:   Sat, 18 May 2019 02:34:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1b6599a9d8e6c9f7e9b0476012383b1777f7fc93@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, jolsa@redhat.com, adrian.hunter@intel.com,
          acme@redhat.com
In-Reply-To: <20190510124143.27054-4-adrian.hunter@intel.com>
References: <20190510124143.27054-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix sample timestamp wrt non-taken
 branches
Git-Commit-ID: 1b6599a9d8e6c9f7e9b0476012383b1777f7fc93
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b6599a9d8e6c9f7e9b0476012383b1777f7fc93
Gitweb:     https://git.kernel.org/tip/1b6599a9d8e6c9f7e9b0476012383b1777f7fc93
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 10 May 2019 15:41:43 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:24 -0300

perf intel-pt: Fix sample timestamp wrt non-taken branches

The sample timestamp is updated to ensure that the timestamp represents
the time of the sample and not a branch that the decoder is still
walking towards. The sample timestamp is updated when the decoder
returns, but the decoder does not return for non-taken branches. Update
the sample timestamp then also.

Note that commit 3f04d98e972b5 ("perf intel-pt: Improve sample
timestamp") was also a stable fix and appears, for example, in v4.4
stable tree as commit a4ebb58fd124 ("perf intel-pt: Improve sample
timestamp").

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 3f04d98e972b ("perf intel-pt: Improve sample timestamp")
Link: http://lkml.kernel.org/r/20190510124143.27054-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9cbd587489bf..f4c3c84b090f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1318,8 +1318,11 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				return 0;
 			}
 			decoder->ip += intel_pt_insn.length;
-			if (!decoder->tnt.count)
+			if (!decoder->tnt.count) {
+				decoder->sample_timestamp = decoder->timestamp;
+				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 				return -EAGAIN;
+			}
 			decoder->tnt.payload <<= 1;
 			continue;
 		}
