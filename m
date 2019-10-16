Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D131ED95E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405514AbfJPPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:44:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404969AbfJPPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3994AF5B;
        Wed, 16 Oct 2019 15:44:57 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:44:55 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
Message-ID: <20191016154455.GG4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571237982.5937.60.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:59:42AM -0400, Qian Cai wrote:
> BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
> parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
> correct warning.

Can you please test this small fix:

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 78a2cca3ac5c..e7a4464e8594 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2562,7 +2562,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
+	ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
 
 	domain_flush_np_cache(domain, iova, page_size);
 

