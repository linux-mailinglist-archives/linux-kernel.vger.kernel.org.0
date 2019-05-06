Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C21560A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEFWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 18:35:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36093 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:35:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so7515430pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
        b=RAhDVIwCMHTCtsbl6YiM3wbt/Ww204Kft83qmMlh/oZk9oVNu59qGWNZ0UtZ4Z6xjI
         Q5HZYvn49VUI6276rjq0/6vBnBUdCDmcNWylc0XNVdiESz96iOfliR9JnLtfwE0EB+Hi
         SLGnP4s1MhZGHBPr6S/W6rD+APYuTpblhdS/80+S9+QJ7/A7nQ0UgE4itiNQk8P2aga8
         /35qi+RzmiJyjAwz0HSF9I8iFsPq+Ba8+SLTzCMwwemheDGzlCKFaSj94Ew7qFDw7m41
         bmOSw/5frMORTko6m7KwCjdyi3jm+rqPWpZ34IEjX8AGApo/Igp34KxZM1FN1NzgMVxA
         EnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
        b=eCbGq0mWS3WlR7rI6kg5gz6QXIhupqaGxVtUVWChJrIQWq5pBzrCRNXihRqPgQLeCC
         KcWk7lTE39unk6MDOdrgLgqj3Vknn/EoiGYaabl5uvfw7BaXtDY3WBiWtWWb94z+EK7T
         2p/wuaXqqimGY6EVcYd86phl2QMZtrjRcfphoUl1rl+qiYmUeZHLjHQRuuCDKwzN6SgO
         hNkmG86CgkZveshV3uNKghWQ7jm6qwyMPDE9JqOMkb5LqLCe0C8kFFb19IMaIGxifMsb
         YtFBDrKlrqZ03JeLrURO49Z1dxjPK+ZXoQ/yChtPxMPMM/kU1XqCnCWhWjO4QcnS4F3V
         c7pQ==
X-Gm-Message-State: APjAAAXFAjOGaF5rri46lYwgWSNEdEeNR3bt81SRwzcCDI4cPuvExRkX
        vTQlL8lwyDrEUK0S2Y/n140Ip0Buaqw=
X-Google-Smtp-Source: APXvYqzYdAWKFIs+VsCPM+aRKfv4xdzOF68ZHdwgvThexqcw/HGkkiQVMrGZrh7oe8WQqm2t7rS0EA==
X-Received: by 2002:a65:610a:: with SMTP id z10mr35758284pgu.54.1557182116975;
        Mon, 06 May 2019 15:35:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c19sm14254976pgi.42.2019.05.06.15.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:35:16 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for single pages
Date:   Mon,  6 May 2019 15:33:34 -0700
Message-Id: <20190506223334.1834-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506223334.1834-1-nicoleotsuka@gmail.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to use the fallback alloc_pages path, instead of
one-page size allocations from the global CMA area in case that a
device does not have its own CMA area. This'd save resources from
the CMA global area for more CMA allocations, and also reduce CMA
fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 21f39a6cb04f..6914b92d5c88 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -223,14 +223,23 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  * This function allocates contiguous memory buffer for specified device. It
  * first tries to use device specific contiguous memory area if available or
  * the default global one, then tries a fallback allocation of normal pages.
+ *
+ * Note that it byapss one-page size of allocations from the global area as
+ * the addresses within one page are always contiguous, so there is no need
+ * to waste CMA pages for that kind; it also helps reduce fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t align = get_order(PAGE_ALIGN(size));
-	struct cma *cma = dev_get_cma_area(dev);
 	struct page *page = NULL;
+	struct cma *cma = NULL;
+
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-- 
2.17.1

