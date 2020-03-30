Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC5197565
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgC3HQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 03:16:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgC3HQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:16:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so8252612pgh.5;
        Mon, 30 Mar 2020 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf318LKZ+rY1+2PNaHw1wx9Zylx8ChMocj3SCcUJF74=;
        b=FMp7NcWmv8vjZvxGOHZpB+PA6z+v+TcpLQeQFUdatEY3xc02Li4mEIPyUz4EKzoIr+
         rcvWNfBK3vRV3Nr9Bna7sE70SIE0IiP+CH0paqsLjwEU8bUg7YcIa42QQ/iuq4InyA+Y
         5AEEG/mrtf0w8vDlqrZasFk3Vhp8DrFo7IQzHzG6KDeE8IeVIIvTXLGZLHcNXC1+nKo/
         GvbdT5tipW0VB71JuGCmyqGsRqyHFkFP9Wu343ao6sfp5OxDKACBHbQPVTPuMOCSOsxY
         WFh09RTacLF0N9xsva+eUwAhoGROvefpLyJJ06EJmO298M5HgJJH4eL1+AyVt39qImYJ
         /cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf318LKZ+rY1+2PNaHw1wx9Zylx8ChMocj3SCcUJF74=;
        b=iFO+UHi1c4bc+a+F7YSjMbcu/3rTS65OYIq0hjEMtTc4hrwFPEtnPYtTGJ1zoeJiDE
         CLE85zMPwwwZ3v0mLFGohMaWmyr4BpE1VewFNoDlr1/Lf1VfZ3iMqaK9yOP0K1udRAeM
         mO3JOrdfNGnyfKYH+ygmQZMAFUJwepQ2MRmf65lo3rX6AqBBzeYatSEIsgBMczg7/Pdc
         SaMOtp4Mya+EN0xfxIYCtxCjuDDyCNrPUtrZFW0B8QVbBVZ4nGWCGXvhQWFeMzPk5swZ
         BjtOluyDzM5PTLyofc71J7yEo1FR77Iq2JIx4nDuXCwa+ZHnDLgIjvIucbqysa4KuoDD
         l7xw==
X-Gm-Message-State: ANhLgQ1fzrYLbvPnjiS5iT0WGzhezpENbroapcynVXyNguBtXOfQd2l5
        NcZZXKhRYFXkuuvYdTZeNtE=
X-Google-Smtp-Source: ADFU+vu0uBcmfyfqGGWsPG3Ofmh7TXNtcF7yPEmGrzqO5HpHYU0VQGgkVK956IGOcqWc99M3M9YDJA==
X-Received: by 2002:aa7:9433:: with SMTP id y19mr11665500pfo.233.1585552564353;
        Mon, 30 Mar 2020 00:16:04 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm9490484pje.9.2020.03.30.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:16:03 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 3/4] clk: sprd: add dt-bindings include for mipi_csi_xx clocks
Date:   Mon, 30 Mar 2020 15:14:50 +0800
Message-Id: <20200330071451.7899-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330071451.7899-1-zhang.lyra@gmail.com>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 include/dt-bindings/clock/sprd,sc9863a-clk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/sprd,sc9863a-clk.h b/include/dt-bindings/clock/sprd,sc9863a-clk.h
index 901ba59676c2..4e030421641f 100644
--- a/include/dt-bindings/clock/sprd,sc9863a-clk.h
+++ b/include/dt-bindings/clock/sprd,sc9863a-clk.h
@@ -308,6 +308,11 @@
 #define CLK_MCPHY_CFG_EB	14
 #define CLK_MM_GATE_NUM		(CLK_MCPHY_CFG_EB + 1)
 
+#define CLK_MIPI_CSI		0
+#define CLK_MIPI_CSI_S		1
+#define CLK_MIPI_CSI_M		2
+#define CLK_MM_CLK_NUM		(CLK_MIPI_CSI_M + 1)
+
 #define CLK_SIM0_EB		0
 #define CLK_IIS0_EB		1
 #define CLK_IIS1_EB		2
-- 
2.20.1

