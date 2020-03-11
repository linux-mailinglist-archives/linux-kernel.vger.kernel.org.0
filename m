Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A681181CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgCKPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:47:22 -0400
Received: from verein.lst.de ([213.95.11.211]:60079 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbgCKPrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:47:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBD4168C65; Wed, 11 Mar 2020 16:47:18 +0100 (CET)
Date:   Wed, 11 Mar 2020 16:47:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
Message-ID: <20200311154718.GB24044@lst.de>
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/> <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com> <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com> <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de> <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311154328.GA24044@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And actually one more idea after looking at what slab interactions
could exist.  platform_device_register_full frees the dma_mask
unconditionally, even if it didn't allocated it, which might lead
to weird memory corruption if we hit the failure path.  So let's try
something like this, replacing the earlier patch in that file.

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b230beb6ccb4..04080a8d94e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -632,19 +632,6 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			goto err;
-
-		kmemleak_ignore(pdev->dev.dma_mask);
-
 		*pdev->dev.dma_mask = pdevinfo->dma_mask;
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
@@ -670,7 +657,6 @@ struct platform_device *platform_device_register_full(
 	if (ret) {
 err:
 		ACPI_COMPANION_SET(&pdev->dev, NULL);
-		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
