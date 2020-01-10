Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92B1377D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgAJUSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:18:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:5305 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgAJUSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:18:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 12:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="232013478"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2020 12:18:44 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add PCI ID of IMC for Xeon E3 V5 Family
Date:   Fri, 10 Jan 2020 12:15:11 -0800
Message-Id: <1578687311-158748-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The IMC uncore support is missed for E3-1585 v5 CPU.

Intel Xeon E3 V5 Family has Sky Lake CPU.
Add the PCI ID of IMC for Intel Xeon E3 V5 Family.

Reported-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Tested-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index dbaa1b0..c37cb12 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,7 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC		0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC		0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC		0x191f
+#define PCI_DEVICE_ID_INTEL_SKL_E3_IMC		0x1918
 #define PCI_DEVICE_ID_INTEL_KBL_Y_IMC		0x590c
 #define PCI_DEVICE_ID_INTEL_KBL_U_IMC		0x5904
 #define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
@@ -658,6 +659,10 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
 	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_E3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
@@ -826,6 +831,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(SKL_E3_IMC, &skl_uncore_pci_driver),  /* Xeon E3 V5 Gen Core processor */
 	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
 	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
 	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
-- 
2.7.4

