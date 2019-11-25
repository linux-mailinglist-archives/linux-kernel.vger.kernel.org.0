Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1444F10943F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 20:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKYTbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 14:31:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:22641 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKYTbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:31:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 11:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; 
   d="scan'208";a="216994582"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2019 11:31:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 3/4] mtd: rawnand: fsmc: Change to non-atomic bit operations
Date:   Mon, 25 Nov 2019 11:43:03 -0800
Message-Id: <1574710984-208305-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for expensive atomic change_bit() on the local variable err_idx[].

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index a6964feeec77..916496d4ecf2 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -809,8 +809,8 @@ static int fsmc_bch8_correct_data(struct nand_chip *chip, u8 *dat,
 
 	i = 0;
 	while (num_err--) {
-		change_bit(0, (unsigned long *)&err_idx[i]);
-		change_bit(1, (unsigned long *)&err_idx[i]);
+		__change_bit(0, (unsigned long *)&err_idx[i]);
+		__change_bit(1, (unsigned long *)&err_idx[i]);
 
 		if (err_idx[i] < chip->ecc.size * 8) {
 			change_bit(err_idx[i], (unsigned long *)dat);
-- 
2.19.1

