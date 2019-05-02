Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52F110A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 02:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEBAVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 20:21:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:21:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so185263plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J26xK/TYsajFaHvqG0j2f94K7R5CgJ81uUOmoyW1ySo=;
        b=id9MFSi12QAJGAd/W3zdyzyHMjGBmd8Wy0JaCu+Prx66jU4Zf8Z+YRBM7MU/tVGELs
         vXlqFGdGneK//N/pjOdMDh7eohn/p7wfe2IWZPWVx4l4JzZqXjI7eqsJ1diaU/QIM4sL
         7qjTJj1xG7ZfZWsv1O6DmM6YW90Z7ViiN3z9CL50Xq5fPdD07go/jjK1vp3v6YfGbMBE
         ejAU3TvFndLszoxn8HuI2eHWDlcFJrs99FaCP3sPDkiCdfZIo6+zuZl6QfYirnsVcjC2
         tJvbtXs53KZxKkTGYGkAdOYXk0fp/Ezua68oeXUH/IFRmlzNz+YIp0ZIz+onlGvAdiVj
         uXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J26xK/TYsajFaHvqG0j2f94K7R5CgJ81uUOmoyW1ySo=;
        b=f0KYM5AG7OE0eo6srIjS/a7KftqrH1uQ0FME0Z7nnHwGIjjCZ7h+SOhDAseKbEi2lL
         +xR6odHtIQkj99/DDfhVviXQvKGUICz+QfZheR065BnUyaXm8qZfZrl++L+0hfkeQTRE
         dJwVMcdHbB9yy3yq0wSqXbyMPp7IQXzoSPiPlhaHWyvo81E1Si/T9uQ9PWKmh6khaswn
         q5otLqWwJrIm7LdUqDvTKexaH/18uOIfIcvph75pgBKkI/Ej73hjwYytuqJQ8bdLlQhR
         n2k8w4MNVosyrg6oUt0B1OhPcv0LdPJQz3PlKQXlFRQItbR/HES+u9DF13fzXaY7nScq
         Uhww==
X-Gm-Message-State: APjAAAXUHdIrlik/TRU9dBEnU8+IjOir4Kc1FYLQ1ZeWN7kkDKQ4BGO4
        N2Ghvk24/MP3AUA6ODRa7ujPEg==
X-Google-Smtp-Source: APXvYqzJafGbTkXFJtaSH9BKk45AzcDPTwsf23PnIvgdu4HmmglxeH2vYEGCAn0ti1vRBYhrztMbnA==
X-Received: by 2002:a17:902:e405:: with SMTP id ci5mr504855plb.224.1556756501941;
        Wed, 01 May 2019 17:21:41 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k68sm32341783pfb.146.2019.05.01.17.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:21:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] clk: gcc-qcs404: Add PCIe resets
Date:   Wed,  1 May 2019 17:21:38 -0700
Message-Id: <20190502002138.10646-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling PCIe requires several of the PCIe related resets from GCC, so
add them all.

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Rebased patch

 drivers/clk/qcom/gcc-qcs404.c               | 7 +++++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index a54807eb3b28..29cf464dd2c8 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2766,6 +2766,13 @@ static const struct qcom_reset_map gcc_qcs404_resets[] = {
 	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
 	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
 	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
+	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
+	[GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
+	[GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
+	[GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
+	[GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
+	[GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
+	[GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
 	[GCC_EMAC_BCR] = { 0x4e000 },
 };
 
diff --git a/include/dt-bindings/clock/qcom,gcc-qcs404.h b/include/dt-bindings/clock/qcom,gcc-qcs404.h
index 454b3f43f538..5959399fed2e 100644
--- a/include/dt-bindings/clock/qcom,gcc-qcs404.h
+++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
@@ -166,5 +166,12 @@
 #define GCC_PCIEPHY_0_PHY_BCR				12
 #define GCC_EMAC_BCR					13
 #define GCC_CDSP_RESTART				14
+#define GCC_PCIE_0_AXI_MASTER_STICKY_ARES		14
+#define GCC_PCIE_0_AHB_ARES				15
+#define GCC_PCIE_0_AXI_SLAVE_ARES			16
+#define GCC_PCIE_0_AXI_MASTER_ARES			17
+#define GCC_PCIE_0_CORE_STICKY_ARES			18
+#define GCC_PCIE_0_SLEEP_ARES				19
+#define GCC_PCIE_0_PIPE_ARES				20
 
 #endif
-- 
2.18.0

