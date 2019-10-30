Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEEE9DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJ3Ov0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3OvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:24 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7ED2087F;
        Wed, 30 Oct 2019 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572447084;
        bh=uJ+ONkF7na6HukF09Y5O+tCeYJzoiaeeldARCnkP778=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbqeDhkOGkfRqL2AQ/1gpM9OKF9XhJuB/UP3bVnhIXyJzPuVTe/XN2YZT7US7Fbil
         rN3L5Ph3uQTJZTjcxaDLfi/dGi/RjWjVaSPjZbGwfHMXTx+/MUKng67OPVZC43gtUk
         ZyMaCBWuEQrtZrmNMqbUsF60JHTEkxJuQJefDrDU=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3/7] PCI: Export pci_ats_disabled() as a GPL symbol to modules
Date:   Wed, 30 Oct 2019 14:51:08 +0000
Message-Id: <20191030145112.19738-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building drivers for ATS-aware IOMMUs as modules requires access to
pci_ats_disabled(). Export it as a GPL symbol to get things working.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..4fbe5b576dd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
 }
+EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
-- 
2.24.0.rc0.303.g954a862665-goog

