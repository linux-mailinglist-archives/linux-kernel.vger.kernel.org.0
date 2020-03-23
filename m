Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070E918EDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCWCK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 22:10:26 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:43815 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCWCK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:10:26 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02N28urS002941;
        Mon, 23 Mar 2020 11:08:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02N28urS002941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584929338;
        bh=Ht/jXfHLvSpNys7BvHrwcyb9dV5etFomjPUBpEzfSoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWQl/dtPyIYMHtwxUwPgY9OfAZA8FVXwHwxDR34avL+ffUbk8PBDvBw+7Mw2iC9OM
         M7BU3Z55/IPOR4idUlYZjo6FPoWLQ9VokEBnkuUzf1UWWhU9bwf5ghj0hXbBGOGOTr
         rh2Zqr+VMk+6EpVyX0f3CPBu8pAEGfKnb2Og/4zeslpkdOju8VTNmyyTM24PNAoxU9
         lSjmtl2HYaR1oBtbBGCQU31CvSnxBd8th7r/Ndk7Vs7YZGQFU6dvmN4CkDkE7dM92o
         UyHd9Ya1vN3MPREdxbREJOCojAfgIbt4atFDyYwTXxJSl9V48HWvkfhr+LNS11AQqp
         DqLOv+J0INg5Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/7] x86: remove unneeded defined(__ASSEMBLY__) check from asm/dwarf2.h
Date:   Mon, 23 Mar 2020 11:08:38 +0900
Message-Id: <20200323020844.17064-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323020844.17064-1-masahiroy@kernel.org>
References: <20200323020844.17064-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file has the following check at the top:

  #ifndef __ASSEMBLY__
  #warning "asm/dwarf2.h should be only included in pure assembly files"
  #endif

So, we expect defined(__ASSEMBLY__) is always true.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/include/asm/dwarf2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index ae391f609840..5a0502212bc5 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -36,7 +36,7 @@
 #define CFI_SIGNAL_FRAME
 #endif
 
-#if defined(CONFIG_AS_CFI_SECTIONS) && defined(__ASSEMBLY__)
+#if defined(CONFIG_AS_CFI_SECTIONS)
 #ifndef BUILD_VDSO
 	/*
 	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-- 
2.17.1

