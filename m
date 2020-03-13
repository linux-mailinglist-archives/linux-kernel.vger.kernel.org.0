Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533931837A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 13:33:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51489 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCLRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:32:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so7025768wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rC6DPhMt4Bc6PZBfsWnH9m+te2MxYFVp1w0OPHy/TMg=;
        b=RsW/vK4ZQdfMF082vtv3xGDq0tnOXulVLSIzxMkgnp71K/k5wE9FsaYAqfwBT7Mi8T
         1JGkpiXJS/cZde2IHQWUKO2lYZzaiwID5eItcGzhgvtHijHI/MSk4nmoIOz9KNm30+Yg
         FUB3Lg42z8vn9pQn08JwbZJE+I0nAu8whv3GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rC6DPhMt4Bc6PZBfsWnH9m+te2MxYFVp1w0OPHy/TMg=;
        b=ZfXOfT7I+NC5pYWb03R5xY9xpJWClDQwI5dtLKfXqhLaP0fg+mx2LqYMVvEFrcxg7Y
         hYt31GVMoSoRuBlCQQz9KQI7LZejj5r5iDxQNQVBVRTVOhT9aCGgr6l32r7wDirVadiV
         xmihjZtRX0Wi23z02dN+aM/WpjnFHfY4HWQ1k69dulFwnHLzl8qzNKTJlJkskiNFCjGe
         bmpTAF2qLpHalvNse45xRtBsiElwHGuFzoRFxq/PF9K+XPeySI9HCDsEEIXCPr6yAWzq
         aBEPY0Pefva4QAxSw9Ljq5xfj69pyuwmtzXc5iElhKxtFifLIuA/BZA0xsCFBLKouW3s
         kdCw==
X-Gm-Message-State: ANhLgQ1LnE2lzRlR9w1Xpn3UKQNnkLubHrMabLbveFkTGZMPhNdxd2De
        ro8N+pzLog1kS2WzCiT+3aoRSg==
X-Google-Smtp-Source: ADFU+vuUWIJm8HtSoJx05RRAuGsJ1TYnW585UUfshNPcO1zgDpwRCCY5Y8dEGgjUnxBmIS6TJK1gTw==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr5541876wmm.127.1584034377704;
        Thu, 12 Mar 2020 10:32:57 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id y16sm19541988wrn.63.2020.03.12.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:32:57 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:32:56 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/6] mm, memcg: Prevent memory.max load tearing
Message-ID: <50a31e5f39f8ae6c8fb73966ba1455f0924e8f44.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is a bit more nuanced because we have memcg_max_mutex, which is
mostly just used for enforcing invariants, but we still need to
READ_ONCE since (despite its name) it doesn't really protect memory.max
access.

On write (page_counter_set_max() and memory_max_write()) we use xchg(),
which uses smp_mb(), so that's already fine.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d32d3c0a16d4..aca2964ea494 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1507,7 +1507,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)memcg->memory.max), memcg->memory.failcnt);
+		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->swap)),
@@ -1538,7 +1538,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
 	unsigned long max;
 
-	max = memcg->memory.max;
+	max = READ_ONCE(memcg->memory.max);
 	if (mem_cgroup_swappiness(memcg)) {
 		unsigned long memsw_max;
 		unsigned long swap_max;
@@ -3006,7 +3006,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		 * Make sure that the new limit (memsw or memory limit) doesn't
 		 * break our basic invariant rule memory.max <= memsw.max.
 		 */
-		limits_invariant = memsw ? max >= memcg->memory.max :
+		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
 					   max <= memcg->memsw.max;
 		if (!limits_invariant) {
 			mutex_unlock(&memcg_max_mutex);
@@ -3753,8 +3753,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
 	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
-		memory = min(memory, mi->memory.max);
-		memsw = min(memsw, mi->memsw.max);
+		memory = min(memory, READ_ONCE(mi->memory.max));
+		memsw = min(memsw, READ_ONCE(mi->memsw.max));
 	}
 	seq_printf(m, "hierarchical_memory_limit %llu\n",
 		   (u64)memory * PAGE_SIZE);
@@ -4257,7 +4257,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(memcg->memory.max,
+		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
 					    READ_ONCE(memcg->high));
 		unsigned long used = page_counter_read(&memcg->memory);
 
-- 
2.25.1

