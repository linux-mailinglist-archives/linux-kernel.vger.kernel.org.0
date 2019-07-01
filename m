Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9EB18432
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 05:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIDnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 23:43:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfEIDnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:43:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x493eJIh001764
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 20:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=2Xq1fZbSGx7sGAlCfhWxlUKOgKugdwrzKDQf0B0Gy7o=;
 b=i7532dnch13vYyLG1dGVBG7jjVx1rTKFZ6aWW6ohde7ET6fwUSYFs8gux3GB1lajxhaT
 0QQD490sewPMEpZL00kdsck+KG9aNjcEVNP/lMbr+Lmg4yDUqO4VXv+WCBoM2QxCGHlQ
 Z43JqssVvU/c4TOl5ehng0bu2svtqIAPWA4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sc9fr0fvn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:43:39 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 May 2019 20:43:37 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id A5EDA14791B0E; Wed,  8 May 2019 20:43:36 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH] ARM: dts: aspeed: cmm: enable ehci host controllers
Date:   Wed, 8 May 2019 20:43:34 -0700
Message-ID: <20190509034334.2165789-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=740 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090022
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ehci0 and ehci1 USB host controllers on Facebook Backpack CMM BMC.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
index 43aba4071a5c..d519d307aa2a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -372,3 +372,11 @@
 &adc {
 	status = "okay";
 };
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
-- 
2.17.1

