Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6DD323C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 22:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfJJU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 16:29:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:30892 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfJJU35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:29:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 13:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="277902018"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2019 13:29:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH 00/10] intel-speed-select tool updates targetted for 5.5
Date:   Thu, 10 Oct 2019 13:29:35 -0700
Message-Id: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no new patches in this series. This is just for clean apply on
5.4-rc1 for Andriy.

This is combination of two series of patches sent on 07th Oct, 2019.
Those two series were:
- [PATCH v2 0/3] tools/power/x86/intel-speed-select: Auto mode
- [PATCH v3 0/6]  Add CascadeLake-N Support



Prarit Bhargava (6):
  tools/power/x86/intel-speed-select: Add int argument to command
    functions
  tools/power/x86/intel-speed-select: Make process_command generic
  tools/power/x86/intel-speed-select: Add check for CascadeLake-N models
  tools/power/x86/intel-speed-select: Implement CascadeLake-N help and
    command functions structures
  tools/power/x86/intel-speed-select: Implement 'perf-profile info' on
    CascadeLake-N
  tools/power/x86/intel-speed-select: Implement base-freq commands on
    CascadeLake-N

Srinivas Pandruvada (4):
  tools/power/x86/intel-speed-select: Remove warning for unused result
  tools/power/x86/intel-speed-select: Base-freq feature auto mode
  tools/power/x86/intel-speed-select: Turbo-freq feature auto mode
  tools/power/x86/intel-speed-select: Refuse to disable core-power when
    getting used

 .../x86/intel-speed-select/isst-config.c      | 878 ++++++++++++++----
 .../power/x86/intel-speed-select/isst-core.c  |  21 +
 .../x86/intel-speed-select/isst-display.c     |  14 +-
 tools/power/x86/intel-speed-select/isst.h     |   3 +
 4 files changed, 738 insertions(+), 178 deletions(-)

-- 
2.17.2

