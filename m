Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5413185A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAFTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:10:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:10:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so27284090pga.6;
        Mon, 06 Jan 2020 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UWJNKwGSnZRp2VqvhJODGUDqM6guG99MwzXRTV7Nb0=;
        b=ipVTd/8WzUVxxKpTAZ5SKS4Qu+ymKDslRCsM2dW8CGQMRNF6NzHNamg6TOhJBPyGg4
         ORhCV/Q5T8y2fc6B1zO52fudCe7Ri99+HF+7CYMnu/g6aUg/jkTAxDng5wgqVlYQPW5M
         Eb1mHgurqw9jEMBxSZrCkCc/YNhvW1uG9OzYyDLsfbfTLtq8DxHe2/KfwxYAVG5uY07m
         Bu+Es72kW0OdrMRIyWbKxuwGZnqRBRvhXad4hOpPqKc9VD/hJXtap77MbDviSyNM10Wi
         rq9UBlVrwtu3Xybe/h9VTxYu7wSVEZitLRu2ig4aK71hqy34yItwhdaoDe3AQ1acwACR
         8n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UWJNKwGSnZRp2VqvhJODGUDqM6guG99MwzXRTV7Nb0=;
        b=pYL5uIdx7aZJKyaWj2wLXAJeeqolVv6liUqzlcoS60wXfZgwjqP2mVvsE61NAJkr4i
         ytqzTjV3U4aG8EOKU/8LT8svShR8ZN8Cds4LtnpGBfiVCYydEBx1ak3XnlQ1wdrJF5DZ
         U5p1YqY+I/N9/DfLQwferxZVhYpCM07XXOg4ajtm3QX8DOgsRBw68lyaAX0KIWvT4PWl
         0yumoBq6/vkNYQlM956/VHWPGY3ozxW+Q+j60W0lo4gKzoDwdzorinWIsJOP/vdYmOaM
         bWfcYT+2jS96ZEiOouiQeElvhMcSJSkCDi2siBZrdoXjg5l/mF6uMpvfpRGriCCFYaLJ
         rHTw==
X-Gm-Message-State: APjAAAUKM1ip9WzZeKOf1SqNxX9cNE529WGMLPVN1zdieadwqUG/nbsV
        eOLr9cXpEa0iZb4hStipdSI=
X-Google-Smtp-Source: APXvYqy3M3OIjOkADUaBh75HkL/X1n2uuXocdJbwJl2rTbC++kuHHBua+mNCifGNrP3hQMUCclRBEg==
X-Received: by 2002:a63:7705:: with SMTP id s5mr110197804pgc.379.1578337808378;
        Mon, 06 Jan 2020 11:10:08 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s24sm24868480pjp.17.2020.01.06.11.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 11:10:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] ARM: dts: exynos: tiny4412: add proper panel node
Date:   Mon,  6 Jan 2020 19:10:03 +0000
Message-Id: <20200106191003.21584-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191003.21584-1-tiny.windzz@gmail.com>
References: <20200106191003.21584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add at070tn92 panel for tiny4412 board.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 2b62cb27420c..57f9d09233ad 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -66,6 +66,16 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	panel {
+		compatible = "innolux,at070tn92";
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&lcdc_output>;
+			};
+		};
+	};
 };
 
 &fimd {
@@ -74,6 +84,12 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
+	port@3 {
+		reg = <3>;
+		lcdc_output: endpoint {
+			remote-endpoint = <&panel_input>;
+		};
+	};
 };
 
 &rtc {
-- 
2.17.1

