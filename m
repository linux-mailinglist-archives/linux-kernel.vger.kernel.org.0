Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C4E9DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfJ3OvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3OvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:22 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67412173E;
        Wed, 30 Oct 2019 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572447082;
        bh=pRODZ6zh4eXRE4Y4JwFU3ZKHlgD9TQRTXk+jdqEMR/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11FfZgDS1Kc++XBDo7UDXjFBbBwL6SQAX8nqkTaY/71fiz5LlcV7qu5FQHY3WEZrg
         TQudhggghLGvkoEusSH8lQ9yOKUbko6SaA2wJk/dRJB7MBPXQLT1k45czTG2yAIQb/
         sRnkWFddLobRZwVnUTZpqx5J3VtVrhRdM7nah8bI=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/7] iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
Date:   Wed, 30 Oct 2019 14:51:07 +0000
Message-Id: <20191030145112.19738-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid having to export 'pci_request_acs()' to modular IOMMU drivers,
move the call into the 'of_dma_configure()' path in a similar manner to
the way in which ACS is configured when probing via ACPI/IORT.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..78faa9f73a91 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -177,6 +177,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
+		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else if (dev_is_fsl_mc(dev)) {
-- 
2.24.0.rc0.303.g954a862665-goog

