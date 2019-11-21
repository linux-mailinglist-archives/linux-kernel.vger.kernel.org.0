Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35431056B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKUQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 11:13:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbfKUQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:13:17 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALFqFUB020182;
        Thu, 21 Nov 2019 17:13:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VJuIiYemz1wIoow996zFwaavl044qeXbEvuqGKKF5Ds=;
 b=PCGHYkrBzeoH80rs/cDrZ7d1oOJRYRIuSJkTD/ksDSdXcO8xe9drxCTdA6Uv/BtuDP/D
 aDF9ZgW8GI+fB8vLij6qzW1x9wSkvgj4YEXLzLzuDIvSkaUIcrnhsZw9/bQCN58DN3ql
 AQpURiiQOIOSTJC7FN+GKQbvKUNoPCWXVhGapq1oaZMTj6AW64C+OW/6n5e6CxlMAieZ
 nXhgHbbjXZ3NIh8wLX+BlKH3M1dCcfI8lSqVDQSzq5OgJBaoLck6yfNL1uF2HL16d3CZ
 OrFXNpJ7wD1uEdG//mtS7FcGzIlFI+G3UjggWfl4OiNxKsFDN57+PRlB1eoT1/yCUeY5 qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9usma9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 17:13:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 385EB10002A;
        Thu, 21 Nov 2019 17:13:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12E502FF5E4;
        Thu, 21 Nov 2019 17:13:00 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Nov 2019 17:12:59
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add phy-names to usbotg_hs on stm32mp157c-ev1
Date:   Thu, 21 Nov 2019 17:12:59 +0100
Message-ID: <20191121161259.25799-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy-names is required by usbotg_hs driver to get the phy, otherwise, it
considers that there is no phys property.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 2010f6292a77..228e35e16884 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -355,6 +355,7 @@
 &usbotg_hs {
 	dr_mode = "peripheral";
 	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
 	status = "okay";
 };
 
-- 
2.17.1

