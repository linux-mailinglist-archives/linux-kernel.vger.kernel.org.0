Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5D48E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfFQTZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:25:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:25:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJP3K53563269
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:25:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJP3K53563269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799504;
        bh=Qqc6POFVkKgSQcvgAsB6988pdzLu+HunI2paK+Ed5Fw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ALnGXQyDb6dJOEWbtCO0ZPKZ1rGFiISvV0cfU0en37288P6JQzl60HFIjMXCEmvnf
         tdDejAs7tEtdqgg+nyjMEvXTdxkKJS/n6N/gMtv1tUU9G4gU+chxEKkQGERKflmFpT
         6kZJQIKuymeG4/4T/9HEpsXhseWYkA9+gpDcMoanNCs5bpKZAR0LJZU4Mvff5M4Cir
         E0AOHrf+rTXdNWENeUT1pu46795tHX4YvjWHLv8v6FAi+ZWWVsGJywDFFFDUc9axaY
         1TMjMPNrgAH6aIv6vWZvi4NCvwXNIMJVBgVp0hATk9o49qeBiox+J6tWtKhIOF+sTV
         hyjv/D4t40WvA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJP2HN3563261;
        Mon, 17 Jun 2019 12:25:02 -0700
Date:   Mon, 17 Jun 2019 12:25:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-882f4874ad74c528c3437c9c8783310b073323a1@git.kernel.org>
Cc:     jolsa@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, leo.yan@linaro.org, suzuki.poulose@arm.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org, mingo@kernel.org, jolsa@redhat.com,
          tglx@linutronix.de, mathieu.poirier@linaro.org,
          leo.yan@linaro.org, suzuki.poulose@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20190524173508.29044-9-mathieu.poirier@linaro.org>
References: <20190524173508.29044-9-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Fix indentation in function
 cs_etm__process_decoder_queue()
Git-Commit-ID: 882f4874ad74c528c3437c9c8783310b073323a1
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

Commit-ID:  882f4874ad74c528c3437c9c8783310b073323a1
Gitweb:     https://git.kernel.org/tip/882f4874ad74c528c3437c9c8783310b073323a1
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:59 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Fix indentation in function cs_etm__process_decoder_queue()

Fixing wrong indentation of the while() loop - no change of
functionality.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 3fa0e83e2948 ("perf cs-etm: Modularize main packet processing loop")
Link: http://lkml.kernel.org/r/20190524173508.29044-9-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 108 +++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a74c53a45839..68fec6f019fe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1578,64 +1578,64 @@ static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
 
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq);
 
-		/* Process each packet in this chunk */
-		while (1) {
-			ret = cs_etm_decoder__get_packet(packet_queue,
-							 etmq->packet);
-			if (ret <= 0)
-				/*
-				 * Stop processing this chunk on
-				 * end of data or error
-				 */
-				break;
+	/* Process each packet in this chunk */
+	while (1) {
+		ret = cs_etm_decoder__get_packet(packet_queue,
+						 etmq->packet);
+		if (ret <= 0)
+			/*
+			 * Stop processing this chunk on
+			 * end of data or error
+			 */
+			break;
+
+		/*
+		 * Since packet addresses are swapped in packet
+		 * handling within below switch() statements,
+		 * thus setting sample flags must be called
+		 * prior to switch() statement to use address
+		 * information before packets swapping.
+		 */
+		ret = cs_etm__set_sample_flags(etmq);
+		if (ret < 0)
+			break;
 
+		switch (etmq->packet->sample_type) {
+		case CS_ETM_RANGE:
 			/*
-			 * Since packet addresses are swapped in packet
-			 * handling within below switch() statements,
-			 * thus setting sample flags must be called
-			 * prior to switch() statement to use address
-			 * information before packets swapping.
+			 * If the packet contains an instruction
+			 * range, generate instruction sequence
+			 * events.
 			 */
-			ret = cs_etm__set_sample_flags(etmq);
-			if (ret < 0)
-				break;
-
-			switch (etmq->packet->sample_type) {
-			case CS_ETM_RANGE:
-				/*
-				 * If the packet contains an instruction
-				 * range, generate instruction sequence
-				 * events.
-				 */
-				cs_etm__sample(etmq);
-				break;
-			case CS_ETM_EXCEPTION:
-			case CS_ETM_EXCEPTION_RET:
-				/*
-				 * If the exception packet is coming,
-				 * make sure the previous instruction
-				 * range packet to be handled properly.
-				 */
-				cs_etm__exception(etmq);
-				break;
-			case CS_ETM_DISCONTINUITY:
-				/*
-				 * Discontinuity in trace, flush
-				 * previous branch stack
-				 */
-				cs_etm__flush(etmq);
-				break;
-			case CS_ETM_EMPTY:
-				/*
-				 * Should not receive empty packet,
-				 * report error.
-				 */
-				pr_err("CS ETM Trace: empty packet\n");
-				return -EINVAL;
-			default:
-				break;
-			}
+			cs_etm__sample(etmq);
+			break;
+		case CS_ETM_EXCEPTION:
+		case CS_ETM_EXCEPTION_RET:
+			/*
+			 * If the exception packet is coming,
+			 * make sure the previous instruction
+			 * range packet to be handled properly.
+			 */
+			cs_etm__exception(etmq);
+			break;
+		case CS_ETM_DISCONTINUITY:
+			/*
+			 * Discontinuity in trace, flush
+			 * previous branch stack
+			 */
+			cs_etm__flush(etmq);
+			break;
+		case CS_ETM_EMPTY:
+			/*
+			 * Should not receive empty packet,
+			 * report error.
+			 */
+			pr_err("CS ETM Trace: empty packet\n");
+			return -EINVAL;
+		default:
+			break;
 		}
+	}
 
 	return ret;
 }
