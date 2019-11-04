Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DDEDD3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 06:03:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:13206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKDLDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021208"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:07 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 00/10] tools/power/x86/intel-speed-select: New version
Date:   Mon,  4 Nov 2019 03:02:36 -0800
Message-Id: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the new version of Intel(R) Speed select
implementation. Also some fixes for CLX-N platform.

Srinivas Pandruvada (10):
  tools/power/x86/intel-speed-select: Extend command set for
    perf-profile
  tools/power/x86/intel-speed-select: Change display of "avx" to "avx2"
  tools/power/x86/intel-speed-select: Correct CLX-N frequency units
  tools/power/x86/intel-speed-select: Auto mode for CLX
  tools/power/x86/intel-speed-select: Use mailbox for CLOS_PM_QOS_CONFIG
  tools/power/x86/intel-speed-select: Make CLOS frequency in MHz
  tools/power/x86/intel-speed-select: Use Frequency weight for CLOS
  tools/power/x86/intel-speed-select: Support platform with limited
    Intel(R) Speed Select
  tools/power/x86/intel-speed-select: Use core count for base-freq mask
  tools/power/x86/intel-speed-select: Increment version

 .../x86/intel-speed-select/isst-config.c      | 178 ++++++++++++++----
 .../power/x86/intel-speed-select/isst-core.c  | 146 ++++++++++++--
 .../x86/intel-speed-select/isst-display.c     | 139 +++++++++-----
 tools/power/x86/intel-speed-select/isst.h     |   2 +
 4 files changed, 366 insertions(+), 99 deletions(-)

-- 
2.17.2

