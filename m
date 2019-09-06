Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B89ABA3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbfIFOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 10:05:58 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46019 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392565AbfIFOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:05:54 -0400
Received: by mail-wr1-f41.google.com with SMTP id l16so6686255wrv.12;
        Fri, 06 Sep 2019 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=JAO4l+aNXT+ppe4+G6QuuzDNKHoS0B8hYBszu4W2QrYj1ILHp/3I2LcXFmDlAE3p3Z
         WBYU1UvWb9k5N84Ij0wI5Ff9xbHVse9QnQIsK1Fpttz0ri5xjxqzgR8udpRWb0xLQvCc
         4l/X/Hyd0D/XRuHp/tLfols29gVe7i/c/0Cvk+GjJWTll5q4H/ITrDHVTr6EDWHuY6Jv
         mXOcXlIpVP+CfsoLCG09Q5HsKreeAxAEA2lVNVtUheEizmPtscmpHJcRKOxdEIKZCpbq
         JR96v+f8LIAY2uJ9O8OSEwlJEpPYCd3/7sxvhaJ56JAreGmxIdf53uBVM6KcuLFML6n+
         j8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=QzUuHKupTIXciBPYFwOmaC3OTPa+rxyoeQ3P9FeY2Zy948ic7HUF+AN6FQ8YwkhMO4
         wr4vbByx3M00TZS8byNF37fkOI51y8S+WehOwhhaKadRj8vvAsfjygMKb8CPnWCJu493
         gcC9XApSJ9TXvTzrHmj9AiDTGMo8tF/gvjgvllbPpykcFpCFOSA7YjNAKM70LyNulZOe
         44gifYUXhqQ3Yii+ElAWKJnzPx3aURcTmaKeiSwhkiHHDYXKWLHLoslmM1oYy5f5Xf3S
         0rootHZnPPyuBuW9yLklBG9PjmDCNaNcxBP4ATUKyQujPoIrdenwyXeVeIK14s/O6W5E
         pYuQ==
X-Gm-Message-State: APjAAAVfc+Nu2x9u6L482Kt8AFmGFJdjVd2M0MFk3r8dkW6ho3OSZR2p
        NtSwW66m21EvoZl+IPXKiC0=
X-Google-Smtp-Source: APXvYqzYGaP/LIMML4wqp7oPFlAnOx7BAgRaP8hZH19dGjuCe6tr4IqS+370vWyzDV35l50+uStCMQ==
X-Received: by 2002:adf:9083:: with SMTP id i3mr7775711wri.310.1567778752389;
        Fri, 06 Sep 2019 07:05:52 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id e20sm7480542wrc.34.2019.09.06.07.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:05:51 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Fri,  6 Sep 2019 18:04:57 +0400
Message-Id: <1567778699-59231-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567778699-59231-1-git-send-email-christianshewitt@gmail.com>
References: <1567778699-59231-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes/Dongles,
Digital Signage and Advertisement Solutions [0].

[0] (https://ugoos.com)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..d962be9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -965,6 +965,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ugoos,.*":
+    description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.7.4

