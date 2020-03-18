Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6462518A1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 18:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCRRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 13:42:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50201 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCRRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id z13so4455133wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45CQ8c/ky8+0hWRFL237+1ux25bCOkBLBHqU2LowH0M=;
        b=l0VQr5mC3md/yc+VTMrmxepUnhjah0lZIYK2r7WLXO7ppE+yyU89k0v0F2azUublEl
         xOFDyh1dyxRRbp9BjxkhBD+KOPdt0F2SpZq0/LgDt0f2zwbQQBRiBhj6yZ9SgDbD2RR7
         Fp+Nl4hRboRcU+g6Thy/1t5M83o5lVqe3axF/6i8AxrbGL1kQ1tzkUqCPIYS98/JEiXv
         DkyagZ/Xr+uG5DT7l+Qnfgkvu0TM7onK4n/xifH33P2UUwwH9W9re2qJ3dzSJff/OAn7
         GC3j5hz/usUgdVPW/5A1UBFGdy6Edn7/D6hyYQ7zxqVruy2Gi9JOYoEoQnCGKkx8OtRS
         fR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45CQ8c/ky8+0hWRFL237+1ux25bCOkBLBHqU2LowH0M=;
        b=dBAlIKr3mOMMRPwdpXJij5Si7CaGHu9MvW68JGyJHkAPGZF32a0sEVT3LrBO8VAGdH
         5aG8o6qumJ0aM5hbSwt8kacXHFmCrJQeQ2jouMRT4sPJ7KtGzV91NgCJwSOjphO6ALKg
         eNJR3mdLZHLrOkrVCorWb9Rxy+J3Zv2yFG2Z9QeFz4/SA/F/+pp7V6C76yvpSF6Z4HYJ
         QomFjzeu9XOjTvXn13wnV+MFgaHW9FWp5g9RCS1ALlPh1wEFgih5Yc+fjYcu6EIEeQbt
         VJp9zdA15Pp0NZcFkUPNjSMXlFXnXXcfGZDuEnToxzBjwaJh5XzTxYkgMcpCJ/CiqcTB
         EzqA==
X-Gm-Message-State: ANhLgQ1G6bUrtsmKKZ5b3CmZUHG9p3rfhEQ4LFUldXEhnirVe89tDx9p
        5G/kO3m82kpwiBNa1pf8/iDe5Q==
X-Google-Smtp-Source: ADFU+vtlmsP4Fzzm2b6i3cJ54foljjmSawZHfzfOoF20h8kyAxh5UcH/0hm97qd1WX/56Rj1kxhACQ==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr6288616wmc.30.1584553340468;
        Wed, 18 Mar 2020 10:42:20 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 03/21] dt-bindings: fttmr010: Add ast2600 compatible
Date:   Wed, 18 Mar 2020 18:41:13 +0100
Message-Id: <20200318174131.20582-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

The ast2600 contains a fttmr010 derivative.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-5-joel@jms.id.au
---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
index 195792270414..3cb2f4c98d64 100644
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
@@ -11,6 +11,7 @@ Required properties:
   "moxa,moxart-timer", "faraday,fttmr010"
   "aspeed,ast2400-timer"
   "aspeed,ast2500-timer"
+  "aspeed,ast2600-timer"
 
 - reg : Should contain registers location and length
 - interrupts : Should contain the three timer interrupts usually with
-- 
2.17.1

