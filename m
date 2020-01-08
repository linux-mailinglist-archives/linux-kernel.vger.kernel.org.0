Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E613403E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgAHLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:18:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47146 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgAHLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:18:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008BIZGW061012;
        Wed, 8 Jan 2020 05:18:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578482315;
        bh=FqLEC/pOsMBk7A5Md0tMMrU9uar+Zzvg0fxQuLk+/v8=;
        h=From:To:CC:Subject:Date;
        b=Yn9zu4K1ug9wF+fp3naS2855kYroZsQyEECw3YHy0CxxopYBWwOhm+R/0JmMBKBb9
         aQxLoPpbbb5n9juD8ooVqpwqcI6RfL1qB4+Uu9Nz+eOfZjiAYQYTrb0qDLPn87EkeD
         SXztwnCvOYC9zY16rLjwKMVnK0y05UZmiFmwWuJo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008BIZDX036566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 05:18:35 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 05:18:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 05:18:35 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008BIWBp087830;
        Wed, 8 Jan 2020 05:18:33 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <kishon@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/5] arm64: ti: k3-j721e: Add SERDES PHY and USB3.0 support
Date:   Wed, 8 Jan 2020 13:18:25 +0200
Message-ID: <20200108111830.8482-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

This series adds SERDES PHY support. The relevant PHY driver
and bindings are already Acked and in phy/next [1]

It also adds Super-Speed support to the Type-C port on the EVM.
The USB Type-C related support is also Acked and in phy/next [2]

Please queue this for v5.6 if no objections. Thanks.

[1] https://patchwork.kernel.org/cover/11293671/
[2] https://lkml.org/lkml/2020/1/6/303

cheers,
-roger

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
  arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl node to select
    SERDES lane mux

Roger Quadros (3):
  arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
  arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
  arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR
    line

 .../dts/ti/k3-j721e-common-proc-board.dts     |  33 ++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 274 ++++++++++++++++++
 include/dt-bindings/mux/mux-j721e-wiz.h       |  53 ++++
 3 files changed, 358 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

