Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B33C9D95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfJCLmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:42:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33536 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:42:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x93Bg5o1078189;
        Thu, 3 Oct 2019 06:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570102925;
        bh=oz/bIvQ4rqWyufq6vJCniBBXFBd9FPenYQM05c8kSkc=;
        h=From:To:CC:Subject:Date;
        b=uVfssUzlirsigRojwClcbNOiE9BqrhxcG9kE+myhSDPnPIxTdGD0faqq9z6fIpsOb
         Iqx9J4XdEeyJ1C2OpWIUPU37ftkiNRvzBYgKN34wKOshh2l5VkmzU/Em8TgkYhlzMO
         0GRhAmmcCfis8iC6bN9meplhWkBvu1bUZrB014Mk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x93Bg5x8108385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Oct 2019 06:42:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 3 Oct
 2019 06:42:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 3 Oct 2019 06:42:04 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x93Bg1G9053789;
        Thu, 3 Oct 2019 06:42:02 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am654-base-board: Add disable-wp for mmc0
Date:   Thu, 3 Oct 2019 17:12:51 +0530
Message-ID: <20191003114251.20533-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMC0_SDWP is not connected to the card. Indicate this by adding a
disable-wp flag.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 1102b84f853d..143474119328 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -221,6 +221,7 @@
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
+	disable-wp;
 };
 
 &dwc3_1 {
-- 
2.19.2

