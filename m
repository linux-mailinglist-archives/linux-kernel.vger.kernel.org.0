Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2061B6E5C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfGSMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 08:33:20 -0400
Received: from verein.lst.de ([213.95.11.211]:39790 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfGSMdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:33:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD7C768B02; Fri, 19 Jul 2019 14:33:18 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:33:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Roger Quadros <rogerq@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: add swiotlb support to arm32
Message-ID: <20190719123318.GA30713@lst.de>
References: <20190709142011.24984-1-hch@lst.de> <6a56eacd-d481-de93-e0d8-64d8385de214@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a56eacd-d481-de93-e0d8-64d8385de214@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 06:51:46PM +0530, Vignesh Raghavendra wrote:
> > This series adds swiotlb support to the 32-bit arm port to ensure
> > platforms with LPAE support can support DMA mapping for all devices
> > using 32-bit dma masks, just like we do on other ports that support
> >> 32-bit physical addressing and don't have an iommu.
> 
> 
> This series fixes SATA errors seen on TI platforms with LPAE like DRA7
> Rev H EVM.
> 
> Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Thanks for the fix!

Thanks for testing!  Russell, do you want to pick this up via the
arm tree, or should I queue it up in the dma-mapping tree?

> 
> -- 
> Regards
> Vignesh
---end quoted text---
