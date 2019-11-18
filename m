Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC4100BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKRTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 14:05:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:26776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfKRTFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="215357900"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.161])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 11:05:46 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1 0/2] platform/x86: intel_pmc_core: Add Comet Lake
Date:   Mon, 18 Nov 2019 11:05:39 -0800
Message-Id: <cover.1574102528.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1: Fix SoC naming inconsistency
Patch 2: Add Comet Lake legacy support to pmc_core

Gayatri Kammela (2):
  platform/x86: intel_pmc_core: Fix the SoC naming inconsistency
  platform/x86: intel_pmc_core: Add Comet Lake (CML) platform support to
     intel_pmc_core driver

 drivers/platform/x86/intel_pmc_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>

-- 
2.17.1

