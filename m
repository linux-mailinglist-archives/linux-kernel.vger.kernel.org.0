Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65713AD70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgANPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:19:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45467 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgANPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so6714153pfg.12;
        Tue, 14 Jan 2020 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ST7QEf8JaPsIhTPBLpP4peL3yXUV3NDdYF9SiuXeCzg=;
        b=IVlh6j/iSAlzh10qy/FDJ4HvKz7R892wUQuYxOTYHl2N97PS0Wd+wj3Vcue7B+cqjn
         +GUB4l5bI0/Eq5IssJDljQfcYTJ3oOQj4m33wenYcWvcEGIuzPtWFr+seGkEJtifjYEM
         OtOSSexK4L4a64yBYbhtlTy6uLShoG5jR7+VC1c4obRovM2+xRUGWGJiw4B/aVCuMioK
         mNIBgWFyvaKaUu0wWhRdQCyCAl99OH7jU+9lEHb1wEpM2H4qRPUR7G3e13xHve+pUgFB
         Sr3EsDENkZfV3fAXxfr8EULSslN0/W9x3sjP0V1ghY94OGauXGQdzNXH0qSYZ3oX9qdg
         SuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ST7QEf8JaPsIhTPBLpP4peL3yXUV3NDdYF9SiuXeCzg=;
        b=qKLW8ECzKkm0T5HhzveDbxoxqQapYtT1NroKKsDEy8dr3NtvsorKPe5EX48x/ZUS9h
         hsNPzPQJ+3UHEsbHL1zFmU82NcSiqVStv2dA65P8VI1wq7X9+BqD5gq6+ZxR1lMu3YLI
         xlDX25A8tkwHW7SQ4njRtv1xXeO0mgpnnOTZ33abbARS7qJKu6emwma+mqKxe358Bupo
         E79uj88B4t8P8RKhjlAqukUzkal9MVe8NT89Ypj1P3YeEivZjmlE1C10Y9QmBxk0MJSI
         feVK/JnP/8KutJVo9DeFaWL+2io7UU6PI9ip3Q9rZN85FSlSO0t1t2Xwn0PHOQauX+YU
         mBEQ==
X-Gm-Message-State: APjAAAUQpWjnIAKqPWh+x5CXjlLeboOPA5K+keKeMi3aKYzm8DDSEF/7
        gZT23zH4vxJxqbhS3MO9EA4=
X-Google-Smtp-Source: APXvYqwJlfdrCgQOUs+s+KcUfryciwUOYLQN9kEOTk43lgOjAPQX3p1bITQdDG6m0bJ77nBU9isuZw==
X-Received: by 2002:a65:6914:: with SMTP id s20mr26982174pgq.44.1579015172492;
        Tue, 14 Jan 2020 07:19:32 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:31 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: vf610-zii-cfu1: Add voltage monitor DT node
Date:   Tue, 14 Jan 2020 07:19:06 -0800
Message-Id: <20200114151906.25491-6-andrew.smirnov@gmail.com>
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
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 28732249cfc0..ce1920c052fc 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -71,6 +71,14 @@
 		los-gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		tx-disable-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 	};
+
+	supply-voltage-monitor {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 8>, /* 28VDC_IN */
+			      <&adc0 9>, /* +3.3V    */
+			      <&adc1 8>, /* VCC_1V5  */
+			      <&adc1 9>; /* VCC_1V2  */
+	};
 };
 
 &adc0 {
-- 
2.21.0

