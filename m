Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3013AD72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgANPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:19:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45461 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgANPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so6714070pfg.12;
        Tue, 14 Jan 2020 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMWy9u/32jVL1tXriZ9xy59fE2pwEAGTC/AyEXL/bc8=;
        b=DcQbpa5XsdLmDArxppuX0QUlt+0JecePQVimW1hZS6yqNKV8WedJ1vYTK6hHiWOM0p
         os1JhrPNE+Dhkr1uyfcI5eAYf25io4b/BJ5rB4LgbEjujkmmRsoK6ODXV3TuUHyamQXu
         S+eMETdSe1vOKzDxMhPOh06+1tXqK4/ocIIonLHOUSlWv/xHXOHA0yjPmn8JSbhYMl4G
         fAdXP9drouHYBd30NfvoGcznbJzemetl2KLo86Hk1Nyx6pVtjLPwRB43/8j5uXhgRfD9
         EQctZimuVNgkcJ96A3Z3Ge7sPL20jd9/N2Na9pGKjcH+Jq+c8WnZ7TJ9mHuHCh0VvFhV
         sbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMWy9u/32jVL1tXriZ9xy59fE2pwEAGTC/AyEXL/bc8=;
        b=GY924RbmZNMeoF6n5hL4PuKZm9CEyFP0LLBJIDrhsisHJSSLLVG3iLWsEiB345sh0M
         dIFKh0sYjeksIpfPo9Hp6/Ak0Sj0Q9+uoZpDh44MPr2RTG4SjFU798Xio6RtwLY86hzF
         tH3eh3wD/4lhFNXN76F6GSDjW9UZhrVryETZJ44DmuaLiOlay3+8J6AkDCxY56sRpYs9
         jaJen4l3JKWAb4CHjpQyPXG4P3XYPnYD7L7p+TJOilZhXMsPM/NSeMfA3uRbhNNmu4c/
         Vp6HWuXfhVPhno+Oq11MEwtD1HPdovNC5FycgXkolFk9EbhAJIPn4vzZ/F0l6CPkmf88
         rJyQ==
X-Gm-Message-State: APjAAAUz7XRa/S+apl3QudYyXSutFrZfWAAbIFqumgUeR7kGqTumEb34
        tQL7bUJ9IaW/z/UJkZLrhg0=
X-Google-Smtp-Source: APXvYqzIQi4kLmAraK/ke5nkp/cK8TN4YzKhEtyN2XiAzZrW/qst02Mb/5Yu89lTJeh1dC98Y9Q3gA==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr27595123pgc.450.1579015167647;
        Tue, 14 Jan 2020 07:19:27 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:26 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: vf610-zii-ssmb-dtu: Add voltage monitor DT node
Date:   Tue, 14 Jan 2020 07:19:03 -0800
Message-Id: <20200114151906.25491-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200114151906.25491-1-andrew.smirnov@gmail.com>
References: <20200114151906.25491-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for various voltage supply rails connected to SoC's ADC
for voltage monitoring purposes.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index 847c5858fea1..a6c22a79779e 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -46,6 +46,14 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	supply-voltage-monitor {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 8>, /* 12V_MAIN */
+			      <&adc0 9>, /* +3.3V    */
+			      <&adc1 8>, /* VCC_1V5  */
+			      <&adc1 9>; /* VCC_1V2  */
+	};
 };
 
 &adc0 {
-- 
2.21.0

