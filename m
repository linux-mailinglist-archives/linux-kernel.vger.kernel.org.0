Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE31B8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfEMOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 10:44:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37169 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbfEMOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:44:13 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEasOC013962;
        Mon, 13 May 2019 16:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=LzYSQmTyf5/EQ3Y2VGObHjM41SSi7kcFjXdBikk9ZQs=;
 b=D2M3OXToJoyZG8oTLgstVeyWRDkzT6VNeWCXJTfWcpHxyJc4PA7mCzyqvmq4cxu7ryul
 v2OFOyxbcTlKXctUYf+Nc+pYB8SsToee1LFsjh9PVLd9Qrn8Dy8QYwrNkFUsqioiGe6J
 rn0fkNDJnEWSyISi6AlYQmR9gn6baK4Ag3r1apREjv/GDEWNCZw/VbBvhksG4UYLDRTJ
 5hLeg+m3yWtFQK53TihN+izJlWRdwrwJ67x0lBpbNeST3KHQOBbzsDl2eDXeUAajGhwS
 U4NxJCJPdIA6CnQ8KaxP/6etvMDd6/xdzjdLNEUJ/SiaOlvpYrJ/Qy4bsGNmDl/b9QcG Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdm5tugnt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 16:44:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBE9438;
        Mon, 13 May 2019 14:44:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D01FA2897;
        Mon, 13 May 2019 14:44:03 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May
 2019 16:44:03 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May 2019 16:44:03
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: display: stm32: add supply property to DSI controller
Date:   Mon, 13 May 2019 16:42:18 +0200
Message-ID: <1557758539-28748-2-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557758539-28748-1-git-send-email-yannick.fertre@st.com>
References: <1557758539-28748-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of a new property phy-dsi-supply to the
STM32 DSI controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 3eb1b48..60c54da 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -40,6 +40,8 @@ Mandatory nodes specific to STM32 DSI:
 - panel or bridge node: A node containing the panel or bridge description as
   documented in [6].
   - port: panel or bridge port node, connected to the DSI output port (port@1).
+Optional properties:
+- phy-dsi-supply: phandle of the regulator that provides the supply voltage.
 
 Note: You can find more documentation in the following references
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -101,6 +103,7 @@ Example 2: DSI panel
 			clock-names = "pclk", "ref";
 			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
 			reset-names = "apb";
+			phy-dsi-supply = <&reg18>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.7.4

