Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76383D4777
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfJKSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 14:21:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:23224 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfJKSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:21:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 11:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="198776959"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2019 11:21:42 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 73B6B3000EF; Fri, 11 Oct 2019 11:21:42 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf evlist: Fix fix for freed id arrays
Date:   Fri, 11 Oct 2019 11:21:40 -0700
Message-Id: <20191011182140.8353-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011182140.8353-1-andi@firstfloor.org>
References: <20191011182140.8353-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In the earlier fix for the memory overrun of id arrays I managed
to typo the wrong event in the fix.

Of course we need to close the current event in the loop, not the
original failing event.

The same test case as in the original patch still passes.

Fixes: 7834fa948beb ("perf evlist: Fix access of freed id arrays")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e33b46aca5cb..2f8ac60af76b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1728,7 +1728,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				perf_evsel__close(&evsel->core);
+				perf_evsel__close(&c2->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
-- 
2.21.0

