Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13AD3569B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFEGIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 02:08:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50460 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:08:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5568Gug005258;
        Wed, 5 Jun 2019 01:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559714896;
        bh=a94fUpioS4izc+o4g6o2VUCbyzE347IAgLbcvI3/KiI=;
        h=From:To:CC:Subject:Date;
        b=nsvXKu/2j0gD75zJgvrAysFGftWBmw6Eh9AkYKU1/j9CBgZqh232CdHqD6CQ3oVnZ
         KOpAjSAbEsJPFdpbrO038G3xUwkyxd2n+Nnn6WWCibWulrScoij2zmrXH+NnZCP49L
         g7hTfIjX6RIBV3+jJ8cfJxpQusLDn7ALh/SgAT0Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5568GtH129527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 01:08:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 01:08:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 01:08:16 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5568Dlg066906;
        Wed, 5 Jun 2019 01:08:13 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] arm64: dts: ti: am6: Add gpio nodes
Date:   Wed, 5 Jun 2019 11:38:43 +0530
Message-ID: <20190605060846.25314-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 AM6 platform has 2 instances of gpio banks on main domain
and 1 instance on wakeup domin. All are capable of generating
banked interrupts.

This series also adds 2 goio_keys nodes connected to SW6 SW5
switches and tested for gpio_keys interrupts.

The series depends on:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=112791

Posting as RFC as it has dependencies to be merged.

Keerthy (3):
  arm64: dts: ti: am6-wakeup: Add gpio node
  arm64: dts: ti: am6-main: Add gpio nodes
  arm64: dts: ti: am654-base-board: Add gpio_keys node

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 32 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 15 +++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 27 ++++++++++++++++
 3 files changed, 74 insertions(+)

-- 
2.17.1

