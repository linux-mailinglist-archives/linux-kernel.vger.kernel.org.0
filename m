Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D067EA443
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 20:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJ3Tbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 15:31:51 -0400
Received: from 8bytes.org ([81.169.241.247]:50098 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3Tbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:31:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0CD73148; Wed, 30 Oct 2019 20:31:48 +0100 (CET)
Date:   Wed, 30 Oct 2019 20:31:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191030193148.GA8432@8bytes.org>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-6-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Oct 30, 2019 at 02:51:10PM +0000, Will Deacon wrote:
> By removing the redundant call to 'pci_request_acs()' we can allow the
> ARM SMMUv3 driver to be built as a module.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/Kconfig       | 2 +-
>  drivers/iommu/arm-smmu-v3.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..7583d47fc4d5 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -388,7 +388,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	  config.
>  
>  config ARM_SMMU_V3
> -	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> +	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>  	depends on ARM64
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAEa

Sorry for the stupid question, but what prevents the iommu module from
being unloaded when there are active users? There are no symbol
dependencies to endpoint device drivers, because the interface is only
exposed through the iommu-api, right? Is some sort of manual module
reference counting needed?


	Joerg

