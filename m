Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D48F873D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 05:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKLEGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 23:06:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:34570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfKLEGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 23:06:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 20:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="202576660"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.161])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2019 20:06:48 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 5/6] platform/x86: Add Tiger Lake (TGL) platform support to intel_pmc_core driver
Date:   Mon, 11 Nov 2019 20:06:30 -0800
Message-Id: <2aeaffd3e053d20ec93df407b3b9f7f8a68ffe08.1573529092.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573529092.git.gayatri.kammela@intel.com>
References: <cover.1573529092.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1573529092.git.gayatri.kammela@intel.com>
References: <cover.1573529092.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tiger Lake to the list of the platforms that intel_pmc_core driver
supports for the pmc_core device.

Just like Ice Lake, Tiger Lake can also reuse all the Cannon Lake PCH
IPs. Since Tiger Lake has almost the same number of PCH IPs as Ice Lake,
reuse Ice Lake's PPFEAR_NUM_ENTRIES instead of defining a new macro.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 40 +++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index fa91f3127460..b708c04db752 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -190,7 +190,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"SDX",                 BIT(4)},
 	{"SPE",                 BIT(5)},
 	{"Fuse",                BIT(6)},
-	/* Reserved for Cannon Lake but valid for Ice Lake */
+	/* Reserved for Cannon Lake but valid for Ice Lake and Tiger Lake */
 	{"SBR8",		BIT(7)},
 
 	{"CSME_FSC",            BIT(0)},
@@ -234,7 +234,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD4",            BIT(2)},
 	{"HDA_PGD5",            BIT(3)},
 	{"HDA_PGD6",            BIT(4)},
-	/* Reserved for Cannon Lake but valid for Ice Lake */
+	/* Reserved for Cannon Lake but valid for Ice Lake and Tiger Lake */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
@@ -265,6 +265,24 @@ static const struct pmc_bit_map *ext_icl_pfear_map[] = {
 	NULL
 };
 
+static const struct pmc_bit_map tgl_pfear_map[] = {
+	/* Tiger Lake generation onwards only */
+	{"PSF9",		BIT(0)},
+	{"RES_66",		BIT(1)},
+	{"RES_67",		BIT(2)},
+	{"RES_68",		BIT(3)},
+	{"RES_69",		BIT(4)},
+	{"RES_70",		BIT(5)},
+	{"TBTLSX",		BIT(6)},
+	{}
+};
+
+static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
+	cnp_pfear_map,
+	tgl_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{"AUDIO_D3",		BIT(0)},
 	{"OTG_D3",		BIT(1)},
@@ -383,6 +401,22 @@ static const struct pmc_reg_map icl_reg_map = {
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
 };
 
+static const struct pmc_reg_map tgl_reg_map = {
+	.pfear_sts = ext_tgl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
+};
+
 static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
 {
 	return readb(pmcdev->regbase + offset);
@@ -836,6 +870,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
+	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
+	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
 	{}
 };
 
-- 
2.17.1

