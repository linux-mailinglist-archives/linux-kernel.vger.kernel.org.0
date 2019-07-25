Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB175724
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGYSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 14:43:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45454 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGYSns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:43:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so23180865pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75v+7kFOX3fDCU6QmGh0HhSEpSdixRD3VTEDmH00T24=;
        b=dlyJ1KobmoWLtFv7IcNUQJNez9fMahwQ5BinTISnEvaeniV2pgG2noG7Q17DcQHHhe
         kv1BWR9vH2jTvOCKHrFyHl2Z7FSzGX7IPCY1DtjJnKYZr9ao4LPqqwI/qzKZUmlfxxj9
         gWoQjCwtrBIwL1CotH8OwPNZxE9sm3Gals+8TapRsll0joD1XmNmjoyhW2vel99FHMLl
         +v2xNA2JhyFRoDDtSggDSTjUFy4qrEY7KYIupvhwaByb4Y46kYtK2z4ns4C1yqY7zYyU
         ILNBVtcrVmOqkgkdWurIguRB5tzt0l1D6fPe1Y8dpyE5iGLmrtcwqAub4syvDoI9McrV
         GsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75v+7kFOX3fDCU6QmGh0HhSEpSdixRD3VTEDmH00T24=;
        b=D6mmz8LRM3hMnPH9l/XNH2cCLrToXxxDrHVvuPMXZFGnIQQM8z/mLOf1+NaDtiRZ4n
         xoS0llY4wC9clqO75+mkrzMV2wi5tFha81OYgZjuUx1Xpx+zNT3KvHny3eKKLmtbYMMB
         KUXxTQTrVaR2yB4rTMC0lOq2Vo0+pUIqda3jqle6MRwJTI2WPN+jqfS4wZ0NMptZOmtR
         3RBJm3jYSpal0iyffpJjzj3pHdqzQPK5zOm7syxMTsM1RWBYjgLDj10GqAu4SM2r/Jem
         9VZLLSqkJEqty/nuKvOOGPdm/Tz54pkxHT6bJpAFSqfQIjyZRJu1HQDJhsqht83PuOKT
         HEfw==
X-Gm-Message-State: APjAAAXx9d3u3V3/0Uipo7awE7Si1ZkVtOT99y6wx2SFLiOboKu91XSV
        hmE6szmbgEgx0MllpUuNyUI=
X-Google-Smtp-Source: APXvYqyJ16tErcZCd6V50Gl8u2liDc4czpUPjNQ0NEfS8/hL14rWy3Alcf4zsPe/54zld/LC6CpQZw==
X-Received: by 2002:a63:b555:: with SMTP id u21mr89025235pgo.222.1564080227314;
        Thu, 25 Jul 2019 11:43:47 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.43.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:43:46 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 02/10] mm/page_alloc: use unsigned int for "order" in __rmqueue_fallback()
Date:   Fri, 26 Jul 2019 02:42:45 +0800
Message-Id: <20190725184253.21160-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because "order" will never be negative in __rmqueue_fallback(),
so just make "order" unsigned int.
And modify trace_mm_page_alloc_extfrag() accordingly.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/trace/events/kmem.h | 6 +++---
 mm/page_alloc.c             | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..31f4d09aa31f 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -277,7 +277,7 @@ TRACE_EVENT(mm_page_pcpu_drain,
 TRACE_EVENT(mm_page_alloc_extfrag,
 
 	TP_PROTO(struct page *page,
-		int alloc_order, int fallback_order,
+		unsigned int alloc_order, int fallback_order,
 		int alloc_migratetype, int fallback_migratetype),
 
 	TP_ARGS(page,
@@ -286,7 +286,7 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	pfn			)
-		__field(	int,		alloc_order		)
+		__field(	unsigned int,	alloc_order		)
 		__field(	int,		fallback_order		)
 		__field(	int,		alloc_migratetype	)
 		__field(	int,		fallback_migratetype	)
@@ -303,7 +303,7 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 					get_pageblock_migratetype(page));
 	),
 
-	TP_printk("page=%p pfn=%lu alloc_order=%d fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d",
+	TP_printk("page=%p pfn=%lu alloc_order=%u fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d",
 		pfn_to_page(__entry->pfn),
 		__entry->pfn,
 		__entry->alloc_order,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 75c18f4fd66a..1432cbcd87cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2631,8 +2631,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
  * condition simpler.
  */
 static __always_inline bool
-__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
-						unsigned int alloc_flags)
+__rmqueue_fallback(struct zone *zone, unsigned int order,
+		int start_migratetype, unsigned int alloc_flags)
 {
 	struct free_area *area;
 	int current_order;
-- 
2.21.0

