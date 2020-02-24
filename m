Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA3169C51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 03:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBXCWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 21:22:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:19272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXCWy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:22:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 18:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="349822976"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2020 18:22:51 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/2] perf report: Support annotation of code without symbols
Date:   Mon, 24 Feb 2020 10:22:23 +0800
Message-Id: <20200224022225.30264-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf report on stripped binaries it is currently impossible to do
annotation. The annotation state is all tied to symbols, but there are
either no symbols, or symbols are not covering all the code.

We should support the annotation functionality even without symbols.

The first patch uses al_addr to print because it's easy to dump
the instructions from this address in binary for branch mode.

The second patch supports the annotation on stripped binary.

 v3:
 ---
 Keep just the ANNOTATION_DUMMY_LEN, and remove the
 opts->annotate_dummy_len since it's the "maybe in future
 we will provide" feature.

 v2:
 ---
 Fix a crash issue when annotating an address in "unknown" object.

Jin Yao (2):
  perf util: Print al_addr when symbol is not found
  Support interactive annotation of code without symbols

 tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h     |  1 +
 tools/perf/util/sort.c         |  6 +++--
 3 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.17.1

