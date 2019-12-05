Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C381139AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 03:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLECPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 21:15:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:44502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147650"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:41 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 1/6] x86/mm: Remove second argument of split_mem_range()
Date:   Thu,  5 Dec 2019 10:13:58 +0800
Message-Id: <20191205021403.25606-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument is always zero.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e7bb483557c9..916a3d9b5bfd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -333,13 +333,13 @@ static const char *page_size_string(struct map_range *mr)
 	return str_4k;
 }
 
-static int __meminit split_mem_range(struct map_range *mr, int nr_range,
+static int __meminit split_mem_range(struct map_range *mr,
 				     unsigned long start,
 				     unsigned long end)
 {
 	unsigned long start_pfn, end_pfn, limit_pfn;
 	unsigned long pfn;
-	int i;
+	int i, nr_range = 0;
 
 	limit_pfn = PFN_DOWN(end);
 
@@ -477,7 +477,7 @@ unsigned long __ref init_memory_mapping(unsigned long start,
 	       start, end - 1);
 
 	memset(mr, 0, sizeof(mr));
-	nr_range = split_mem_range(mr, 0, start, end);
+	nr_range = split_mem_range(mr, start, end);
 
 	for (i = 0; i < nr_range; i++)
 		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,
-- 
2.17.1

