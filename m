Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A978D170EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 03:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgB0Crc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 21:47:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:47772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgB0Crc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:47:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 18:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="438670598"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2020 18:47:31 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1 0/4] platform/x86: intel_pmc_core: Add bug fixes or code
Date:   Wed, 26 Feb 2020 18:43:26 -0800
Message-Id: <cover.1582770011.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series consists of bug fixes and code optimization for the
series https://patchwork.kernel.org/patch/11365325/

Patch 1: Make pmc_core_lpm_display() generic
Patch 2: Relocate both pmc_core_slps0_display() and pmc_core_lpm_display()
Patch 3: Remove the duplicate if() condition to create debugfs entry
Patch 4: Add back slp_s0_offset attribute back to tgl_reg_map

Gayatri Kammela (4):
  platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic
    for platforms that support sub-states
  platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
    and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
  platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create
    debugfs entry for substate_live_status_registers
  platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back to
    tgl_reg_map

 drivers/platform/x86/intel_pmc_core.c | 131 +++++++++++++-------------
 1 file changed, 66 insertions(+), 65 deletions(-)

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
-- 
2.17.1

