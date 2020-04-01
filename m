Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384C519B847
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgDAWP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 18:15:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10819 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1585779325; x=1617315325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q+aU/iQQvfxk55cYhF+FMj4swDv1lcqm+CLLatN93uY=;
  b=Jx3HoFHBgN5qMeGfO95NCzOgb5W3Fcxc+tJI/W63WpPk+eNnO/slpCiT
   b+hI5rQ5YndewS/YXStwwC2Rg+cj5Nca6Pu6pYK5gPxSima61wGbDgRjM
   qRD+AQm6AfYmNIhbCbnkbXsGjSKeo/OwEHuXZV6V0MXZkNueXboEuP9ZP
   dCGVnBoL6beEEvTKN4KHgjobdST2VJMrQgpnA6e2KqHH6aoOiGUZk2kUm
   GUQz+kVeYCqBSLwXMjH/Oli2VvdzpK09SJkCBHBS5REbVvaib1Cj7MCch
   PyWPM33/3gVLm/7qkyy3pCmjGUUokSsFPNKwq68srGsL902+X+WXjXKNe
   w==;
IronPort-SDR: VTuWgp/h+Vn0LpBSElgsPr6YWRBP/bAZd9DJJ0BkXaVblqc/GdNoXNmeWXOI9f2NUCbe68SP0w
 d28svC8oc/BX8fb+ZI39q2LVnhOKH2XYQaafLiDY8hf1tvVte3ZqKj7xbO/IZFkutpis1Smyvv
 d3IdXkE283D8g6BHLwqsIYO/bVsRataKpG2Xz8PQ28wXaTKM95KcoLy22YIkVYh4+Lc/Z5Tm/V
 wPFXJM14P3AqTNlKaX9GLSnde9DCPHgkQHVxnKxj/BRhSerWD5sTDQNWaPyKVxiY9MEG6fqtKv
 pEY=
X-IronPort-AV: E=Sophos;i="5.72,333,1580799600"; 
   d="scan'208";a="72005464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2020 15:15:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 15:15:31 -0700
Received: from sekiro.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 1 Apr 2020 15:15:28 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH 5/5] ARM: dts: at91: sama5d27_som1_ek: add an alias for i2c0
Date:   Thu, 2 Apr 2020 00:15:04 +0200
Message-ID: <20200401221504.41196-5-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401221504.41196-1-ludovic.desroches@microchip.com>
References: <20200401221504.41196-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add aliases for i2c devices to not rely on probe order for i2c device
numbering.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 1a26e1a129319..535627c6045b6 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -20,6 +20,7 @@ aliases {
 		serial0 = &uart1;	/* DBGU */
 		serial1 = &uart4;	/* mikro BUS 1 */
 		serial2 = &uart2;	/* mikro BUS 2 */
+		i2c0	= &i2c0;
 		i2c1	= &i2c1;
 		i2c2	= &i2c2;
 	};
-- 
2.26.0

