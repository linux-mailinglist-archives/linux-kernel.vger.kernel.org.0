Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C454EA446
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJ3TcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 15:32:10 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45102 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3TcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:32:09 -0400
Received: by mail-pf1-f201.google.com with SMTP id a14so2504603pfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uliOILcdGqX5lDV+IjP9VAomclbVJ2rwkFNcUJMZq6M=;
        b=siJ8geBfdRqmEXkq6dLKWbC8UtCivAfXu9Ev9lpcqXAqFzlOYFyY7zN9HvPABllkzQ
         O6LahLFQV+H74an3iQO5p3Zrcr2jai2ra3n2C0MJRNXyhptbzhAirJtyAakCpNAGKtzi
         GGqsLAVap3zP8gvB88u11PFpI/OgaXigz1I86mcWz8dPQsbgRNiZRu6xzf30K0+3cpp3
         PRiTdhz/OjUU5lg4Z8WJJ3tH+4BXkak5okVJTcSzQWjRgP6lhbF/E6Y9tzhXyNxZyU3q
         GoIOnXNW42clAt3gmJT7/qy8vwD3KKxj0hL5gJEgZLt5Pioe8Y/X0wn1cfOgjrL87XIL
         lT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uliOILcdGqX5lDV+IjP9VAomclbVJ2rwkFNcUJMZq6M=;
        b=jhtf6/iUvHfPhpWkVhFqSYXt/RKjtE/cAJTxM/wd1K9iXA7TxJfWQk6qL99uRQy5Dz
         RgXzIpXcoGzdpsSdNcAXQqiDuVSY1i1W/23aLvx/heb1bw9NY3fI/rzcmGp8y+5dGYYa
         XX9uVPJmj8XCZYHwNYiogoh08O1LXL5Be+WKAcNFZU8MGrr3VkLKrWR0/WW2/rFqvoXk
         9iJP4T2AryzvG7X+Bm29oVDn3USuY0ww4YTmywRQDBldjjH7Z34pHfk1LVXdcmxAzyuJ
         3wT4jR57N02iMXG/ZgxDu+x5oADIdGtxek3LARFFWU9EbNuTI5mJkQXYsxGLu/jCpdTo
         R0Yw==
X-Gm-Message-State: APjAAAX75wC7IN2xqc1ZPHL+Rfn7kOT736QcaW5LoN7aIeyJBZDgKl79
        Mo1IZpPhm7HllFyP4WXOfrLlhu5zOMtJ/g==
X-Google-Smtp-Source: APXvYqyXGYZx1ctRh+VbQzSQ/CVwZLRUX1duflnmN+WRuDTJo3AvZp/Y2Qc26lYp0qQ4mQGzPAwgj9M/znfSow==
X-Received: by 2002:a63:5406:: with SMTP id i6mr1092706pgb.1.1572463927459;
 Wed, 30 Oct 2019 12:32:07 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:32:04 -0700
Message-Id: <20191030193204.133327-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH dma-debug: reorder struct dma_debug_entry fields
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

This patch moves all fields used during exact match
lookups to the first cache line.

This makes debug_dma_mapping_error() and friends
about 50% faster.

Since it removes two 32bit holes, force a cacheline
alignment on struct dma_debug_entry.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 35e2a853bff9c482d789ab331d79aaee07753a97..004496654aaa543a52fdd6684af5a87ef02ff054 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -54,33 +54,33 @@ enum map_err_types {
  * struct dma_debug_entry - track a dma_map* or dma_alloc_coherent mapping
  * @list: node on pre-allocated free_entries list
  * @dev: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coherent
- * @type: single, page, sg, coherent
- * @pfn: page frame of the start address
- * @offset: offset of mapping relative to pfn
  * @size: length of the mapping
+ * @type: single, page, sg, coherent
  * @direction: enum dma_data_direction
  * @sg_call_ents: 'nents' from dma_map_sg
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
+ * @pfn: page frame of the start address
+ * @offset: offset of mapping relative to pfn
  * @map_err_type: track whether dma_mapping_error() was checked
  * @stacktrace: support backtraces when a violation is detected
  */
 struct dma_debug_entry {
 	struct list_head list;
 	struct device    *dev;
-	int              type;
-	unsigned long	 pfn;
-	size_t		 offset;
 	u64              dev_addr;
 	u64              size;
+	int              type;
 	int              direction;
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
+	unsigned long	 pfn;
+	size_t		 offset;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
 #endif
-};
+} ____cacheline_aligned_in_smp;
 
 typedef bool (*match_fn)(struct dma_debug_entry *, struct dma_debug_entry *);
 
-- 
2.24.0.rc0.303.g954a862665-goog

