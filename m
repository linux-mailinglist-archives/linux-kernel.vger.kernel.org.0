Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1196298
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfHTOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:41:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfHTOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:40:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so2843408wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtjbfzxxRQVlXomA51tccWbA15Rb8KwyrlxD2ZA+wlQ=;
        b=Y/hLIPMrAuVaUxTSVXjbJHQmQQ8JLEBe1TvDbYh0gvKcX2L/Q/YU6tCzL+yKFrGpZ5
         ++ri4z7NgbbXSYnpAP9cfnIKYfRqe6h736YsHvXgGFZfhrlp8i6rE9I0FqQeijg5Ywkd
         dSxEds04VSwwrRZjM0p1JUPOWxO0Drr+rqefb6Znck07/Vgb482CYubnYJfz1jZUuzGz
         ljFEX685mjvDyQG923roLxR5fBE0IEULiyQxg0QqAmYuxMTXDJH8LVbQYWH0KvnhG7OW
         D8IE/GWDFqaEzeeSTlYlvnjYGETQC7pdoEmQkBd1sT3eay60Q5JzCHIqi/MjXCwfRPFF
         Cz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtjbfzxxRQVlXomA51tccWbA15Rb8KwyrlxD2ZA+wlQ=;
        b=K2QUlOnM/IJzMdUwn6ggUDqYeN9yIPpOKZ30Bvt9mi3D5thY/WuMewaiCVbLwnODvd
         gWEwOPnKnzj69lmjQarhNLaPVfqmq0JvY4+sOesayBzdYfinlp+ttxc02Q6yi0RdTJjK
         mxzTJQou5pg7sMpE6/H6bD019vwbN1L57UVdQlu/hcUuWSdL52Xr+9VQkp0uyLYL1ugW
         KWLeH1ettHhq72qystFsLuFvKJ4ykJdbX4X1oOmbqesdCLolSXYLztONKN0y+BwcN2bV
         Q843kp+DH8y67MQHdw1HX80DDa0QSwvunYqYxiqwxWxoR4S6kB+QhTLJmI3lLVdZR9Xj
         aRWw==
X-Gm-Message-State: APjAAAWnwuk/d7QEeMMQMINz/GNE8ky3YNgYXDzzXoj7zL66LqFPoWp3
        El+ujH3MXC/fQ47uj3/yZpGIFA==
X-Google-Smtp-Source: APXvYqwBS4oD1m88wTCd7yYz/NuvNsTh8uemnpLC23aAqfqzhSziSlAqHUgACd7BA6CGz5CxGnWs0g==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr400414wmc.6.1566312057392;
        Tue, 20 Aug 2019 07:40:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm21826750wrt.18.2019.08.20.07.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:40:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/6] dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
Date:   Tue, 20 Aug 2019 16:40:48 +0200
Message-Id: <20190820144052.18269-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820144052.18269-1-narmstrong@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic SM1 Compatible for the clk-measurer IP.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
index 6bf6b43f8dd8..3dd563cec794 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -11,6 +11,7 @@ Required properties:
 			"amlogic,meson8b-clk-measure" for Meson8b SoCs
 			"amlogic,meson-axg-clk-measure" for AXG SoCs
 			"amlogic,meson-g12a-clk-measure" for G12a SoCs
+			"amlogic,meson-sm1-clk-measure" for SM1 SoCs
 - reg: base address and size of the Clock Measurer register space.
 
 Example:
-- 
2.22.0

