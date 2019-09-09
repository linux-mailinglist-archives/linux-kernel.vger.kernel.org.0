Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151D5ADB6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfIIOpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 10:45:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33578 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbfIIOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so7983651pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26Wst1tOghrDUnY62Gv01qINYsQrhb3q0IbTkiTmqqM=;
        b=rG/rfJU3xh0k1J0AJwUGXwYUar2jktQsLUuMOXzcJb0ls1+ISaHOnUqBcqHbScS8Qc
         fxdYbctecuMQP4kVTiOgGhwyuVFHSDvkAs1mIuIJTFazsMRPShY0fJ5EtznzwFRZBDxL
         ap/bAt700qWPX7PT6wcnWksKDAVozVObGXtHwnUDQPlsmspkzlvkC1u99hmtt9iDHYhm
         Xf+ZNacpugW70l81Jvg+4uC2qmA5/bdtXMRepOmN9VHHMEyqChCxyVpMwUGmOOFPVIv5
         2OxFvXNI4M5uR/hbyaiVlN++NoKUpB9/Y/dw9rCOtef5nW1Ca9gYAgPpZ9GP5dPcefEa
         uR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26Wst1tOghrDUnY62Gv01qINYsQrhb3q0IbTkiTmqqM=;
        b=hBmJC3ktyOdKbIzWM5mFTnAU6UMTHoGicz6NipdsbD/0seXC4PeSDjKCtSQk6dEqye
         VFsPut9GgqRROPIeyWTnjJgwG3Hfz7jBMiDQwdRrxR3yhMseC7Ckv8I7UeF3ZAae3aeN
         NNy8CD78eRYIJEUhKcSauOLZUG3Ln4jGmVjEIoOwHwTnqptjnHrjLVYQWuF3xYKXHzM9
         fa67P6wLimGdPg+2v78cKtEu+c7+OuXSCZEW2N/EnQi5xybYqVGp2kgyQgHbEBYPcYbF
         hJ3WAFy/aDXN2SCfBhwCSYfUofFpiKzSFCCBgFAPNOz8zYFiO1FRvwX2sdGxJstKNVej
         wEUA==
X-Gm-Message-State: APjAAAXI1M0Bgu5bcFOouLiIddse02DZkXycZ5a92z8zdYOTC9MtKSRg
        SZ3NM7+zN6lazI6hoY2jC3k=
X-Google-Smtp-Source: APXvYqy8lNimDXQ2Ss3y8cw5j0IRed1AuEGcqTY1oNoklGNuGn+m12ZfrpopYBKbvakqyb4+BbiusQ==
X-Received: by 2002:a63:1310:: with SMTP id i16mr21708517pgl.187.1568040347524;
        Mon, 09 Sep 2019 07:45:47 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 8/9] hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
Date:   Mon,  9 Sep 2019 22:44:52 +0800
Message-Id: <20190909144453.3520-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think DEBUG_BUGVERBOSE is a dmesg option which gives more debug info
to dmesg.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce891713c914..ceefe0c1e78b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -164,6 +164,15 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
+	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
+	default y
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
@@ -1323,15 +1332,6 @@ config DEBUG_KOBJECT_RELEASE
 config HAVE_DEBUG_BUGVERBOSE
 	bool
 
-config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
-	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
-	default y
-	help
-	  Say Y here to make BUG() panics output the file name and line number
-	  of the BUG call as well as the EIP and oops trace.  This aids
-	  debugging but costs about 70-100K of memory.
-
 menu "Debug kernel data structures"
 
 config DEBUG_LIST
-- 
2.20.1

