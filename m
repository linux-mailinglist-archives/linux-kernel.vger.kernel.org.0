Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDE6BF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGQPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 11:25:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39185 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfGQPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:25:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so12160970pls.6;
        Wed, 17 Jul 2019 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=DFnNbAj9SX9FiSTq5182YkMY0MeEV6tRnLLT4YdYombkc+xTR/PKoF7d1WK+10sK6M
         bKvNNHCJPXxNUGZf5926hfk6J+Tfw0tQ6YQkdMqy6I+W3PWWIzresXn/6h1zyKqP0Tur
         1YF5gKGDLRE9yVC4Ldvv+JpLatWPYJDtSOSYQ+lJ0f0nviOrANQwC6+GdRER6olPPPAE
         OgB5bWByrO6sf+Tk0u1vtyWn0CG5gzWANvXzdWR0OX9k+Yi8OthPk8/cfjICGmfzAXwi
         GWfZDXe7obOt41AhMwMZ6seQBXcdgSjbs9/kvcUsL063zcS7M/zqxui3Ddlg4o5QOLOd
         U+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=Gf5u91aBvFsRhewYiruIzbTrcEbDXj3waYwQLRooEHur80+MeL2qFVKlTWqP2Z1/Hl
         nWV85khxsoU7tUSb1IW3YGJRBC+NNv3m73f+d2Q3S2iMX5O4o0h4p8iEbyOv2ozpqMSJ
         idcxrj+GS8rdtJFAW2xmmITT1sMyNMaXE0gN/HDmrhQVGVAcl/D5Tjk2GKP4shzewQ9c
         7WDrWcRUoPFlx0/1bNvnFaO1g70re6ViGKVfwdZ1P1m2LTIZjV6E+SarTqBY06/QCt+c
         8olLSwgDmPk1qnsTn2UVl1+j6c3717L7/oQeBNcHPWVlvUXa40HuIWI7r2lx56icMsAx
         mrzg==
X-Gm-Message-State: APjAAAW6Xic+2vsXU1xht19PHXh7cExk0yowrEsFKZNjdtEY5HbHa0ZF
        Xffuca4EM9z6g7WMu865MBdJQwzV
X-Google-Smtp-Source: APXvYqzWmImi1HFy39vjmrdBvDEslJvfboyeixVw8KzlyOwR+24BGukxG36C7jKdyVipbhPgyxGezA==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr43880642pln.63.1563377125321;
        Wed, 17 Jul 2019 08:25:25 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id l1sm33771386pfl.9.2019.07.17.08.25.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:25:24 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/14] crypto: caam - move cpu_to_caam_dma() selection to runtime
Date:   Wed, 17 Jul 2019 08:24:53 -0700
Message-Id: <20190717152458.22337-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717152458.22337-1-andrew.smirnov@gmail.com>
References: <20190717152458.22337-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of selecting the implementation of
cpu_to_caam_dma()/caam_dma_to_cpu() at build time using the
preprocessor, convert the code to do that at run-time using IS_ENABLED
macro. This is needed to add support for i.MX8MQ. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/regs.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index fb494d14f262..511e28ba740a 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -188,13 +188,21 @@ static inline u64 caam_dma64_to_cpu(u64 value)
 	return caam64_to_cpu(value);
 }
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-#define cpu_to_caam_dma(value) cpu_to_caam_dma64(value)
-#define caam_dma_to_cpu(value) caam_dma64_to_cpu(value)
-#else
-#define cpu_to_caam_dma(value) cpu_to_caam32(value)
-#define caam_dma_to_cpu(value) caam32_to_cpu(value)
-#endif /* CONFIG_ARCH_DMA_ADDR_T_64BIT */
+static inline u64 cpu_to_caam_dma(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return cpu_to_caam_dma64(value);
+	else
+		return cpu_to_caam32(value);
+}
+
+static inline u64 caam_dma_to_cpu(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return caam_dma64_to_cpu(value);
+	else
+		return caam32_to_cpu(value);
+}
 
 /*
  * jr_outentry
-- 
2.21.0

