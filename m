Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A737CFE1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJHPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:52:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:21581 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfJHPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 08:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277134991"
Received: from otc-lr-04.jf.intel.com ([10.54.39.120])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 08:52:09 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/9] perf: Several update for Comet Lake, Ice Lake and Tiger Lake
Date:   Tue,  8 Oct 2019 08:50:01 -0700
Message-Id: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Comet Lake is the new 10th Gen Intel processor. Add Comet Lake to Intel family.
From the perspective of Intel core PMU, there is nothing changed compared with
Sky Lake. Share the perf code with Sky Lake.
Add support for perf msr and cstate driver as well.

Tiger Lake is the followon to Ice Lake.
From the perspective of Intel core PMU, there is little changes compared with
Ice Lake, e.g. small changes in the event list. But it doesn't impact on core
PMU functionality. Share the perf code with Ice Lake.
Add support for perf msr and cstate driver as well.

Both are verified on real hardware.

Also, update perf msr and cstate driver for Ice Lake.

Kan Liang (9):
  x86/cpu: Add Comet Lake to Intel family
  perf/x86/intel: Add Comet Lake CPU support
  perf/x86/msr: Add Comet Lake CPU support
  perf/x86/cstate: Add Comet Lake CPU support
  perf/x86/msr: Add more CPU model number for Ice Lake
  perf/x86/cstate: Update C-state counters for Ice Lake
  perf/x86/intel: Add Tiger Lake CPU support
  perf/x86/msr: Add Tiger Lake CPU support
  perf/x86/cstate: Add Tiger Lake CPU support

 arch/x86/events/intel/core.c        |  4 ++++
 arch/x86/events/intel/cstate.c      | 44 +++++++++++++++++++++++++++----------
 arch/x86/events/msr.c               |  7 ++++++
 arch/x86/include/asm/intel-family.h |  3 +++
 4 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.7.4

