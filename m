Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D38EA94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfD2TBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 15:01:38 -0400
Received: from verein.lst.de ([213.95.11.211]:40574 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfD2TBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:01:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 978DE68AFE; Mon, 29 Apr 2019 21:01:20 +0200 (CEST)
Date:   Mon, 29 Apr 2019 21:01:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Message-ID: <20190429190120.GA5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-3-hch@lst.de> <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 01:35:46PM +0100, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> The nr_pages checks should be done for all mmap requests, not just those
>> using remap_pfn_range.
>
> I think it probably makes sense now to just squash this with #22 one way or 
> the other, but if you really really still want to keep it as a separate 
> patch with a misleading commit message then I'm willing to keep my 
> complaints to myself :)

Well, I split this out in response to your earlier comments, so if you
prefer it squasheѕ back in I can do that..
