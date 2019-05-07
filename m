Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0B15D93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 08:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEGGhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 02:37:39 -0400
Received: from verein.lst.de ([213.95.11.211]:57709 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfEGGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:37:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 21A4A67358; Tue,  7 May 2019 08:37:21 +0200 (CEST)
Date:   Tue, 7 May 2019 08:37:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] arm64/iommu: handle non-remapped addresses in
 ->mmap and ->get_sgtable
Message-ID: <20190507063720.GB28147@lst.de>
References: <20190430105214.24628-1-hch@lst.de> <20190430105214.24628-2-hch@lst.de> <20190503113352.GA55449@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503113352.GA55449@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:33:53PM +0100, Catalin Marinas wrote:
> On Tue, Apr 30, 2019 at 06:51:50AM -0400, Christoph Hellwig wrote:
> > DMA allocations that can't sleep may return non-remapped addresses, but
> > we do not properly handle them in the mmap and get_sgtable methods.
> > Resolve non-vmalloc addresses using virt_to_page to handle this corner
> > case.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Given that this is a bug fix mostly separate from the rest of the
series - do you want to pick it up for 5.2 and maybe add a Cc for
stable?
