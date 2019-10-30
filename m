Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83763E9432
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJ3AtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 20:49:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44615 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJ3AtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:49:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4so624155lja.11;
        Tue, 29 Oct 2019 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69bZQy5CYKyEvBEYx4SZC8ZoPl/aYUUYCjOjLOlQ/ps=;
        b=M0QnTm66RRRurE++l9qmcU19UXJ1Z01aIb8nt+p2hfCNe8SMGGuF2wHu/t58DIjYLD
         7Af2EBU2okKDxW/Kr+4ZcYisRHyELZEPOU/WUGp/rD1b5yH3RirFXFzvN3NVElPvoGCi
         F0DdQo53YYCTgRImYLTw7fdMG7PimSpbbQcberIho8Ys3PJ8et7ZywDA0hsai+phwbIh
         +6r4GYo5sG/jzO5CjDpuRZyEEEngu2H25ce0SCqwru30hqFcB6EWPOBDLAfy4JI0cxQa
         rQkhpdOO0vlT3LkrbaNXtNOPGOdmRJjS7hoCUZ/TWKSwt+FFrizfvwnkEGX01jS+ap6m
         ZCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69bZQy5CYKyEvBEYx4SZC8ZoPl/aYUUYCjOjLOlQ/ps=;
        b=tl6jRAYYylirKHvtjiYD0x7KLWIsBlbuc9si6f6jz552tXO54Syjoxozl3u0gWsVts
         kp7R39mKLb2+bpfFcGkDrNXBWk3m43JRDXOCA8kTjQsIqPaeODlK5qfZ9Ho0UaOXGuxM
         MxAJwH0jv37XAALVNsRGuB2Q4vt2U7vnCck+cyyY7wphO81hPc8ScP6bJR/593K0qqd7
         YW/uDFN0O5ZIp7Xlh27Uu4YFZ+cjnkAvtVDAesZCGBEniDjDFdk5qUAMTUk+g+2x/bLH
         0LrpNNUMJlgXbvOBJTNre5a+59OgQEJ8eYJgNthQeFl3wEu3MY+MP0vttJYJOQq+LciV
         UIvg==
X-Gm-Message-State: APjAAAVa1SaSZ5eF/jeXRgPGTTteVXDnpyeNljs3zPEo/YeH3+AfsLX8
        aTTEyTyiU4cp4/TSXa0EgYw=
X-Google-Smtp-Source: APXvYqzxAOLYj4gBBl4CsGTQZOUlu+bzkhdLijeRNR8yohhWU9qLb/0DexNtoSR3EZBFHUs0vqcS4A==
X-Received: by 2002:a2e:9799:: with SMTP id y25mr4680644lji.228.1572396553396;
        Tue, 29 Oct 2019 17:49:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 87sm202308ljs.23.2019.10.29.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 17:49:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit state on rate's recalculation
Date:   Wed, 30 Oct 2019 03:48:13 +0300
Message-Id: <20191030004813.9187-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART clock is divided using divisor values from DLM/DLL registers when
enable-bit is unset in clk register and clk's divider configuration isn't
taken onto account in this case. This doesn't cause any problems, but
let's add a check for the divider's enable-bit state, for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: In the comment to v1 Peter De Schrijver pointed out that UART's DLM/DLL
    registers configuration is used when enable bit is unset, thus the
    commit's title and message are changed accordingly.

 drivers/clk/tegra/clk-divider.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index e76731fb7d69..f33c19045386 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	int div, mul;
 	u64 rate = parent_rate;
 
-	reg = readl_relaxed(divider->reg) >> divider->shift;
-	div = reg & div_mask(divider);
+	reg = readl_relaxed(divider->reg);
+
+	if ((divider->flags & TEGRA_DIVIDER_UART) &&
+	    !(reg & PERIPH_CLK_UART_DIV_ENB))
+		return rate;
+
+	div = (reg >> divider->shift) & div_mask(divider);
 
 	mul = get_mul(divider);
 	div += mul;
-- 
2.23.0

