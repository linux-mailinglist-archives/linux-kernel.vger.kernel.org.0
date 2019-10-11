Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22ED4239
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfJKOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 10:05:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728508AbfJKOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:05:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BE149M032059;
        Fri, 11 Oct 2019 16:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qvG5tHTLBfgJy2cVG8araZL9QxN9PV13AmMFSSV98WA=;
 b=GnXa2m+aBPMioX4V8sEPYum1RCAMQk88Mb+waGPqZdSxLN5/PkjjA7Nz+IXVbftr5FYS
 f3mPuQh+Trn/n9eAZvM/QKBfiYHJnD96sAt66gR+cFqkY3sMTHMsaNXuakMn01kuiIdr
 dNAW/mgaPGoMM1lwFw9RbUGXCb2b1VvtWCvMicKG9eXQfu28LVfkvCk1235NA7tiunZD
 Hz2aoKfrQct6+5pzN88RZsNZ3SDrWZl5LZtcJAlx35FFO/nyKgSAf6XhWWGrDIVRX/0p
 WuHXXJKs7JmWHQZ8NP/hgp5x5K8ESNPolM94HrlDZ8KfQQ7Nr+E5ul7/FX5g8N2EGL3V 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2ptnwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:05:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60D43100038;
        Fri, 11 Oct 2019 16:05:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 565DB2AD70B;
        Fri, 11 Oct 2019 16:05:39 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Oct 2019 16:05:38
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: change default minimal buck1 value on stm32mp157
Date:   Fri, 11 Oct 2019 16:05:31 +0200
Message-ID: <20191011140533.32619-3-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011140533.32619-1-p.paillet@st.com>
References: <20191011140533.32619-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal value is the value set during boot or before suspend.
We must ensure that the value is a functional value to boot.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 2 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 26fb7c77092c..efeefb3d25b0 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -250,7 +250,7 @@
 
 			vddcore: buck1 {
 				regulator-name = "vddcore";
-				regulator-min-microvolt = <800000>;
+				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-initial-mode = <0>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1dbcc580e43c..15afa8f1a36f 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -127,7 +127,7 @@
 
 			vddcore: buck1 {
 				regulator-name = "vddcore";
-				regulator-min-microvolt = <800000>;
+				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-initial-mode = <0>;
-- 
2.17.1

