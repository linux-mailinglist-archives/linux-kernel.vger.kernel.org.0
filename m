Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A6126196
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 13:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfLSMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 07:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfLSMEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D602024650;
        Thu, 19 Dec 2019 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757061;
        bh=6Rc1r90+NZsHmspNGdC3SZJUr1ZhyG4GU4NbJn+UbJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScAdaU1fUpklI+A/7mXyfEunMCoXsvnAczSUOLH2sbfBUNN2WxiP/TKbyfI03fXjR
         Pkui+/oCeJfUZtnoh8QzSRydyyqU+vaYbgahwGNw7nXUSZhSx+LmfVPRVlAmKsXjGP
         M9XCslZDtJCPjV+AWo8kC96dekWQ1AVduS+y7RYw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 07/16] drivers/iommu: Allow IOMMU bus ops to be unregistered
Date:   Thu, 19 Dec 2019 12:03:43 +0000
Message-Id: <20191219120352.382-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus_set_iommu()' allows IOMMU drivers to register their ops for a given
bus type. Unfortunately, it then doesn't allow them to be removed, which
is necessary for modular drivers to shutdown cleanly so that they can be
reloaded later on.

Allow 'bus_set_iommu()' to take a NULL 'ops' argument, which clear the
ops pointer for the selected bus_type.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bc8edf90e729..433101f0853c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1558,6 +1558,11 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 
+	if (ops == NULL) {
+		bus->iommu_ops = NULL;
+		return 0;
+	}
+
 	if (bus->iommu_ops != NULL)
 		return -EBUSY;
 
-- 
2.24.1.735.g03f4e72817-goog

