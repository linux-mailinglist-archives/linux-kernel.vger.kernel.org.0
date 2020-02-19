Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5890163DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBSHkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 02:40:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:51863 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgBSHkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:40:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 23:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="348882469"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2020 23:40:45 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v5 0/2] intel: Add a new driver for a new clock controller IP
Date:   Wed, 19 Feb 2020 15:40:41 +0800
Message-Id: <cover.1582096982.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds clock driver for Clock Generation Unit(CGU) of
Lightning Mountain(LGM) SoC.

Patch 1 adds bindings document & include file for CGU.
Patch 2 adds common clock framework based clock driver for CGU.

These patches are baselined upon Linux 5.6-rc1 at below Git link:
git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

v5:
- Address review concerns - mainly below mentioned. (Stephen Boyd)
- Improve commit message, add COMPILE_TEST in KConfig dependency.
- Remove unused header include files, drop unnecessary casts.
- Switch to using readl_poll_timeout() instead of implementing timeout routine.
- Avoid using small functions which are called just once. Inline them or
  remove them.
- const static --> static const
- Fix coding style/convention related review concerns.
- Use __iomem for all IO addresses variables.
- Consolidate clk_enable & clk_disable ops into a common clk_enable_disable
  routine to avoid redundant code.
- Remove unnecessary dev pointers for clk data structures.
- Redesign code to use new way of specifying clk_parents i.e. use
  clk_parent_data.fw_name instead of older parent_name strings.
- Switch from raw_spin_locks() to normal spin_locks() and realign locking.
- Drop __initconst, __init, __refdata.
- Reorder patch series - make dt-binding patch as first patch.
- Add pointer to include file in dt-bindings document.
- Remove CLK_IS_CRITICAL flag for clks for which IGNORE_UNUSED flag is enough.
  Add comments for clks which are marked as CRITICAL.
- Fix $id path in dt-bindings - drop bindings. (Rob Herring).
- Add Reviewed-by tag from Rob Herring. Thanks Rob.

v4:
- Add drivers/clk/x86/Kconfig file which got missed in v3 by mistake.

v3:
- Address review concerns:
  Add Kconfig entry in x86 folder instead of modifying clk/Kconfig. (Andy Shevchenko)
  Fix coding style/convention related concerns. (Andy Shevchenko)
  Improve description, licensing info, rename node name correctly in dt bindings
  document & remove CLK_NR_CLKS from dt-bindings header file. (Stephen Boyd)
  Fix a build warning reported by kbuild test robot & Nathan Chancellor
- Add few new clocks & rename few existing clocks.
- Add more ops for ddiv & divider clk_ops.
- Fix few minor bugs.
- Use CLK_IS_CRITICAL flag for clocks which shall never be disabled.

v2:
- Move the driver to x86 folder.
- Remove syscon usage.
- Remove regmap based access. Use direct readl()/write() instead. Add spinlocks.
- Change all enum values to capitals.
- Rename all data structures & functions from intel_* to lgm_*.
- Remove multiple header files. Keep only one header file.
- Make probe fail when any of the clk/pll registration fails.
- Fix few bugs with clk_init_data assignement.
- Address review concerns for code quality/style/convention.

v1:
- Initial version.

Rahul Tanwar (1):
  dt-bindings: clk: intel: Add bindings document & header file for CGU

rtanwar (1):
  clk: intel: Add CGU clock driver for a new SoC

 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  44 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/x86/Kconfig                            |   8 +
 drivers/clk/x86/Makefile                           |   1 +
 drivers/clk/x86/clk-cgu-pll.c                      | 156 +++++
 drivers/clk/x86/clk-cgu.c                          | 636 +++++++++++++++++++++
 drivers/clk/x86/clk-cgu.h                          | 335 +++++++++++
 drivers/clk/x86/clk-lgm.c                          | 492 ++++++++++++++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 165 ++++++
 9 files changed, 1838 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 drivers/clk/x86/Kconfig
 create mode 100644 drivers/clk/x86/clk-cgu-pll.c
 create mode 100644 drivers/clk/x86/clk-cgu.c
 create mode 100644 drivers/clk/x86/clk-cgu.h
 create mode 100644 drivers/clk/x86/clk-lgm.c
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

-- 
2.11.0

