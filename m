Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7D122955
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLQK7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 05:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfLQK7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:59:13 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613722082E;
        Tue, 17 Dec 2019 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576580353;
        bh=earumEdZNTDpsNDpvOr9SXNYoRmK3/hYz59yXC3bFyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyrwcL0j1bZOE032d+pitw22XQzicjfOzMcEpoT5hCmtVN5KDkPmL0xTS6Vcm/D+j
         ZpNuo/kzmAKyoR6quRCa0kEGJthxSxjXrHMZiAatvrUkitijsdhJkcSeY5gU2HEH5N
         A3an6IVm/4sCOTWgDae6L13mNYoAYQJOT2kZWtRw=
Date:   Tue, 17 Dec 2019 10:59:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: arm: Use iommu_put_resv_regions_simple()
Message-ID: <20191217105907.GA32012@willie-the-truck>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
 <20191209145007.2433144-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-3-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:50:04PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +----------
>  drivers/iommu/arm-smmu.c    | 11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
