Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDA9FB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfH1HAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:00:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:26509 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfH1HAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:00:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 00:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="356016369"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2019 00:00:20 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@vger.kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 0/2] clk: intel: Add a new driver for a new clock controller IP
Date:   Wed, 28 Aug 2019 15:00:16 +0800
Message-Id: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A forthcoming Intel network processor SoC uses a new Clock Generation Unit(CGU)
IP for clock controller. This series adds the clock driver for CGU.

Patch 1 adds common clock framework based clock driver for CGU.
Patch 2 adds bindings document & include file for CGU.

These patches are baselined upon Linux 5.3-rc1 at below Git link:
git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git


Rahul Tanwar (1):
  dt-bindings: clk: intel: Add bindings document & header file for CGU

rtanwar (1):
  clk: intel: Add CGU clock driver for a new SoC

 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  61 +++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/intel/Kconfig                          |  13 +
 drivers/clk/intel/Makefile                         |   4 +
 drivers/clk/intel/clk-cgu-pll.c                    | 160 ++++++
 drivers/clk/intel/clk-cgu-pll.h                    |  24 +
 drivers/clk/intel/clk-cgu.c                        | 544 +++++++++++++++++++++
 drivers/clk/intel/clk-cgu.h                        | 278 +++++++++++
 drivers/clk/intel/clk-lgm.c                        | 352 +++++++++++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 150 ++++++
 11 files changed, 1588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 drivers/clk/intel/Kconfig
 create mode 100644 drivers/clk/intel/Makefile
 create mode 100644 drivers/clk/intel/clk-cgu-pll.c
 create mode 100644 drivers/clk/intel/clk-cgu-pll.h
 create mode 100644 drivers/clk/intel/clk-cgu.c
 create mode 100644 drivers/clk/intel/clk-cgu.h
 create mode 100644 drivers/clk/intel/clk-lgm.c
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

-- 
2.11.0

