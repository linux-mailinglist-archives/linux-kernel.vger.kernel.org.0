Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD616904F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBVQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 11:25:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45062 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBVQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:25:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so2169427pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gg7bS1nflOAaxyupRzfc5VSU36LQb9MIJVDzdfFhX04=;
        b=R8Zns9UfFCLkk51MpnD30Zt7kTfhnWJpFVg858FZmvU0SYaspwl+hj5Dxmf5F7KdtD
         JczjkiLhNwc7OEFMuPNntrvRuDR2bN3B/ojiXZIyhC8X7rCs9cwpxZW+yrCQMtzyoOck
         Rhr9fF1Y/yrtEdcNZz3R8bAEOiooSfmj7GWb2LqUX3jEiKpf3B2T1bPfuY0xEtvy/71e
         /eRpU73u+8zxiqOln+O1XpGxRiP4u3ilob3CVnzvNXJoKFZMrdSZ0VIQq+9/1tfFY9zE
         HDXFIGXM2PO47j3ow9xSshARQrJjsqQ05SKzLMziSVIkKeT1+YzyRhbGx/X+EufB195z
         Mzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gg7bS1nflOAaxyupRzfc5VSU36LQb9MIJVDzdfFhX04=;
        b=l+1t54p7vKQOYnUGywYQfUsMCd6Oz0zaJ3uFXyF21LizpXEAyV8tGDlqRTNc5bxdYr
         yvf/4KUo5gfAnkYHixD5PVeA7gWKbg6Ou+RhSkUDhyQS6mwfFj5JceBkTBcAxkskdPt6
         trAh+X9lCD2kroXKvNbv8JxqIMHTl6zGpFVAU/daQXT+ZQO/7v5I6m+kcpLPmeChVZ1v
         yoUWq1JZvqJQyX5DbS4UmDV/ThzwvYi6RvMTcFM7tXqkdnQuvt0O84jg27xjwXYFZVdH
         mbSKDV4yPMhK/pAqf9fkzeWU4RghOBmB//t2IOTUWBJPKy7fTvHyux2080PcWgW8bauK
         cZIQ==
X-Gm-Message-State: APjAAAXOote5BriJhZzP0jU14BpRx3EcC9ZaVPsg8kDCS+JpCKzkTAhG
        J0tGKXRDbFS2mlVf+kss/3uN
X-Google-Smtp-Source: APXvYqyya8y7D5YQFJCiWMM9h4XXO/EBmT5VgPITYvRx6kw0b7p7kv+JpJQey18UWknHAr5CfF29wA==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr9838281pju.66.1582388722406;
        Sat, 22 Feb 2020 08:25:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:801:b38c:89e8:305c:23c4:b77f])
        by smtp.gmail.com with ESMTPSA id q17sm6851296pfg.123.2020.02.22.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:25:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] arm64: dts: mediatek: Switch to SPDX license identifier for MT6797 SoC
Date:   Sat, 22 Feb 2020 21:54:44 +0530
Message-Id: <20200222162444.11590-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SPDX license identifier for MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 22f093960d27..c1295bf7080c 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -1,14 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Mars.C <mars.cheng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <dt-bindings/clock/mt6797-clk.h>
-- 
2.17.1

