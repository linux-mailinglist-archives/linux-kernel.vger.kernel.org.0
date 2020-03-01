Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB4174FA7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCAUs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 15:48:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:58737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAUsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:48:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2020 12:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,505,1574150400"; 
   d="scan'208";a="233094849"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2020 12:48:24 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or code
Date:   Sun,  1 Mar 2020 12:44:21 -0800
Message-Id: <cover.1583093898.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series consists of bug fixes and code optimization for the
series https://patchwork.kernel.org/patch/11365325/

Patch 1: Relocate both pmc_core_slps0_display() and pmc_core_lpm_display()
Patch 2: Remove the duplicate if() condition to create debugfs entry
Patch 3: Add back slp_s0_offset attribute back to tgl_reg_map
Patch 4: Make pmc_core_substate_res_show() generic
Patch 5: Make pmc_core_lpm_display() generic

Changes since v1:
1) Changed the order of the patches i.e., patch 2 in v1 is made first in
   the order for v2.
2) Fixed the warnings reported by kbuild test robot.

Changes since v2:
1) Add "Make pmc_core_substate_res_show() generic" patch to v3.
2) Fixed the memory leak issue in pmc_core_lpm_display().
3) Moved patch 2 in v2 to the last in the series in v3.

Gayatri Kammela (5):
  platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
    and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
  platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create
    debugfs entry for substate_live_status_registers
  platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back to
    tgl_reg_map
  platform/x86: intel_pmc_core: Make pmc_core_substate_res_show()
    generic
  platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic
    for platforms that support sub-states

 drivers/platform/x86/intel_pmc_core.c | 148 +++++++++++++++-----------
 drivers/platform/x86/intel_pmc_core.h |   3 +-
 2 files changed, 85 insertions(+), 66 deletions(-)

base-commit: 7adb1e8aeeb5d4d88012568b2049599c1a247cf2

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
-- 
2.17.1

