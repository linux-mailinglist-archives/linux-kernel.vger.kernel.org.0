Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9114D994
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgA3LSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 06:18:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:41973 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbgA3LSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:18:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580383112; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aa+36n0hz5H/cqeSiC1wp8nTMgGYZejOu0SrpL3H1mY=; b=lXUDQdB92nCPVUf75Z/6xH10aWUag+nqhhCzuB+QkpiVMEltgOdhWZJDMbQdDg9C8+G1wAe2
 Cxlfh8OR1LhmwNL1k0M1W1Yn3vLi3P0dNrn/sN1ILjJ8517Kuy8LJTpUsyukj/B31WkdqZV7
 3sfsSd7aTsrcjSrG2Oi51+OpPxw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e32bb85.7f62f4c2f5e0-smtp-out-n02;
 Thu, 30 Jan 2020 11:18:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A1CCC4479F; Thu, 30 Jan 2020 11:18:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59F7CC43383;
        Thu, 30 Jan 2020 11:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59F7CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        kernel-team@android.com, Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH] mm: slub: reinitialize random sequence cache on slab object update
Date:   Thu, 30 Jan 2020 16:47:44 +0530
Message-Id: <1580383064-16536-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

Random sequence cache is precomputed during slab object creation
based up on the object size and no of objects per slab. These could
be changed when flags like SLAB_STORE_USER, SLAB_POISON are updated
from sysfs. So when shuffle_freelist is called during slab_alloc it
uses updated object count to access the precomputed random sequence
cache. This could result in incorrect access of the random sequence
cache which could further result in slab corruption. Fix this by
reinitializing the random sequence cache up on slab object update.

A sample panic trace when write to slab_store_user was attempted.

Call trace0:
 exception
 set_freepointer(inline)
 shuffle_freelist(inline)
 new_slab+0x688/0x690
 ___slab_alloc+0x548/0x6f8
 kmem_cache_alloc+0x3dc/0x418
 zs_malloc+0x60/0x578
 zram_bvec_rw+0x66c/0xaa0
 zram_make_request+0x190/0x2c8
 generic_make_request+0x1f8/0x420
 submit_bio+0x140/0x1d8
 submit_bh_wbc+0x1a0/0x1e0
 __block_write_full_page+0x3a0/0x5e8
 block_write_full_page+0xec/0x108
 blkdev_writepage+0x2c/0x38
 __writepage+0x34/0x98
 write_cache_pages+0x33c/0x598
 generic_writepages+0x54/0x98
 blkdev_writepages+0x24/0x30
 do_writepages+0x90/0x138
 __filemap_fdatawrite_range+0xc0/0x128
 file_write_and_wait_range+0x44/0xa0
 blkdev_fsync+0x38/0x68
 __arm64_sys_fsync+0x6c/0xb8

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 mm/slub.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 0ab92ec..b88dd0f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1533,6 +1533,24 @@ static int init_cache_random_seq(struct kmem_cache *s)
 	return 0;
 }
 
+/* re-initialize the random sequence cache */
+static int reinit_cache_random_seq(struct kmem_cache *s)
+{
+	int err;
+
+	if (s->random_seq) {
+		cache_random_seq_destroy(s);
+		err = init_cache_random_seq(s);
+
+		if (err) {
+			pr_err("SLUB: Unable to re-initialize random sequence cache for %s\n",
+				s->name);
+			return err;
+		}
+	}
+
+	return 0;
+}
 /* Initialize each random sequence freelist per cache */
 static void __init init_freelist_randomization(void)
 {
@@ -1607,6 +1625,10 @@ static inline int init_cache_random_seq(struct kmem_cache *s)
 {
 	return 0;
 }
+static int reinit_cache_random_seq(struct kmem_cache *s)
+{
+	return 0;
+}
 static inline void init_freelist_randomization(void) { }
 static inline bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 {
@@ -5192,6 +5214,7 @@ static ssize_t red_zone_store(struct kmem_cache *s,
 		s->flags |= SLAB_RED_ZONE;
 	}
 	calculate_sizes(s, -1);
+	reinit_cache_random_seq(s);
 	return length;
 }
 SLAB_ATTR(red_zone);
@@ -5212,6 +5235,7 @@ static ssize_t poison_store(struct kmem_cache *s,
 		s->flags |= SLAB_POISON;
 	}
 	calculate_sizes(s, -1);
+	reinit_cache_random_seq(s);
 	return length;
 }
 SLAB_ATTR(poison);
@@ -5233,6 +5257,7 @@ static ssize_t store_user_store(struct kmem_cache *s,
 		s->flags |= SLAB_STORE_USER;
 	}
 	calculate_sizes(s, -1);
+	reinit_cache_random_seq(s);
 	return length;
 }
 SLAB_ATTR(store_user);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
1.9.1
