Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94581310C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAFKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 05:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAFKtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:49:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CFCA2075A;
        Mon,  6 Jan 2020 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578307740;
        bh=KTf4Q6TMAmFP4YypppQIz+5yyzzXgPCq9NldOVTUXr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U51UUbcinc7Ku/DCDqj1MSpIsTMSmgc6k3QIbXCjTMa1HyQuVTvmINCGcrlZj7I+c
         WPV/TptbljByMQJSMd6nbmsYL8s7X/klNzDoSCfF9q36ZVGXpP6mLN1BVJQJfvOf1N
         ksMBt95Wj8aKEdygIqt3ipkKqNBrFvfOZ6TdMCj8=
Date:   Mon, 6 Jan 2020 10:48:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
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
Message-ID: <20200106104853.GA5400@willie-the-truck>
References: <20191219120352.382-1-will@kernel.org>
 <20191220161313.GA21234@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220161313.GA21234@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 05:13:13PM +0100, Joerg Roedel wrote:
> On Thu, Dec 19, 2019 at 12:03:36PM +0000, Will Deacon wrote:
> > Ard Biesheuvel (1):
> >   iommu/arm-smmu: Support SMMU module probing from the IORT
> > 
> > Greg Kroah-Hartman (1):
> >   PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()
> > 
> > Will Deacon (14):
> >   drivers/iommu: Export core IOMMU API symbols to permit modular drivers
> >   iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
> >   PCI: Export pci_ats_disabled() as a GPL symbol to modules
> >   drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
> >   iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
> >   drivers/iommu: Allow IOMMU bus ops to be unregistered
> >   Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
> >   Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
> >   iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
> >   iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
> >   iommu/arm-smmu-v3: Allow building as a module
> >   iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
> >   iommu/arm-smmu: Allow building as a module
> >   iommu/arm-smmu: Update my email address in MODULE_AUTHOR()
> > 
> >  drivers/acpi/arm64/iort.c   |   4 +-
> >  drivers/iommu/Kconfig       |  16 ++++-
> >  drivers/iommu/Makefile      |   3 +-
> >  drivers/iommu/arm-smmu-v3.c |  94 +++++++++++++++++---------
> >  drivers/iommu/arm-smmu.c    | 128 +++++++++++++++++++++++++-----------
> >  drivers/iommu/iommu-sysfs.c |   5 ++
> >  drivers/iommu/iommu.c       |  32 ++++++++-
> >  drivers/iommu/of_iommu.c    |  19 ++++--
> >  drivers/pci/ats.c           |   2 +
> >  drivers/pci/pci.c           |   1 +
> >  include/linux/iommu.h       |   4 +-
> >  11 files changed, 223 insertions(+), 85 deletions(-)
> 
> Applied, thanks.

Thanks, Joerg! I'll look into the suggestion from Greg regarding 'automatic'
setting of the module 'owner' field and send a follow-up patch if I come up
with something.

Will

