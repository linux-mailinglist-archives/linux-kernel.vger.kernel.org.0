Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B180B3AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfIPMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:50:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35770 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbfIPMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:50:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so3385666wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlGUHvg+PE8gs96DiXpNJ8Kfd/rHrkqDzag5ZPnKd5Q=;
        b=uRznrPwppxChi5DbFjBeAieVJnJpLht0j9pPELbSwp1vv3rhF+D0lrlX1Yetseyedi
         EHQmRJ5hu9fp3801FOKkw5+yX1bloZAVLZpMjuj5WAstQXZsNTcqZ4lZjSik4IAsiXLx
         b/LxLStKZvrpsV8yX4Nn/uWNoyG/XqctVhaLSa3X5/hPIRwYJgo4E8g62aiuq5qlKmfM
         Q3Hf0vxXjlFjvi+6EWQJUtlnn7+zGxpduDjbl9FGcdjotSN1JnykahEWQ301TkYIfUTy
         KHFQk+UDLG4QjGgEuFk0jHuMgn9vAFrpXGQMhcqIm8hIzQJOw/0KvmNvX+n+nUiS96vz
         SZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlGUHvg+PE8gs96DiXpNJ8Kfd/rHrkqDzag5ZPnKd5Q=;
        b=WRdc4FoR5BgB7pNYT2IRW/94ZcX2jrjjaj60kO6Yx//nAOPFs5QkOoMZPSG6Z1Tzoy
         +day2xbT41o/8siyY94C66yXJ632vx27wVx3saSEtEwW4ocAarH5s2F5oEx+AfQ37Oss
         4cvZWdUYnTaIqMYeVGxKT1zIi+UNxlD5ymXai5Z+XeXUJjT/CjaqJU8sFkJ2qeDioFzf
         81vHQVAlftrauldz3mgB7SjG/8WwdO36dE0bANoXVJIMezjk6nbHk/IpyZYJFhPfWzvl
         OzGBIiGFapW+i4dW0f6SVZrqiyB3aj7sk1dBl44IN7U4u0mfELxpJRzjQIIiXX9HNAgO
         +pNQ==
X-Gm-Message-State: APjAAAVjK7ypZmBZPTA6ciVmFruPRRkFMnrkF5j3kJKtT/jCGZ5CwkFM
        5CJtoSlEyTAKZWsU6hd5z6bGKQ==
X-Google-Smtp-Source: APXvYqy7RU2IS8RX/3f7CyUGB28iNocAeDt1Nen58ZP9x40CfxUXWROzTKwkmKdqC1wR0VqTF3GNSw==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr17384767wru.282.1568638226669;
        Mon, 16 Sep 2019 05:50:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 2/6] PCI: amlogic: Fix probed clock names
Date:   Mon, 16 Sep 2019 14:50:18 +0200
Message-Id: <20190916125022.10754-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the clock names used in the probe function according
to the bindings.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 541f37a6f6a5..ab79990798f8 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -250,15 +250,15 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	if (IS_ERR(res->port_clk))
 		return PTR_ERR(res->port_clk);
 
-	res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
+	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
 	if (IS_ERR(res->mipi_gate))
 		return PTR_ERR(res->mipi_gate);
 
-	res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
+	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
 	if (IS_ERR(res->general_clk))
 		return PTR_ERR(res->general_clk);
 
-	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
+	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
 	if (IS_ERR(res->clk))
 		return PTR_ERR(res->clk);
 
-- 
2.22.0

