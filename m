Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5D5E7F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 11:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:36:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21FA2184C;
        Wed,  3 Jul 2019 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562168182;
        bh=VgVHx4Wl4zyB9pq9YgDJziUdAcgS2ewl0rgPuenCJjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMmQIykXtTfnKfb+48nX8lCEAxaggSbdYI0pZ49zrseNTBvZuYY6AcnTqqGvmsXLS
         LfGxg1KRSptZLP4rRoTV12rkN55KW5Z0s+FTmPV66jVQIW3doe1Bj54H6tN9O1aAr7
         tI3wiFM9z2ehpCzLMxYBF4JdLndy6h3NcojPXoyI=
Date:   Wed, 3 Jul 2019 17:36:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: Re: [GIT PULL 3/4] intel_th: msu: Fix single mode with disabled IOMMU
Message-ID: <20190703153619.GB22834@kroah.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
 <20190621161930.60785-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621161930.60785-4-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 07:19:29PM +0300, Alexander Shishkin wrote:
> Commit 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU") switched
> the single mode code to use dma mapping pages obtained from the page
> allocator, but with IOMMU disabled, that may lead to using SWIOTLB bounce
> buffers and without additional sync'ing, produces empty trace buffers.
> 
> Fix this by using a DMA32 GFP flag to the page allocation in single mode,
> as the device supports full 32-bit DMA addressing.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reported-by: Ammy Yi <ammy.yi@intel.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You should have had a stable tag on here anyway...
