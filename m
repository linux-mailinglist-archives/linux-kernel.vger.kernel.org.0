Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7004818D301
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCTPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCTPfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:35:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112912070A;
        Fri, 20 Mar 2020 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584718524;
        bh=PCMtCPWpgRJ4SJUtOrkrxxNkDVKdaN+ir2Ppk0Q6Dig=;
        h=Date:From:To:Cc:Subject:From;
        b=ZnbSRZUXjKZ/oVvf1zRUFVbw8Ehqux0gkX2zaKJ6khisHbkvmeQKxrZSGQOlzDSSI
         YcTff5BxuARj7/zu5Ezmam39siZsUv9vyI1A6SWob82GkM101PbnTp2/xzyW7N1e+7
         mSG/91kWrfvQPMlbptIWr8sBmadoiDDVb4f+SWkg=
Date:   Fri, 20 Mar 2020 15:35:20 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.7
Message-ID: <20200320153519.GB6815@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.7. The summary is in the tag (which
you may need to re-fetch if you've got my tree added as a remote).

Cheers,

Will

--->8

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 6a481a95d4c198a2dd0a61f8877b92a375757db8:

  iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support (2020-03-18 21:37:10 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.7

- Support for the TLB range invalidation command in SMMUv3.2

- Introduction of command batching helpers...

- ... which are then used to batch up CD and ATC invalidation

- Support for PCI PASID, along with necessary PCI symbol exports

- MAINTAINERS update to include DT binding docs

----------------------------------------------------------------
Jean-Philippe Brucker (5):
      PCI/ATS: Export symbols of PASID functions
      iommu/arm-smmu-v3: Add support for PCI PASID
      iommu/arm-smmu-v3: Write level-1 descriptors atomically
      iommu/arm-smmu-v3: Add command queue batching helpers
      iommu/arm-smmu-v3: Batch context descriptor invalidation

Rob Herring (2):
      iommu/arm-smmu-v3: Batch ATC invalidation commands
      iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support

Robin Murphy (1):
      MAINTAINERS: Cover Arm SMMU DT bindings

 MAINTAINERS                 |   1 +
 drivers/iommu/arm-smmu-v3.c | 204 ++++++++++++++++++++++++++++++++++++++------
 drivers/pci/ats.c           |   4 +
 3 files changed, 181 insertions(+), 28 deletions(-)
