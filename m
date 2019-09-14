Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB55B2CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfINTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 15:45:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:27815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfINTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:45:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,506,1559545200"; 
   d="scan'208";a="201286914"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2019 12:45:49 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/5] tools/power/x86/intel-speed-select: New command and
Date:   Sat, 14 Sep 2019 12:45:42 -0700
Message-Id: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some minor fixes, when firmware mask is including
invalid CPU in the perf-profile mask. Also add some commands to
better manage core-power feature.

v2:
Add exit(0) for invalid argument when -c/--cpu not specified for new
clos commands.
Fix online/offline based on TDP change to only do for local die or
package.

Srinivas Pandruvada (4):
  tools/power/x86/intel-speed-select: Allow online/offline based on tdp
  tools/power/x86/intel-speed-select: Format get-assoc information
  tools/power/x86/intel-speed-select: Fix some debug prints
  tools/power/x86/intel-speed-select: Extend core-power command set

Youquan Song (1):
  tools/power/x86/intel-speed-select: Fix high priority core mask over
    count

 .../x86/intel-speed-select/isst-config.c      | 118 ++++++++++++++++--
 .../power/x86/intel-speed-select/isst-core.c  |  25 ++++
 .../x86/intel-speed-select/isst-display.c     |  51 ++++++++
 tools/power/x86/intel-speed-select/isst.h     |   9 +-
 4 files changed, 190 insertions(+), 13 deletions(-)

-- 
2.17.2

