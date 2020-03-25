Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857021922E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCYIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 04:37:43 -0400
Received: from verein.lst.de ([213.95.11.211]:39686 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCYIhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:37:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C21B68BFE; Wed, 25 Mar 2020 09:37:40 +0100 (CET)
Date:   Wed, 25 Mar 2020 09:37:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200325083740.GC21605@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de> <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de> <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru> <20200324075402.GJ23447@lst.de> <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:51:36PM +1100, Alexey Kardashevskiy wrote:
> >> This is for persistent memory which you can DMA to/from but yet it does
> >> not appear in the system as a normal memory and therefore requires
> >> special handling anyway (O_DIRECT or DAX, I do not know the exact
> >> mechanics). All other devices in the system should just run as usual,
> >> i.e. use 1:1 mapping if possible.
> > 
> > On other systems (x86 and arm) pmem as long as it is page backed does
> > not require any special handling.  This must be some weird way powerpc
> > fucked up again, and I suspect you'll have to suffer from it.
> 
> 
> It does not matter if it is backed by pages or not, the problem may also
> appear if we wanted for example p2p PCI via IOMMU (between PHBs) and
> MMIO might be mapped way too high in the system address space and make
> 1:1 impossible.

How can it be mapped too high for a direct mapping with a 64-bit DMA
mask?
