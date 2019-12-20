Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88A8128065
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 11:13:18 -0500
Received: from 8bytes.org ([81.169.241.247]:58406 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfLTQNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:13:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B7E12495; Fri, 20 Dec 2019 17:13:16 +0100 (CET)
Date:   Fri, 20 Dec 2019 17:13:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org,
        kernel-team@android.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3]
 drivers
Message-ID: <20191220161313.GA21234@8bytes.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219120352.382-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:03:36PM +0000, Will Deacon wrote:
> Ard Biesheuvel (1):
>   iommu/arm-smmu: Support SMMU module probing from the IORT
> 
> Greg Kroah-Hartman (1):
>   PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()
> 
> Will Deacon (14):
>   drivers/iommu: Export core IOMMU API symbols to permit modular drivers
>   iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
>   PCI: Export pci_ats_disabled() as a GPL symbol to modules
>   drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
>   iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
>   drivers/iommu: Allow IOMMU bus ops to be unregistered
>   Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
>   Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
>   iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
>   iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
>   iommu/arm-smmu-v3: Allow building as a module
>   iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
>   iommu/arm-smmu: Allow building as a module
>   iommu/arm-smmu: Update my email address in MODULE_AUTHOR()
> 
>  drivers/acpi/arm64/iort.c   |   4 +-
>  drivers/iommu/Kconfig       |  16 ++++-
>  drivers/iommu/Makefile      |   3 +-
>  drivers/iommu/arm-smmu-v3.c |  94 +++++++++++++++++---------
>  drivers/iommu/arm-smmu.c    | 128 +++++++++++++++++++++++++-----------
>  drivers/iommu/iommu-sysfs.c |   5 ++
>  drivers/iommu/iommu.c       |  32 ++++++++-
>  drivers/iommu/of_iommu.c    |  19 ++++--
>  drivers/pci/ats.c           |   2 +
>  drivers/pci/pci.c           |   1 +
>  include/linux/iommu.h       |   4 +-
>  11 files changed, 223 insertions(+), 85 deletions(-)

Applied, thanks.
