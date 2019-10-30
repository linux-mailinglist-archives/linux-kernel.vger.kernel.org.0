Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D85AEA39A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 19:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJ3Sst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 14:48:49 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45977 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfJ3Sst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:48:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id c8so2127882pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RxCCtsUMffCpcw7QGLE4bk1qQR+dpNRsJ71EwxdG0Xk=;
        b=OrTeov0MyfaAmSyyfPGPKLg0eXpE53ZgPavJXpQQS8qz/f0XZUwmrS2wwKKaB2XVNc
         DXZZ9vO41W/XihEybrbg3MGHikco/mfRz7ijImQGna9k0suLyvKl+OquRhFNdJTZ6Ddl
         U7/wo9xULrSL3vFbr+mfi2XlI1z081HHasdMygINPFdd3zFw0Q2D36PmcAZVesg9OgZn
         flYWUHl0Xqkoa5L/fXKxQRNABEIMyfEdcCm64me3SzYZpN2taFoxBIcD59LaHk10iTAx
         g3CWUGR6buA84/x7ICNTEUKHOKc35SQuvHkXLF4colim3CrzEqYB2fba4zqGxTLNKiEf
         oK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RxCCtsUMffCpcw7QGLE4bk1qQR+dpNRsJ71EwxdG0Xk=;
        b=Zw8csCFRsTGgQ1WoxrwtT8Bh1gua7KFFi0w8Bv9l2rGMZmaciagaKl9TfN8EuMDQv9
         HH9rnKz2FC+irqoOX9k1EWCG+EwfCyiY7nZ6tSZdAY5ZIeODazxAeL6n4p8ojVNVHKOa
         b/Xcd7bmB10dpVBa2q3R2YLXDUkcgDD4DQRuESk0a8RbINb8o58f5Z2ZCSKlSZAhtvP8
         W+5Hicx+F115hT8mVyhv8FsN6lXrGr21LS5d01zwB4fcr9A8PwYilhp8uZ5AIpVdEoDD
         feA7SHPDOR/A9O9/d+RG3SsdyHubepcSGMU5uOC/wVZh5ds6mwZ/P2HCTSLhOwALiYwF
         aBNA==
X-Gm-Message-State: APjAAAVoxnOvroQ2J38Ktgystw7BNhKDVOnBaZFmvvvx4dnyEQ8rl3tu
        mzEwnLN+JsgCPVVBKzLB9g7VPG0ouEt4PA==
X-Google-Smtp-Source: APXvYqwiaSVnPpt9SNJjIcQs076rWEC2mGKAMEx5JMSKGZKIg45XQxwBTXX346eXp9II+TsQncwbggSHDgvvHQ==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr1081237pgg.134.1572461328271;
 Wed, 30 Oct 2019 11:48:48 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:48:44 -0700
Message-Id: <20191030184844.84219-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] dma-debug: increase HASH_SIZE
From:   Eric Dumazet <edumazet@google.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With modern NIC, it is not unusual having about ~256,000 active dma
mappings. Hash size of 1024 buckets is too small.

Forcing full cache line per bucket does not seem useful,
especially now that we have a contention on free_entries_lock
for allocations and freeing of entries. Better using space
to fit more buckets.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 4ad74f5987ea9e95f9bb5e2d1592254e367d24fb..35e2a853bff9c482d789ab331d79aaee07753a97 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -27,7 +27,7 @@
 
 #include <asm/sections.h>
 
-#define HASH_SIZE       1024ULL
+#define HASH_SIZE       16384ULL
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
@@ -87,7 +87,7 @@ typedef bool (*match_fn)(struct dma_debug_entry *, struct dma_debug_entry *);
 struct hash_bucket {
 	struct list_head list;
 	spinlock_t lock;
-} ____cacheline_aligned_in_smp;
+};
 
 /* Hash list to save the allocated dma addresses */
 static struct hash_bucket dma_entry_hash[HASH_SIZE];
-- 
2.24.0.rc0.303.g954a862665-goog

