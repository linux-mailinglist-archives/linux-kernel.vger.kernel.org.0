Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB433402
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfFCPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:52:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729615AbfFCPw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0107515AB;
        Mon,  3 Jun 2019 08:52:26 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 968023F246;
        Mon,  3 Jun 2019 08:52:24 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Subject: [RFC PATCH 57/57] drivers: i2c-amd: Use driver_find_next_device() helper
Date:   Mon,  3 Jun 2019 16:50:23 +0100
Message-Id: <1559577023-558-58-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the generic helper to find the first device matching
the driver.

Cc: Elie Morisse <syniurge@gmail.com>
Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index c7fe3b4..5e4800d 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -457,18 +457,12 @@ static struct pci_driver amd_mp2_pci_driver = {
 };
 module_pci_driver(amd_mp2_pci_driver);
 
-static int amd_mp2_device_match(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 struct amd_mp2_dev *amd_mp2_find_device(void)
 {
 	struct device *dev;
 	struct pci_dev *pci_dev;
 
-	dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
-				 amd_mp2_device_match);
+	dev = driver_find_next_device(&amd_mp2_pci_driver.driver, NULL);
 	if (!dev)
 		return NULL;
 
-- 
2.7.4

