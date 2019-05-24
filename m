Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF729697
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbfEXLG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 07:06:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42320 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbfEXLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:06:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so869420qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dmqx6gjtvB/VaDf5QBAlSpVq7H2JKYjSrkF3yPvsxQ4=;
        b=SWdHc8J1RJHcC07el0scNt8mK1hKhCDDxE7stQxC3Xdd3WDNxZYM6Sig6wf1lqLtIu
         X4t4yxsyCE76oWbBKqpaTItNCqZf48OoN1i4tVWt/jcCqABcELJSuPFlOIetzTMMP7z5
         GPdn7Ja//b/YQ+m1LalyRoymtTuCNsonvxJg/8kzo1bSqqnAg1pFDlA+psjNK+7aCCBQ
         yoX7UvHe20SAJ2ev796tN0L8DIOnzjihebJRAbWS5YMTCG1+jACKgy6WMDkHurPFE9R4
         YH6noxyQG5WyG6su29yRrcH8SQktYke8TUgJimb57dsoY+pInBUsjrammSFqgX1mgGJs
         8zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dmqx6gjtvB/VaDf5QBAlSpVq7H2JKYjSrkF3yPvsxQ4=;
        b=DeqbMe7smd2ZUA/6EUTEvGvPd79cYxnM9gTzu0ReiZN2eEPKxOhyr2ZKXoY3ppN0W5
         U79tnVyh0dnwzQrfXaj7MkOnVKa0ngKQAqcrP8P/Ei37DXZc40jeKsjCi8oQ0ktRW51N
         KWvMdehtxnE5SsdlnaeHSR/kp0/zkCCfIjNVJZGtTzkf7sFStW9uZ5S82MlO3Bthx/62
         m1HGJ6QH5qVAOBO1LVhcIJtA2cUxAbSg9H5nVZVsaccGrIeWkS4hr0ud9tb9lYDZBeba
         k4Gg2S0suMjQ4ClgBYZnkEVOdZbaUYX4ff5heUz2Yo55HksyJ9keoscOa2ZXMDxKTaK4
         Rpeg==
X-Gm-Message-State: APjAAAVnZLc0G7jhLF2O5WcSB9pw0qFxulNzlvyL28f76K1626fh8Ixx
        EnuLhZn3QW7aiVPP9Ao/UaKPxd7R
X-Google-Smtp-Source: APXvYqzbjHtB0ybJrblgvtdKy43ASQy+jKf8xf1ec+YopDm5ZzBRi+rr4lPtjG0y+/F0KM+x8VgBGw==
X-Received: by 2002:a37:480e:: with SMTP id v14mr59758264qka.344.1558695985340;
        Fri, 24 May 2019 04:06:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id v25sm1429366qtv.2.2019.05.24.04.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:06:24 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: reset: imx7: Fix the spelling of 'indices'
Date:   Fri, 24 May 2019 08:06:25 -0300
Message-Id: <20190524110625.17407-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct spelling is 'indices', so fix it accordingly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 2ecf33815d18..13e095182db4 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -45,6 +45,6 @@ Example:
         };
 
 
-For list of all valid reset indicies see
+For list of all valid reset indices see
 <dt-bindings/reset/imx7-reset.h> for i.MX7 and
 <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
-- 
2.17.1

