Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE98815FD25
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 07:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgBOGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 01:40:34 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:30192 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgBOGke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:40:34 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 01F6ctNR021710;
        Sat, 15 Feb 2020 15:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 01F6ctNR021710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581748737;
        bh=Af0dq0uoXU8aQZEpPAhx6q8OPMfAJsmDhuMBKMFqWzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjdjAG+DuwWM9czXbIV7XwA1I/LOwH55kGhue23jT9bxXiginxnV2dcI7Wd3b+8SI
         3+VW1Ov9BHcbIvlT3P6vr/8ouMegTeRtGK8+9l7dkWcebdsw2IcxtnoTNosenqizai
         akYeadQNwFjnNTthslRYMrNUHUOz3cWv/oM/J07dV8IwKCIC2rCkDRDdqs2F5YRUne
         LEkTG5F3H+L2Sxpp3va33WzlyLk5iOE2MeUsYjN6qvpdF+fIdelViMGWWMyZkMNhaQ
         PzqQ83+fKF4ArxQKKIWztTBAQ6jhfleAP2fGBBJ3R6BrvQus6ZC6PXvcFsmSIZ81qI
         ct2ualF59kPxQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ross Burton <ross.burton@intel.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/boot/build: add phony targets in arch/x86/boot/Makefile to PHONY
Date:   Sat, 15 Feb 2020 15:38:52 +0900
Message-Id: <20200215063852.8298-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215063852.8298-1-masahiroy@kernel.org>
References: <20200215063852.8298-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These targets are correctly added to PHONY in arch/x86/Makefile, but
you need do so in arch/x86/boot/Makefile, too.

Otherwise, if you have a file 'install' in the top directory,
'make install' does nothing.

  $ touch install
  $ make install
  make[1]: 'install' is up to date.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 1b37746aab82..fc889bcfc2f8 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -127,6 +127,8 @@ quiet_cmd_genimage = GENIMAGE $3
 cmd_genimage = sh $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
 			$(obj)/mtools.conf '$(image_cmdline)' $(FDINITRD)
 
+PHONY += bzdisk fdimage fdimage144 fdimage288 isoimage bzlilo install
+
 # This requires write access to /dev/fd0
 bzdisk: $(obj)/bzImage $(obj)/mtools.conf
 	$(call cmd,genimage,bzdisk,/dev/fd0)
-- 
2.17.1

