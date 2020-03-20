Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEB18CF01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCTNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:35:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40410 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgCTNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so596049wmf.5;
        Fri, 20 Mar 2020 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=eg61IfGRG4RM8ATBwaJ4ZflHXV9nWhy7dN7OcN/Yia3AMeGSxeqQE8Ur1H1QiQSptW
         NzD7kEzRRXWhsycMK5RUD9ok0rOe7fTyZFhemfq1mYc4+00cpHoLEGkZ05f5zBchT1lm
         bRE+lS9yG87M4n6QpGK/aVcIfldB0NXrLEYyuNS1xW4Ie8v70Yh4v8BQwcTMZi8pKFla
         bDddRe0XGUNzhI9bFTpXPzpYnnqV5Hak0lM383qta3X10KbU8wCsPX5nQ5U54nVIKM5y
         pNUXz5Ex3pS4d5eWwxuZqyJX+E3JAwlFnzd8yidtsGVuvsmMwF1m8DDtCMa/qaNMgO7M
         Dwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=Jg3rnTZ2gQ3tc+nvd1Ss+8o7Nply/b1fJG9RKzYJQ3Ufn0Nia28xx7/bG2bybfC4QI
         rLPuLjxQo1D5/IUuJu8d7yabRl6zyf8UFbbmkjDPcTjQcXVbj1cbwVUrlEAanwgFEeFa
         uKZ72cCfpJDDLLoXFETcOeex76IHxS9RhXmFWG2jS+rTcA9hIgBH/8Zu8odLPZlHYeMB
         4SitFA2MW7yIsVga+7JZYN1RIYAAQx9NpOj+zfEM8Xx/rS2FiUshu6eL5BI0MIVTOoKr
         kAHzL+1pxoJ/UwEwS34pO76sHB4tr8XScM21SxuClH52iWGC2SescQ7nXFUTLMZ1uPN4
         h1JA==
X-Gm-Message-State: ANhLgQ1nJIc0BLBi1OSKJl4Cih37OPWt8cMH+Oz1J30vGzq/bZi2JBo8
        fXr5Af5Zxul8ENEFY0yYdqQ=
X-Google-Smtp-Source: ADFU+vuLxcyO2KD5jaTVUfpSqHOfct7nsy9xBH35W2ZSyqKfS427VdekhuvEWxvY0ML9TdMPqddS6A==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr10159562wmd.1.1584711316042;
        Fri, 20 Mar 2020 06:35:16 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id v21sm3105535wmj.8.2020.03.20.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: tegra: Enable native timers on Jetson AGX Xavier
Date:   Fri, 20 Mar 2020 14:34:52 +0100
Message-Id: <20200320133452.3705040-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320133452.3705040-1-thierry.reding@gmail.com>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable the native timers on Jetson AGX Xavier to allow using the
watchdog functionality to recover from system hangs, for example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 623f7d7d216b..d68588f2709e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -52,6 +52,10 @@ memory-controller@2c00000 {
 			status = "okay";
 		};
 
+		timer@3010000 {
+			status = "okay";
+		};
+
 		serial@3110000 {
 			status = "okay";
 		};
-- 
2.24.1

