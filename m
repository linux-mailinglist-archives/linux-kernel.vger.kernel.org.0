Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD1165452
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgBTBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 20:36:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:8059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgBTBgz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:36:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 17:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="259114739"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2020 17:36:52 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 0/3] perf report: Support sorting by a given event in group
Date:   Thu, 20 Feb 2020 09:36:13 +0800
Message-Id: <20200220013616.19916-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing "perf report --group", it shows the event group information
together. By default, the output is sorted by the first event in group.
It would be nice for user to select any event for sorting.

The patch 1/3 introduces a new option "--group-sort-idx" to sort the
output by the event at the index n in event group.

The patch 2/3 creates a new key K_RELOAD to reload the browser.

The patch 3/3 supports hotkeys in browser to select a event to
sort.

 v7:
 ---
 v6 was posted two months ago and all comments were fixed.

 v7 just rebases to perf/core, no other change.

Jin Yao (3):
  perf report: Change sort order by a specified event in group
  perf report: Support a new key to reload the browser
  perf report: support hotkey to let user select any event for sorting

 tools/perf/Documentation/perf-report.txt |   5 ++
 tools/perf/builtin-report.c              |  16 +++-
 tools/perf/ui/browsers/hists.c           |  29 ++++++-
 tools/perf/ui/hist.c                     | 104 +++++++++++++++++++----
 tools/perf/ui/keysyms.h                  |   1 +
 tools/perf/util/hist.h                   |   1 +
 tools/perf/util/symbol_conf.h            |   1 +
 7 files changed, 138 insertions(+), 19 deletions(-)

-- 
2.17.1

