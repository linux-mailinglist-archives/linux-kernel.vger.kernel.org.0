Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4739C1051B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKULtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfKULtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:40 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4C120898;
        Thu, 21 Nov 2019 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336980;
        bh=QFUkeMh2cozH/3aW8Dt6eBLsD3SxxmEo/ZkMadr5dlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+E3SA9k3JVY4mHqNt1OdB2QBv50OD/1h46PyL/Ci2wLWVR7TQ25noB3MFDFqC4y6
         iqN4OIHAJ4SvQPylMV1jpM3XYittDSPi0SNTHDicQsnwLTEE7byjsLeks197MhMOef
         57/e4dKo39fKVS5pYv7rO1QuJBt0VoyoK4uKyicw=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 06/14] drivers/iommu: Allow IOMMU bus ops to be unregistered
Date:   Thu, 21 Nov 2019 11:49:10 +0000
Message-Id: <20191121114918.2293-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index 4bfecfbbe2cf..e99704c2e06b 100644
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
2.24.0.432.g9d3f5f5b63-goog

