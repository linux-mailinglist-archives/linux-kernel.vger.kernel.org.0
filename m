Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10EDB3E06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbfIPPqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 11:46:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33258 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389500AbfIPPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:46:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so250349pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTpWa1DIkfpJvRELBVr27cwiqR/tR9AaU9awO2MhQyc=;
        b=pRk3HU+zY6iiNHWJaHFXTtj+RSJ3rHyjAV2n8js3njp8O5MkK7jE+zN8qt+CkzCACP
         BQbioqI6GUv+RYYuXQkrIVsWwHXEW2N5Hp5SApwqEgKB83jINZhsFiePeMXul8W8U/Uw
         tzHfLSTFnr5Uz8o5aX1TDUhZLcOqgCCv3FccW4j0Z8JI4ZdOCZUdcWkFTyV3yEZlfIiI
         kV2xJK8vU7oL0Gs01cvD8pyTO2csDQzm0/e/vI2EvkRiWm6MFjZzwDJdh/v73bOKi0Xu
         PlXJitUH+4KYVTLTdkjzcZyv8rMPYCeKLcNV+gD9HjodqeFZ22yTcO+qDFRr47c9pkj2
         V0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTpWa1DIkfpJvRELBVr27cwiqR/tR9AaU9awO2MhQyc=;
        b=W7slvEKgX+FSeoQDF4DXg54I3K1PT+0ygRX/KPbTVQbiyKuXPeDPGZ17bkeH0N2sAG
         DzNAcp62t7leMo6PQsiy6kLgXWqp2ejZE18IV3sStOYOY1wasblTHY/2emDpvKakVHMn
         FUoGdk+quyvkrxS58J+oeVT7tZkFaiWRBEvuzhrktHPRS7MDkSjFpqwVM/aRR5ljczGV
         nGoXz6euv5SX9YX203z2N/qXyWfNSwSObHDurmCnEH8ob5t5VT4HHWznXcTuHkEmL3QC
         e/NM97QmEmevnFbcakcTHYjeS3EZD1Em0oiNkON+jmqwk3htDqpnQsRVzgp/qW28Bnj3
         cM9A==
X-Gm-Message-State: APjAAAVDgoiadqzH2Rbd9aVgl4PaL7Is4JSpj6JpQq/Sm9bHRdyKrMo5
        1d/pHOsdoC63yzj60SmFOeL3
X-Google-Smtp-Source: APXvYqxbBmmF8P2GlngR6dKtgNi/1ipJpKhOIJola5eIKUtLrYoCvcmNvA3pymXBDbwkMD3NVZMTeg==
X-Received: by 2002:aa7:96a9:: with SMTP id g9mr6542447pfk.16.1568648810185;
        Mon, 16 Sep 2019 08:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
Date:   Mon, 16 Sep 2019 21:15:45 +0530
Message-Id: <20190916154546.24982-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Actions Semi SD/MMC driver with its binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c31e6492b601..d13138330b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,6 +1375,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1383,6 +1384,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

