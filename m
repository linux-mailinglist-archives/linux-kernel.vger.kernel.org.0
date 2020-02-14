Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9315D867
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 14:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgBNN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 08:27:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:26521 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNN1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:27:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 05:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="347954658"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2020 05:27:49 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: [PATCH 0/5] perf tools: fix endless record after being terminated
Date:   Fri, 14 Feb 2020 15:26:49 +0200
Message-Id: <20200214132654.20395-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Wei Li sent some fixes.  I have tweaked them a bit, and added a tidy-up
patch.


Adrian Hunter (2):
      perf tools: arm-spe: fix endless record after being terminated
      perf auxtrace: Add auxtrace_record__read_finish()

Wei Li (3):
      perf tools: intel-pt: fix endless record after being terminated
      perf tools: intel-bts: fix endless record after being terminated
      perf tools: cs-etm: fix endless record after being terminated

 tools/perf/arch/arm/util/cs-etm.c    | 18 ++----------------
 tools/perf/arch/arm64/util/arm-spe.c | 17 ++---------------
 tools/perf/arch/x86/util/intel-bts.c | 17 ++---------------
 tools/perf/arch/x86/util/intel-pt.c  | 17 ++---------------
 tools/perf/util/auxtrace.c           | 22 +++++++++++++++++++++-
 tools/perf/util/auxtrace.h           |  6 ++++++
 6 files changed, 35 insertions(+), 62 deletions(-)


Regards
Adrian
