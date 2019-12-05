Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E211139B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 03:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfLECPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 21:15:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:44502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147661"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:43 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 2/6] x86/mm: Add attribute __ro_after_init to after_bootmem
Date:   Thu,  5 Dec 2019 10:13:59 +0800
Message-Id: <20191205021403.25606-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after_bootmem is only set in mem_init().

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 916a3d9b5bfd..4fa5fd641865 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -160,7 +160,7 @@ void  __init early_alloc_pgt_buf(void)
 	pgt_buf_top = pgt_buf_start + (tables >> PAGE_SHIFT);
 }
 
-int after_bootmem;
+int after_bootmem __ro_after_init;
 
 early_param_on_off("gbpages", "nogbpages", direct_gbpages, CONFIG_X86_DIRECT_GBPAGES);
 
-- 
2.17.1

