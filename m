Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AE4ED0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFUQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:20:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:13108 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfFUQUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:20:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 09:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="scan'208";a="312029878"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2019 09:20:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [GIT PULL 3/4] intel_th: msu: Fix single mode with disabled IOMMU
Date:   Fri, 21 Jun 2019 19:19:29 +0300
Message-Id: <20190621161930.60785-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU") switched
the single mode code to use dma mapping pages obtained from the page
allocator, but with IOMMU disabled, that may lead to using SWIOTLB bounce
buffers and without additional sync'ing, produces empty trace buffers.

Fix this by using a DMA32 GFP flag to the page allocation in single mode,
as the device supports full 32-bit DMA addressing.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Ammy Yi <ammy.yi@intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 6bfce03c6489..cfd48c81b9d9 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -667,7 +667,7 @@ static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
 		goto err_out;
 
 	ret = -ENOMEM;
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32, order);
 	if (!page)
 		goto err_free_sgt;
 
-- 
2.20.1

