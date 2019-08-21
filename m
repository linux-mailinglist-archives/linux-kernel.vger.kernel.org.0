Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499339762A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfHUJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 05:27:57 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:45360 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHUJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:27:57 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7L9Qxk5009298;
        Wed, 21 Aug 2019 18:26:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7L9Qxk5009298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566379619;
        bh=pqcPU4AECin6r3EcYqzgQUoNg5HAz9R05ah4cX2iLn4=;
        h=From:To:Cc:Subject:Date:From;
        b=c+NS490TiT/gXvHLM8uDhIkSvcIemGEtcTjpEGee/AapYXb5VC63uE31iAXAiJOpK
         v/HRhZr4IOEuR/avdcAKcoAc5IzUVc0qkTd0BNUao1elY22StnVO2uMHd9PMP+errs
         H4ZFDdX5l/jIx5lPc2qnb2fiV9OV/CzAgpLBNU7087GEEsas9fK5c/Z7tde86fsuEu
         xAHSdz/zXT1AXv/MF4P06lNWvnTngz+wejtpCzL6+XjYt4iCbvV+S5ndiFXKDcdbAG
         iDGx3BSL4xnHmF4+9pp8ik53ZXmCt8y2rePCTU9G2/OMo8Bfdl5hZoAY1YSPHTO6at
         3ImjknwD0vMvA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: add arch/riscv/Kbuild
Date:   Wed, 21 Aug 2019 18:26:58 +0900
Message-Id: <20190821092658.32764-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-y form to specify the sub-directories under
arch/riscv/. No functional change intended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/riscv/Kbuild   | 3 +++
 arch/riscv/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/Kbuild

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
new file mode 100644
index 000000000000..d1d0aa70fdf1
--- /dev/null
+++ b/arch/riscv/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += kernel/ mm/ net/
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 426d989125a8..bf4c6d914ff5 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -72,7 +72,7 @@ KBUILD_IMAGE	:= $(boot)/Image.gz
 
 head-y := arch/riscv/kernel/head.o
 
-core-y += arch/riscv/kernel/ arch/riscv/mm/ arch/riscv/net/
+core-y += arch/riscv/
 
 libs-y += arch/riscv/lib/
 
-- 
2.17.1

