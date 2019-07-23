Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3597157B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfGWJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 05:48:30 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:23442 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGWJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:48:30 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x6N9m2fe009018;
        Tue, 23 Jul 2019 18:48:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x6N9m2fe009018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563875283;
        bh=GhMsfcEGMdo7a2JHO9NEXRnzfvlVBKPP4W3vxfX4aPo=;
        h=From:To:Cc:Subject:Date:From;
        b=AyXw9ZsFdwqTHQzzXKMEAEk1i47hd8FA31ANoRJ/n+p1wW5X9oX94dF5QDQ48RjbY
         ct8UKjMIjvjHYKmmVGs7S96+r/d1+aBt0t02OlceDAItDkSzxfTQaiitkdLnTFhYxB
         msMKZKA433x/wX+2iMNJQmtLmbG0cRH0HxgeOc0GiBcpg6BthaBsxqFKbFibgf33nb
         8rbeyAlt+h9s7TNVJkxw1xmD9gSgWIYd8k9R4u2q/38vQgt2Uk/jJpXygs9Z1Psi+o
         CpJyeFb/bJDNKA9HB0rRXT0JBeBPljBFrqMFRXGvC8d+2z4Afsd19VHN8u2yVhvyeO
         yFCm4nLpjHQXw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: rename default_defconfig to defconfig
Date:   Tue, 23 Jul 2019 18:47:51 +0900
Message-Id: <20190723094751.463-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default_defconfig' is an awkward name since 'defconfig' is the default.
Let's simply say 'defconfig' like other architectures. You can drop the
KBUILD_DEFCONFIG define by following the standard naming.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/parisc/Makefile                                 | 2 --
 arch/parisc/configs/{default_defconfig => defconfig} | 0
 2 files changed, 2 deletions(-)
 rename arch/parisc/configs/{default_defconfig => defconfig} (100%)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 8acb8fa1f8d6..b10a1179291a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -19,8 +19,6 @@
 
 KBUILD_IMAGE := vmlinuz
 
-KBUILD_DEFCONFIG := default_defconfig
-
 NM		= sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+= -D__hppa__=1
 LIBGCC		= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
diff --git a/arch/parisc/configs/default_defconfig b/arch/parisc/configs/defconfig
similarity index 100%
rename from arch/parisc/configs/default_defconfig
rename to arch/parisc/configs/defconfig
-- 
2.17.1

