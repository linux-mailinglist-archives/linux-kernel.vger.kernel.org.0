Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0016004A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 06:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGEEzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 00:55:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGEEzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:55:10 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hjGFX-0005HR-D5; Fri, 05 Jul 2019 04:55:07 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     lee.jones@linaro.org
Cc:     jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] mfd: intel-lpss: Remove D3cold delay
Date:   Fri,  5 Jul 2019 12:55:03 +0800
Message-Id: <20190705045503.13379-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix touchpad may drop its first couple input events when
i2c-designware-platdrv and intel-lpss it connects to took too long to
runtime resume from runtime suspended state.

This issue happens becuase the touchpad has a rather small buffer to
store up to 13 input events, so if the host doesn't read those events in
time (i.e. runtime resume takes too long), events are dropped from the
touchpad's buffer.

The bottleneck is D3cold delay it waits when transitioning from D3cold
to D0, hence remove the delay to make the resume faster. I've tested
some systems with intel-lpss and haven't seen any regression.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202683
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index aed2c0447966..3c271b14e7c6 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -35,6 +35,8 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
+	pdev->d3cold_delay = 0;
+
 	/* Probably it is enough to set this for iDMA capable devices only */
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
-- 
2.17.1

