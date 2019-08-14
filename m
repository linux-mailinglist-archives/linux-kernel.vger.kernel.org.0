Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560698C9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHNDpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 23:45:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34351 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHNDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 23:45:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so2267157pfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmcsU/W0tzq1IvmwVTmXSycxuUniI8sb1AGzV8FnGDg=;
        b=Z1Dxn2y0LbGFBhnDKgwmFgKDa3wlLE7NiX2rjrN6aqAUjThe9UvrtvW5tVH4hW5V76
         YhASc/O03YkxKG0G4UvwQElgWAg2yLredDGqs3TfVV/fP7irnImzvHiK5BSoualSHNbh
         ZNCId2RbE2DUD2ptTD+ps4uHxDIAhDjKdkoXi1bfGOkJSfz80xNHF0x32lzpKMxEZDWB
         3kVsTT/rW8egEw6bCJpBB63y4WC8IhGDCHvIrtq5SIQ2AtZi9kZzrOLPtB2PO2QqOXFp
         aakBejQoW8zcfDoDn6jKLXgB5Q41Hp6oVATS3GepFCp0nzqISC5DD/scZfF+4DRMgJ9Y
         jn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmcsU/W0tzq1IvmwVTmXSycxuUniI8sb1AGzV8FnGDg=;
        b=SpoFz4Fi411++r/NgUubVyhvAJJMTcepso2xxPLXQc9wOUVCKSOhXR6/kUCI4/LUMH
         Jwt8GMvAGR2vHQpp0T6fbB9RH55KT43Y+T524UrBu9b1z0WjRsZimxYDzoPt0RUbQoJ6
         s8mneUEt9bi0tw7yezwDmKAZG9brz6Y3W2cBwHM0tduZAY2Bi1SmyWa8duJJrT5zTmFH
         htgiU0zo2m0rhIyMWWIBLN/HXMFzWPSiTn1NIdx1oyfa/uhwMgKrye3TgGrDCfZ+pSEc
         kqmk9UMdD3rErxpYxaKww4g8z/fB2zjCMgCg7pK8O7/t8I38CZi4C5mOXD9Ld8sVgV3O
         IMpg==
X-Gm-Message-State: APjAAAWoAUpENWlyITtMzkutS6zApIg7XoAUIeX11mGvdnPv0iTJmvCN
        eifZuVxU6p7n2WMvXepEAMI=
X-Google-Smtp-Source: APXvYqwPCCYFUyr9/au2x2GBD5TMQywJP35uOAe29AcUCBos/KvJa9uMOpJt2EpxvwwfbCN4DjjXBw==
X-Received: by 2002:a17:90a:bd0b:: with SMTP id y11mr4923486pjr.141.1565754348043;
        Tue, 13 Aug 2019 20:45:48 -0700 (PDT)
Received: from masabert (150-66-89-26m5.mineo.jp. [150.66.89.26])
        by smtp.gmail.com with ESMTPSA id p1sm454583pfn.83.2019.08.13.20.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 20:45:47 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 90DBA201198; Wed, 14 Aug 2019 12:45:22 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, green.hu@gmail.com,
        deanbo422@gmail.com, greentime@andestech.com,
        vincentc@andestech.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] nds32: Fix typo in Kconfig.cpu
Date:   Wed, 14 Aug 2019 12:45:21 +0900
Message-Id: <20190814034521.22659-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typo in Kconfig.cpu

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/nds32/Kconfig.cpu | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index f80a4ab63da2..f88a12fdf0f3 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -13,7 +13,7 @@ config FPU
 	default n
 	help
 	  If FPU ISA is used in user space, this configuration shall be Y to
-          enable required support in kerenl such as fpu context switch and
+          enable required support in kernel such as fpu context switch and
           fpu exception handler.
 
 	  If no FPU ISA is used in user space, say N.
@@ -27,7 +27,7 @@ config LAZY_FPU
           enhance system performance by reducing the context switch
 	  frequency of the FPU register.
 
-	  For nomal case, say Y.
+	  For normal case, say Y.
 
 config SUPPORT_DENORMAL_ARITHMETIC
 	bool "Denormal arithmetic support"
@@ -36,7 +36,7 @@ config SUPPORT_DENORMAL_ARITHMETIC
 	help
 	  Say Y here to enable arithmetic of denormalized number. Enabling
 	  this feature can enhance the precision for tininess number.
-	  However, performance loss in float pointe calculations is
+	  However, performance loss in float point calculations is
 	  possibly significant due to additional FPU exception.
 
 	  If the calculated tolerance for tininess number is not critical,
@@ -73,7 +73,7 @@ choice
 	  the cache aliasing issue. The rest cpus(N13, N10 and D10) are
 	  implemented as VIPT data cache. It may cause the cache aliasing issue
 	  if its cache way size is larger than page size. You can specify the
-	  CPU type direcly or choose CPU_V3 if unsure.
+	  CPU type directly or choose CPU_V3 if unsure.
 
           A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
           A kernel built for N15 is able to run on N15 or D15.
-- 
2.23.0.rc2

