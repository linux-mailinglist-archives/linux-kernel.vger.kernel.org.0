Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8223A6922
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfICM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:58:52 -0400
Received: from 8bytes.org ([81.169.241.247]:52972 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfICM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:58:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6786C284; Tue,  3 Sep 2019 14:58:50 +0200 (CEST)
Date:   Tue, 3 Sep 2019 14:58:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] iommu/arm-smmu-v3: Fix build error without
 CONFIG_PCI_ATS
Message-ID: <20190903125848.GC11530@8bytes.org>
References: <20190903024212.20300-1-yuehaibing@huawei.com>
 <20190903065056.17988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903065056.17988-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:50:56PM +0800, YueHaibing wrote:
> If CONFIG_PCI_ATS is not set, building fails:
> 
> drivers/iommu/arm-smmu-v3.c: In function arm_smmu_ats_supported:
> drivers/iommu/arm-smmu-v3.c:2325:35: error: struct pci_dev has no member named ats_cap; did you mean msi_cap?
>   return !pdev->untrusted && pdev->ats_cap;
>                                    ^~~~~~~
> 
> ats_cap should only used when CONFIG_PCI_ATS is defined,
> so use #ifdef block to guard this.
> 
> Fixes: bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Add arm_smmu_ats_supported() of no CONFIG_PCI_ATS
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

