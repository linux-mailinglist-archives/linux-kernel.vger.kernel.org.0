Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686E5135B62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgAIObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 09:31:11 -0500
Received: from verein.lst.de ([213.95.11.211]:54956 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgAIObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:31:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7011068BFE; Thu,  9 Jan 2020 15:31:08 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:31:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
Message-ID: <20200109143108.GA22656@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com> <20200107105458.GA3139@lst.de> <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 11:57:24AM -0800, David Rientjes wrote:
> I'll rely on Thomas to chime in if this doesn't make sense for the SEV 
> usecase.
> 
> I think the sizing of the single atomic pool needs to be determined.  Our 
> peak usage that we have measured from NVMe is ~1.4MB and atomic_pool is 
> currently sized to 256KB by default.  I'm unsure at this time if we need 
> to be able to dynamically expand this pool with a kworker.
>
> Maybe when CONFIG_AMD_MEM_ENCRYPT is enabled this atomic pool should be 
> sized to 2MB or so and then when it reaches half capacity we schedule some 
> background work to dynamically increase it?  That wouldn't be hard unless 
> the pool can be rapidly depleted.
> 

Note that a non-coherent architecture with the same workload would need
the same size.

> Do we want to increase the atomic pool size by default and then do 
> background dynamic expansion?

For now I'd just scale with system memory size.
