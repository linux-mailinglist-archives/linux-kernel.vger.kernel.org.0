Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199F66E16F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGSHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 03:10:01 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39370 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfGSHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:09:59 -0400
Received: by mail-pl1-f180.google.com with SMTP id b7so15192482pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wejlJJPjvhTTbCNGB4VjnLtYjtQuI5s6iJfj743WH8I=;
        b=lmu043Hz6zAVciotAIw/JtZ9gpdYGTWPlmxnLrJhHiguq63+npVZdwXC9Yq94o9dJF
         S4TYuKUcrC6nPnjd3BoJ26izYVnpbfMWHrQvcpxMsztSF9K7Kvnfu1Vdky+C9p+gB1Zp
         Oh98xM0LMQHYPgE5MPM55pH1qK/dWz/oMTk9FAQNd/n2TLrd4Zx4+cJg4skaK5RhkwQ5
         mmYmxYJ+RsBdPoz6T2IK9wpbNw8VVu3BekgcTs1guzTY3y5zCFtFv1TktgnaCAkobBJR
         6fZY01Q5OT7IG4FvrdcYcT6OueIt4s/UXex6ghjoDNm2sLmYY++Lg/bJlFs7dvfH+KVO
         RiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wejlJJPjvhTTbCNGB4VjnLtYjtQuI5s6iJfj743WH8I=;
        b=DudBCaIib0pKzZ6+RxLZl5fz4lbE4QJV4SkLyYBAIguoYBjYBHoetzLqEs61PyaBAW
         wKJw5etT+CLNYnrSnHnbDJxWnwwpmlCBS9ncDdQbV8OrGbFZom1ck4VXvO2CGZSXfIn6
         qkMCUi0HDj7Pb1uc9M8dimTJT4AcxjAIsdZvVaPWgWXFDKGypwHPdpo6Fmb0dVFsNv/i
         1XUWR/YWqmfIuhLCOzOh/tlbhOu8OPyE77CPpF7Mfvbh8hMZGJfoX1bNspHeoH3Lu3d6
         VlnhbEXvkc2tjDfsaEXIfWMG8xJb1xFjimwLJZ23VGwKUy6i7Yq643EC0osTOzW+aiDx
         IUZQ==
X-Gm-Message-State: APjAAAVxduO054Mia+8+L5pTxcAvOoPenn4gJyoSGaGrJCUyO5Bwm9SN
        iljGSkLrnlmbnYRTaEpHpCqB
X-Google-Smtp-Source: APXvYqyvX2dItjj9s9D7tuG12+0UPJBQozTDJS4lYY0lsaWB25b6IUqfd8X/oUBdeEUOluWrLVNr9Q==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr53150658pll.339.1563520198971;
        Fri, 19 Jul 2019 00:09:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730b:4a40:d09e:c7ec:fbb:1676])
        by smtp.gmail.com with ESMTPSA id r6sm56259346pjb.22.2019.07.19.00.09.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:09:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: Document i.MX8QXP AI_ML board binding
Date:   Fri, 19 Jul 2019 12:39:25 +0530
Message-Id: <20190719070926.29114-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org>
References: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree binding of i.MX8QXP AI_ML board from Einfochips.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..8e9209a75478 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -180,6 +180,7 @@ properties:
       - description: i.MX8QXP based Boards
         items:
           - enum:
+              - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
           - const: fsl,imx8qxp
 
-- 
2.17.1

