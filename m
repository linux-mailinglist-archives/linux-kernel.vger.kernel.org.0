Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2897A33A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfH3JUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 05:20:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38437 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfH3JUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:20:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so3250371pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZqgNQFAGZFiAL+MaQauEs39+uIHNVqT3urPZ1OfwvY=;
        b=vEEMZErjrqbkE0Yt2O0M3pSZapLdQhKFR6Jz5LV86q7cH0uJZmqmSn4UxyeR201COp
         t3B6qRntiLYgA+1MM5JpQpQnA4+WGVyFeGb+b1QgOLONuEoeviEyzTo4mIlQU93a1cyP
         U7NKYVgViyjNKl6VAWDhM6ToSI2koxMxpXeC1NY4mItJl2YHEEHp0tTJrYrbsgtD6JEE
         2pzRxpKMONBU8+8Vp5/uO59LhyHzyL1cVOIb6hUmdqwFxrrzMUpe0jXUjvi/rel9OMRy
         RLuNThpYJNgLmIKuZd5POYNg07J5G0fODzVn5Oj4u/8XsYVAoYbIStDGTV+la2PeUpD6
         BUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZqgNQFAGZFiAL+MaQauEs39+uIHNVqT3urPZ1OfwvY=;
        b=RAWnu3z/7xQYUOhzoCsDLcWCBGOCPXEDhipD7kPWPeyw/iGARPFHcxIefLa3taLnkD
         I+w0szvpTjoChHMqhqczVUjBbeJWPGq7XctHJl0TT8k4cVMIEJoDXf7PtFY7uUv67BWX
         OkcJUH6nOLrSriy2TGSYuHyUL5josR4WPZaeoD0e1YpAtBHbgO2W3hPZSXJqwEi/NjCK
         epgcj8RsXKsWj8gpse1WM/VoKRsga89lela6qO3cY5xFZU1bgRijg5G6g1qsJ+EEywrT
         xhQsxo56V7GpX+dFOrfilOZifLGcltCSusrflsugfqSuq9wAgkZ8/OWdQImSMzCFYGrK
         +PQw==
X-Gm-Message-State: APjAAAXYyGWzxBNLSaKgdUg1btbUxjvfK17WN3ggEG/n/1WNDN9IKgB+
        jXyPp/61ZUN2s6/jkplzZDPy
X-Google-Smtp-Source: APXvYqzRFHNDr9oad7voBnS6/n543GjlV3A1iB44aDSh9qfP+WzcmpPz9MGSnjRwedesjP+mvAADmQ==
X-Received: by 2002:a17:90a:ad84:: with SMTP id s4mr15052314pjq.32.1567156808627;
        Fri, 30 Aug 2019 02:20:08 -0700 (PDT)
Received: from localhost.localdomain ([103.59.132.163])
        by smtp.googlemail.com with ESMTPSA id g202sm3142676pfb.155.2019.08.30.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:20:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for IMX290 CMOS image sensor driver
Date:   Fri, 30 Aug 2019 14:49:43 +0530
Message-Id: <20190830091943.22646-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org>
References: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Sony IMX290 CMOS image sensor driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7c84004187d..0ee261fca602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14962,6 +14962,14 @@ S:	Maintained
 F:	drivers/media/i2c/imx274.c
 F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
 
+SONY IMX290 SENSOR DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/imx290.c
+F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
+
 SONY IMX319 SENSOR DRIVER
 M:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

