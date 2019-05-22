Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02DC2677C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfEVP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:57:32 -0400
Received: from verein.lst.de ([213.95.11.211]:40332 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfEVP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:57:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 35D7268B05; Wed, 22 May 2019 17:57:09 +0200 (CEST)
Date:   Wed, 22 May 2019 17:57:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/24] iommu/dma: Move domain lookup into
 __iommu_dma_{map, unmap}
Message-ID: <20190522155708.GA29904@lst.de>
References: <20190520072948.11412-1-hch@lst.de> <20190520072948.11412-8-hch@lst.de> <b2ef2d14-ec58-a1d6-1741-7834840498ee@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ef2d14-ec58-a1d6-1741-7834840498ee@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:34:49PM +0100, Robin Murphy wrote:
> On 20/05/2019 08:29, Christoph Hellwig wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Most of the callers don't care, and the couple that do already have the
>> domain to hand for other reasons are in slow paths where the (trivial)
>> overhead of a repeated lookup will be utterly immaterial.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [hch: dropped the hunk touching iommu_dma_get_msi_page to avoid a
>>   conflict with another series]
>
> Since the MSI changes made it into 5.2, do you want to resurrect that hunk 
> here, or shall I spin it up as a follow-on patch?

Either way is fine with me.
