Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37919135F55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgAIR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 12:28:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41252 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388162AbgAIR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:31 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HQ8vN023580
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yWsKMbKKvNoFtvLffYj7n/yEVoqHuKOiCZvwhu1iZHY=;
 b=ZjIDbT7XQEBa2Jc/gKvuAXh411L7pRj3cqroVQRYaHl+Y2fvP6t58GJOpOZ4gT9V6ZVh
 d6Y/1Rd36cBIvlt/tYoAFM56i49meEQo9JKDbVnL2uFlBIeNfuiKAC3mehLesAnMPkgJ
 MwR7agLtQEfiUC9HNVnCekF8xUGY8VnBubU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe2ext2jg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:30 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 09:28:21 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 7D4AA1D2DC5DA; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 3/7] mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments
Date:   Thu, 9 Jan 2020 09:27:41 -0800
Message-ID: <20200109172745.285585-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109172745.285585-1-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=958 mlxscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unused page argument and put the memcg pointer at the first
place. This make the function consistent with its peers:
__memcg_kmem_uncharge_memcg(), memcg_kmem_charge_memcg(), etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/slab.h                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f1eb8e72a612..2e2b9ac8d940 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1409,8 +1409,8 @@ static inline int memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
-static inline void memcg_kmem_uncharge_memcg(struct page *page, int order,
-					     struct mem_cgroup *memcg)
+static inline void memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
+					     int order)
 {
 	if (memcg_kmem_enabled())
 		__memcg_kmem_uncharge_memcg(memcg, 1 << order);
diff --git a/mm/slab.h b/mm/slab.h
index c4c93e991250..e7da63fb8211 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -395,7 +395,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
-		memcg_kmem_uncharge_memcg(page, order, memcg);
+		memcg_kmem_uncharge_memcg(memcg, order);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    -(1 << order));
-- 
2.21.1

