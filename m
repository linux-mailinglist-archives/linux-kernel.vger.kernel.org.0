Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476B825B94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 03:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfEVBPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 21:15:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39470 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfEVBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:15:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so376573pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fbG5fDEzG6AzVFaygO2qy/CXt0Isxn5KLkAJO5SWss=;
        b=jfN/IPbdiNMb5JRj2CnP/eCgdcf+GAIPN3VeuSPPh8A3Z/LLdTYhT+cSzxiZC5unq3
         yZIl3VixybtlbHWsvdnbH922uzO1jUHnvWVjH4WoMf5Nk5C6X0YK8xbiwVkV4I3V2aJR
         JDqFc4zZoFum0ETZzckdxYA4ywVQmSifOeoHSz9OicminnX2tLgKTK3LSTkClyKWvOJY
         kAks3r64S0qPczI3NGUDqwbXSehZSaosHHmtgE+rbGmlMcdPfdX8IKr2kL2jGYjFFU+u
         CHpc7PATBAtA8AMfyylhide8JfBbCzqDn+AnT+Wwgq5PiASu07b5d0gBpPzTiTdOUAOt
         Pf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fbG5fDEzG6AzVFaygO2qy/CXt0Isxn5KLkAJO5SWss=;
        b=Hjt/k0waSrlL/zoKyCmahcEd63JxjuhKq5xm85decNluQLwVjVGnlDKyTJuIZgz0v/
         CK93tl5n/bjaIfWhkp+swkSrfxRaoFiob78mzV5UnTQ5imNK46nOZx9XyrkLHSwlpwL5
         haaCi1D06Yo6/D4xhp1ZT2U95jbrbkfgRI4cSgKDbMZT5LosF4xOZrjLOFVZea5cm0wx
         SXPF4xqzUVb+K9F3zF/7tMS4r78jc8u4DaB/1bZ+zBqtUCXTM0fWCpnlKRFTabnxfFJb
         lsXvQpyaOL4qYJAgibRTbWGK7GFyWpgOrfGyvvMIbVVkA6M4XTA3S5iGTz6hx3VgbfAb
         0QOg==
X-Gm-Message-State: APjAAAV8rKC1sgCoVPPIO2f87cgtvhL+VIywVX+ADFPbfBuybIavxjMF
        TRLxAMYCY5SuBIIyxEkMaAmiBg==
X-Google-Smtp-Source: APXvYqyfqXtwQYeS2jhPUWE9ejfCsvhPu+c6LXe+/1FDtisubfaiXyyTbN0HcDUqVWq5R5+SRf7ipw==
X-Received: by 2002:a63:1f04:: with SMTP id f4mr87297936pgf.423.1558487747679;
        Tue, 21 May 2019 18:15:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e184sm31756061pfa.169.2019.05.21.18.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:15:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 2/3] clk: sprd: Check error only for devm_regmap_init_mmio()
Date:   Wed, 22 May 2019 09:15:02 +0800
Message-Id: <20190522011504.19342-3-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522011504.19342-1-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_regmap_init_mmio() wouldn't return NULL pointer for
now, so only need to ensure the return value is not an error code.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/clk/sprd/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 9ce690999eaa..a5bdca1de5d0 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -58,7 +58,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 
 		regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       &sprdclk_regmap_config);
-		if (IS_ERR_OR_NULL(regmap)) {
+		if (IS_ERR(regmap)) {
 			pr_err("failed to init regmap\n");
 			return PTR_ERR(regmap);
 		}
-- 
2.17.1

