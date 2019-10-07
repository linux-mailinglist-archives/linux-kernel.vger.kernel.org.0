Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C95CE560
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfJGOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 10:34:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38379 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbfJGOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:34:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97EVZUT021985;
        Mon, 7 Oct 2019 16:34:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=s8U3If4pz6kSoHoO7elZBldrDddqWyD7m4mUvvsfdn0=;
 b=RKSb5FRIEhidJ5Ig9iqL2aAb+78dyQfKZ9LWDNuQ1HHi59CLTMHHAd878PewimsLUOXN
 akFqi6WxYNuNSnuJYnUgTz/h/r5o15J3vHhMLQvQeDnWU7YJlmQ/Kj6hpqYUU8YBZHtw
 +a1vwmiTblwP+qm7ux6fZeT+Rqa/1rmG00GLnQ1aZIHjYqMpruvBPfw7S0tE0WLJBZLn
 M2497QF0Y5vrCvEyX+2dLtOTIi0yLk6hbpA0KgKfXfVG9f6ICEBJURsZUyCrV4ETNGXr
 qHo5u8GdVbmv2ehnJ8J71pPkuMP64KlHj641fGNROz9GvvnQNY95vxAl9vDMfp88GX00 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxvjtj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 16:34:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4A5710002A;
        Mon,  7 Oct 2019 16:34:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 995242AC883;
        Mon,  7 Oct 2019 16:34:07 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 16:34:07
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ARM: dts: stm32: fix regulator-sd_switch node on stm32mp157c-ed1 board
Date:   Mon, 7 Oct 2019 16:34:02 +0200
Message-ID: <20191007143402.13266-5-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007143402.13266-1-alexandre.torgue@st.com>
References: <20191007143402.13266-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes regulator-sd_switch node in order to be compliant to
DT validation schema.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1d426ea8bdaf..329853d9b1de 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -100,7 +100,8 @@
 
 		gpios = <&gpiof 14 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
-		states = <1800000 0x1 2900000 0x0>;
+		states = <1800000 0x1>,
+			 <2900000 0x0>;
 	};
 };
 
-- 
2.17.1

