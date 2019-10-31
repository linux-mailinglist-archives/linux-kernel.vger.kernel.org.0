Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA49EB02F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJaMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:23:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38560 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJaMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:23:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id j30so475458pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dics1qLSQG/6LjTjU1Zksk8uqo/tbnnILQwq9HvjeE8=;
        b=BqkSGS3MEt3vqyBV2jt/evjT92CEC8fhA5pKhgaSsQ8tWWeOmTv581aMDyQGGAoM+u
         CizlHBmVS7JFv+AbHdVIc+fwuPNnYDQ5G0QdKchvh1pTgp29tF6A8zyKt1QvwMol/BRT
         p+m+UaMhQoR5c9CeXA4YXY2NWs4lmn2+jxCulIUrfb/1nlgCzquadJ4snfiwfiqBJOO7
         GsgrWxVtEQtBNSBAF4KO2JUtdxh+Jq/nS60cxugG06jl7Yqy+Gp+8LWEd1/z7LVsMtdg
         Ft/z8YOxhFafX9kqa0ciDJBhWo0+vNVMk8217RiU0dh+3EYYDQ8obAO1US0ZTzG8MNEo
         xeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dics1qLSQG/6LjTjU1Zksk8uqo/tbnnILQwq9HvjeE8=;
        b=mvgWaqPnRHG9BUEV1s9isvto505rn0Oyn9S74v5+uuY7qnBFRH5essXWJS06gjrfHc
         GxGROrIBm/jPlOqSLAeKqDNhKCuXaDl8qqFjqH7AHfoAHojVVMYjFbjdkHI9vttmWHiW
         uVYO9rEwhzsoVZ0UPpCYFBVfqXDn2EE8riXPbYNTAtz3gNhbFR+sJutQxSMv+TI6ovfa
         TzvnYJE95fIbZI0/AScMuy+Gvqaygtjx7jHnnj/FZdu/SMIWRFi6Idahi3lLXUZPX/22
         K1aItPlQBxsYh6G35Aig4dVyUMWzDZKxgkBrp5VuNE8HYrs0FdtKSg6locNzZWJjJx/W
         akRA==
X-Gm-Message-State: APjAAAXsI7B6/TpX9NBmp46M38gdQt4ci5eQ2W3uqMMooufqV86bvq5t
        b7py2UhB/H375lx7SuXR6OLn8g==
X-Google-Smtp-Source: APXvYqywmmnkq0C9/UxdrNA51atayjz+UUdnkuN6KmsYJy4LVGSMq8xCRtxjvmuamdEq9iWHISdLdQ==
X-Received: by 2002:a62:1d8d:: with SMTP id d135mr6267445pfd.172.1572524632666;
        Thu, 31 Oct 2019 05:23:52 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:51 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 4/5] dt-bindings: power: sc27xx: Add a new property to describe the real resistance of coulomb counter chip
Date:   Thu, 31 Oct 2019 20:22:43 +0800
Message-Id: <b7c373b4329fe7a506890dd4c4c53e73cc64ff8d.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new property to describe the real resistance of coulomb counter chip,
which is used to calibrate the accuracy of the coulomb counter chip.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index 0a5705b..b6359b5 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -13,6 +13,8 @@ Required properties:
 - io-channel-names: Should be "bat-temp" or "charge-vol".
 - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
 - nvmem-cell-names: Should be "fgu_calib".
+- sprd,calib-resistance-micro-ohms: Specify the real resistance of coulomb counter
+  chip in micro Ohms.
 - monitored-battery: Phandle of battery characteristics devicetree node.
   See Documentation/devicetree/bindings/power/supply/battery.txt
 
@@ -52,5 +54,6 @@ Example:
 			nvmem-cells = <&fgu_calib>;
 			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
+			sprd,calib-resistance-micro-ohms = <21500>;
 		};
 	};
-- 
1.7.9.5

