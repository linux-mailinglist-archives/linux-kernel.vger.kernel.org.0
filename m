Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA282967
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfHFBsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 21:48:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:48:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761imIe082725;
        Tue, 6 Aug 2019 01:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=JhlDiE5CFQVneED4uISVxNEm3HniZ2YmW8rRwhJuusw=;
 b=EEAe5V4CpBzlaE/3etCFXwvH2cJ7B5qnyHYluAnrQ7kJmb8gAvpL3ppTRcqjKlF+qsaq
 PwRex9VoWFTmY6c56qrgt6kX2gp2AqkTGm933NlPudzeiPP3KpCMPxMGhZPQ2q+eEnJ8
 CVKopKHFzCoWUyOJHsWdJswsnWoCH2F48pYjhV+Bj5fVKODTlu6gC4xHzZe4C0wpf+Iw
 +ixGzU0Z+Y+JH6WqEOz757o5ZO6ruiEclW39KzXOqaZ3Zy+/SSx3ONaYjMjGMQzu6198
 64H+016popLpUM6eVUf1vNaDQFvrdvDSG8ExpNo/wzHmkhf8HWBP7klSg5PYOQl3WVs3 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u52wr2kpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761m4td012646;
        Tue, 6 Aug 2019 01:48:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u5233qgee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x761ls8K017861;
        Tue, 6 Aug 2019 01:47:54 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 18:47:54 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 1/4] mm, reclaim: make should_continue_reclaim perform dryrun detection
Date:   Mon,  5 Aug 2019 18:47:41 -0700
Message-Id: <20190806014744.15446-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806014744.15446-1-mike.kravetz@oracle.com>
References: <20190806014744.15446-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

Address the issue of should_continue_reclaim returning true too often
for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
This was observed during hugetlb page allocation causing stalls for
minutes or hours.

We can stop reclaiming pages if compaction reports it can make a progress.
There might be side-effects for other high-order allocations that would
potentially benefit from reclaiming more before compaction so that they
would be faster and less likely to stall.  However, the consequences of
premature/over-reclaim are considered worse.

We can also bail out of reclaiming pages if we know that there are not
enough inactive lru pages left to satisfy the costly allocation.

We can give up reclaiming pages too if we see dryrun occur, with the
certainty of plenty of inactive pages. IOW with dryrun detected, we are
sure we have reclaimed as many pages as we could.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Tested-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 - Updated commit message and added SOB.

 mm/vmscan.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 47aa2158cfac..a386c5351592 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2738,18 +2738,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 			return false;
 	}
 
-	/*
-	 * If we have not reclaimed enough pages for compaction and the
-	 * inactive lists are large enough, continue reclaiming
-	 */
-	pages_for_compaction = compact_gap(sc->order);
-	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
-		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
-	if (sc->nr_reclaimed < pages_for_compaction &&
-			inactive_lru_pages > pages_for_compaction)
-		return true;
-
 	/* If compaction would go ahead or the allocation would succeed, stop */
 	for (z = 0; z <= sc->reclaim_idx; z++) {
 		struct zone *zone = &pgdat->node_zones[z];
@@ -2765,7 +2753,21 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 			;
 		}
 	}
-	return true;
+
+	/*
+	 * If we have not reclaimed enough pages for compaction and the
+	 * inactive lists are large enough, continue reclaiming
+	 */
+	pages_for_compaction = compact_gap(sc->order);
+	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (get_nr_swap_pages() > 0)
+		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	return inactive_lru_pages > pages_for_compaction &&
+		/*
+		 * avoid dryrun with plenty of inactive pages
+		 */
+		nr_scanned && nr_reclaimed;
 }
 
 static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
-- 
2.20.1

