Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403C3166D17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgBUCqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 21:46:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:38414 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgBUCqr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:46:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 18:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="259488888"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2020 18:46:44 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/2] perf report: Support annotation of code without symbols
Date:   Fri, 21 Feb 2020 10:46:06 +0800
Message-Id: <20200221024608.1847-1-yao.jin@linux.intel.com>
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

 v2:
 ---
 Fix a crash issue when annotating an address in "unknown" object.

Jin Yao (2):
  perf util: Print al_addr when symbol is not found
  perf annotate: Support interactive annotation of code without symbols

 tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h     |  2 ++
 tools/perf/util/sort.c         |  6 ++--
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.17.1

