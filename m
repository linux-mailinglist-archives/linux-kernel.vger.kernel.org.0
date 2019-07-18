Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA6C8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 07:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfGRFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 01:36:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32807 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfGRFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:36:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so3087018pgj.0;
        Wed, 17 Jul 2019 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jC4D69AaHKiU01d7qFnc/fZ3zEU1QVgvQY/VIPGj8fs=;
        b=OiMYx+uQoiqfAIuRs1BkDfkiKxpLpCvH5rmrgKbGyd4lIsF+fTsxlQRkC+BbDKKsHv
         FJ0Hrktu2DYsruxJC9i4L1pgbivp//qE02Ut1IDB1rEPFEIv0m6y5+13c9QMHgFRTVDU
         9fndjehhNI5WMPq4zdNJ9OeBC6E8/OvlT5UGXeJGyk3LJUmRB39sI/XyvOr+zfU0Sb9Q
         pDSPiBhbPUR0N12XqioGJN505EcZ/BaVfnsvs1VseSzesm+cy9pm7REhmH4TRmxRyMdd
         MXFwuLq2a9wyoLbM8nXwHqZgcoZJm/99mW9AP7EZ73vDp0QLIxsh/2uRSsRzMxk8Z4Op
         ClEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jC4D69AaHKiU01d7qFnc/fZ3zEU1QVgvQY/VIPGj8fs=;
        b=PsMgjySn94OULopa4ViwaVY/1Gcrz0brczzhIyOIl3MiFdv6bEx6gpDhud+YhKP+Ei
         ws0kwoAHDtVN0nDR68W4WEanbmNLsN//mOwsoBAF/GCg6eZ1QV7mzmolB+z3iu/nHpq6
         YAVheeJQs/D9LnMNmlZDTPy18dI04E0mr5/TzBLHr4GvuEUfv7YLXOq58OBCtP6bv+8n
         ufVOH8Sp/p3eA05yNMkKD/TheYTvXCednx/liqJfuzuHQECagV3w2WJv7jlWrRHQgFQ0
         VE+5RIdtPZ+iU8+KrRz7sPxJoTK58u6EjbrVJfnRkri/YWILlAIFNE1JLlISB5VQSwHs
         iS/Q==
X-Gm-Message-State: APjAAAXnXKv45laYBR5VSg7yAOVlTt0yVDZ9nv0DYviapoFfh4YHFY8H
        8MIuoszFbMOg+3b8Vz3YZOk=
X-Google-Smtp-Source: APXvYqyfQNsVq9I3JkdZD8K8qiRpeSAp1KmjMTBLzAfcCN3dep9z9aXaFcEpuE+mBxtjxjnQZk9K+g==
X-Received: by 2002:a63:f312:: with SMTP id l18mr46240260pgh.440.1563428212326;
        Wed, 17 Jul 2019 22:36:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q126sm29822432pfq.123.2019.07.17.22.36.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 22:36:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] clk: sprd: Select REGMAP_MMIO to avoid compile errors
Date:   Thu, 18 Jul 2019 13:36:16 +0800
Message-Id: <20190718053616.27042-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Make REGMAP_MMIO selected to avoid undefined reference to regmap symbols.

Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
index b422ceaa709f..12e9a7fd746a 100644
--- a/drivers/clk/sprd/Kconfig
+++ b/drivers/clk/sprd/Kconfig
@@ -2,6 +2,7 @@ config SPRD_COMMON_CLK
 	tristate "Clock support for Spreadtrum SoCs"
 	depends on ARCH_SPRD || COMPILE_TEST
 	default ARCH_SPRD
+	select REGMAP_MMIO
 
 if SPRD_COMMON_CLK
 
-- 
2.20.1

