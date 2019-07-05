Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC3608CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfGEPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 11:12:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51142 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:12:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x65FCqTo112689;
        Fri, 5 Jul 2019 10:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562339572;
        bh=jhZ0U6kuPSnRvJ1GMDYkwAE5tkV0mIxZbCP4J8vReUE=;
        h=From:To:CC:Subject:Date;
        b=qPYxB52TUhrAtLWFcHnYbt5bz9s2GBxDcHKSE3aRM/LHT5y43y0af9RfcwkUi/tow
         hU8xodDwzTG8MY+dWHGz2jNJqsBU1+DACvKHuA67mtonhdb6n4yAt9/UX78HO9F2o8
         PbVUmh5zuRiAw+hG6Yvknfl/cics1ondnjm2LRMw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x65FCqoC088518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jul 2019 10:12:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Jul
 2019 10:12:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Jul 2019 10:12:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x65FCpjx069375;
        Fri, 5 Jul 2019 10:12:52 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH next v2 0/6] ARM: keystone: update dt and enable cpts support 
Date:   Fri, 5 Jul 2019 18:12:41 +0300
Message-ID: <20190705151247.30422-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

This series is set of platform changes required to enable NETCP CPTS reference
clock selection and final patch to enable CPTS for Keystone 66AK2E/L/HK SoCs.

Those patches were posted already [1] together with driver's changes, so this
is re-send of DT/platform specific changes only, as driver's changes have
been merged already.

Patches 1-5: CPTS DT nodes update for TI Keystone 2 66AK2HK/E/L SoCs.
Patch 6: enables CPTS for TI Keystone 2 66AK2HK/E/L SoCs.

[1] https://patchwork.kernel.org/cover/10980037/

Grygorii Strashko (6):
  ARM: dts: keystone-clocks: add input fixed clocks
  ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
  ARM: dts: k2e-netcp: add cpts refclk_mux node
  ARM: dts: k2hk-netcp: add cpts refclk_mux node
  ARM: dts: k2l-netcp: add cpts refclk_mux node
  ARM: configs: keystone: enable cpts

 arch/arm/boot/dts/keystone-clocks.dtsi     | 27 ++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi | 20 ++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 21 +++++++++++++++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 20 ++++++++++++++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 20 ++++++++++++++--
 arch/arm/configs/keystone_defconfig        |  1 +
 6 files changed, 103 insertions(+), 6 deletions(-)

-- 
2.17.1

