Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA614B484
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1M40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 07:56:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:39253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgA1M40 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:56:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 04:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="309073684"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2020 04:56:23 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 0/4] perf: Refactor the block info implementation
Date:   Tue, 28 Jan 2020 20:55:52 +0800
Message-Id: <20200128125556.25498-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the block info functionalities to let them
be used by other builtins and allow setting the output fmts flexibly.

It also supports the 'Sampled Cycles%' and 'Avg Cycles%' printed in
colors.

 v5:
 ---
 Only change the patch "perf util: Flexible to set block info output formats".
 Other patches are not changed.

Jin Yao (4):
  perf util: Move block_pair_cmp to block-info
  perf util: Validate map/dso/sym before comparing blocks
  perf util: Flexible to set block info output formats
  perf util: Support color ops to print block percents in color

 tools/perf/builtin-diff.c    | 17 -------
 tools/perf/builtin-report.c  | 21 ++++++--
 tools/perf/util/block-info.c | 99 ++++++++++++++++++++++++++----------
 tools/perf/util/block-info.h |  9 +++-
 4 files changed, 99 insertions(+), 47 deletions(-)

-- 
2.17.1

