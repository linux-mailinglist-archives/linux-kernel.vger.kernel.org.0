Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3AA7431
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfICUFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 16:05:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42898 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:05:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so3106295pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29Qri/KXgUDgYfdOZ88fjJJOMZcARQYfy1B4reZQb8c=;
        b=Bc9wK/zblLGMuThMFStgTMR+Yuk5YZw/2OmzZKkNBCmEcFehCD/s4K1pbKKLrFQA05
         mPmHzEIztfOvQcEOIKXnzaWKwPLSifbtOQKvCSKx1ILGYfhNrkkFERSz53zkUM9YgF5j
         2Qzq8rXeRv4y/MaRj50LsMtZJS/kv+gom5Ifo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29Qri/KXgUDgYfdOZ88fjJJOMZcARQYfy1B4reZQb8c=;
        b=G1qClCbmsxP02ciYIzUkxCCqjQUgRqRQK8GerZErkILo1rfWDdeNZSHWt2Z1YUXHlw
         xYlRotwblNlQ1xHgB7NQPTkNRVBWmR7kD19pl6g7Jpn5udFYz+lUgtUxPO7q0b93hjUU
         /JLYyUaWKv3gkpHechmA7bJsBP//ktbgyzd3hq+hUzQ+kJugk6O9Dx444NvHR3Zp7eIg
         wu45l10nQmkrMMu8rNr0Q1X2lH9x9p/CMA8A7yFeMzcQqw0mf4+9nmxQmUIs270NLTD7
         7LIfFz4zxqwmj3ReoDPQ6kkexDk24i0nmEfXvLZVmgVVOYnuuFFkavPmMBtNGLzlUAOh
         CzEQ==
X-Gm-Message-State: APjAAAU2IMwjeiUwT9DSrwgHnBCnOlb7UMv/8p8Gjbapkw1oDgIxjQoK
        a0jjKq+rH1C1AL2jFw5aTZ3jBe6j/Rw=
X-Google-Smtp-Source: APXvYqzWwyyPykUJ8+f6u/buSmFd9exUPGkAK1eD0pBWdCTcvskP3nkPl9BvPjdTnUwebYQ7ayLfuA==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr1009540pjv.55.1567541114848;
        Tue, 03 Sep 2019 13:05:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k36sm16606308pgl.42.2019.09.03.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:05:14 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>, carmenjackson@google.com,
        mayankgupta@google.com, dancol@google.com, rostedt@goodmis.org,
        minchan@kernel.org, akpm@linux-foundation.org,
        kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jerome Glisse" <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm: emit tracepoint when RSS changes by threshold
Date:   Tue,  3 Sep 2019 16:05:03 -0400
Message-Id: <20190903200503.147973-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful to track how RSS is changing per TGID. Several Android teams have
been using this patch in various kernel trees for half a year now. Many
reported to me it is really useful.

Initial patch developed by Tim Murray. Changes I made from original patch:
o Prevent any additional space consumed by mm_struct.
o Keep overhead low by checking if tracing is enabled.
o Add some noise reduction and lower overhead by emitting only on
  threshold changes.

Co-developed-by: Tim Murray <timmurray@google.com>
Signed-off-by: Tim Murray <timmurray@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

Cc: carmenjackson@google.com
Cc: mayankgupta@google.com
Cc: dancol@google.com
Cc: rostedt@goodmis.org
Cc: minchan@kernel.org
Cc: akpm@linux-foundation.org
Cc: kernel-team@android.com

 include/linux/mm.h          | 14 +++++++++++---
 include/trace/events/kmem.h | 21 +++++++++++++++++++++
 mm/memory.c                 | 20 ++++++++++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..823aaf759bdb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1671,19 +1671,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return (unsigned long)val;
 }
 
+void mm_trace_rss_stat(int member, long count, long value);
+
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	atomic_long_add(value, &mm->rss_stat.count[member]);
+	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, value);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_inc(&mm->rss_stat.count[member]);
+	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_dec(&mm->rss_stat.count[member]);
+	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, -1);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..8b88e04fafbf 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -315,6 +315,27 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(rss_stat,
+
+	TP_PROTO(int member,
+		long count),
+
+	TP_ARGS(member, count),
+
+	TP_STRUCT__entry(
+		__field(int, member)
+		__field(long, size)
+	),
+
+	TP_fast_assign(
+		__entry->member = member;
+		__entry->size = (count << PAGE_SHIFT);
+	),
+
+	TP_printk("member=%d size=%ldB",
+		__entry->member,
+		__entry->size)
+	);
 #endif /* _TRACE_KMEM_H */
 
 /* This part must be outside protection */
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..9d81322c24a3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -72,6 +72,8 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 
+#include <trace/events/kmem.h>
+
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -140,6 +142,24 @@ static int __init init_zero_pfn(void)
 }
 core_initcall(init_zero_pfn);
 
+/*
+ * This threshold is the boundary in the value space, that the counter has to
+ * advance before we trace it. Should be a power of 2. It is to reduce unwanted
+ * trace overhead. The counter is in units of number of pages.
+ */
+#define TRACE_MM_COUNTER_THRESHOLD 128
+
+void mm_trace_rss_stat(int member, long count, long value)
+{
+	long thresh_mask = ~(TRACE_MM_COUNTER_THRESHOLD - 1);
+
+	if (!trace_rss_stat_enabled())
+		return;
+
+	/* Threshold roll-over, trace it */
+	if ((count & thresh_mask) != ((count - value) & thresh_mask))
+		trace_rss_stat(member, count);
+}
 
 #if defined(SPLIT_RSS_COUNTING)
 
-- 
2.23.0.187.g17f5b7556c-goog
