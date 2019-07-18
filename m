Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFA6CBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbfGRJP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:15:29 -0400
Received: from verein.lst.de ([213.95.11.211]:58112 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfGRJP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:15:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5018A68B05; Thu, 18 Jul 2019 11:15:26 +0200 (CEST)
Date:   Thu, 18 Jul 2019 11:15:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, phil@raspberrypi.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
Message-ID: <20190718091526.GA25321@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de> <20190717153135.15507-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717153135.15507-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 05:31:34PM +0200, Nicolas Saenz Julienne wrote:
> Historically devices with ZONE_DMA32 have been assumed to be able to
> address at least the lower 4GB of ram for DMA. This is still the defualt
> behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
> This has been observed to trigger failures in dma_direct_supported() as
> the 'min_mask' isn't properly set.
> 
> We create 'dma_direct_min_mask' in order for the arch init code to be
> able to fine-tune dma direct's 'min_dma' mask.

Normally we use ZONE_DMA for that case.
