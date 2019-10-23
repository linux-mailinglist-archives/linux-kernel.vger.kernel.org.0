Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1746BE14A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbfJWIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:49:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44632 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390343AbfJWIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:49:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nOrX035706;
        Wed, 23 Oct 2019 03:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571820564;
        bh=eLinbvw4gjmm5Nbit2fMNFycPxhn1FFlzJoOTuRSlmk=;
        h=From:To:CC:Subject:Date;
        b=gcPDrLK0+Np7MivJLpjA2vKR9L7vM4m7/QYs8sXMNnSn6j60aMqt5QRBFKoqCq6PR
         Ah7dp+HT792jPeoQ+zxd2+kB4+HviO2djiE88kDz3swNPBmV155sZeL5+MFRyVyxwZ
         YByPIg87o5Mg9YF2+ppU/1KZxPTiDlopKaqog7ng=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N8nNQD127748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 03:49:24 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:49:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:49:10 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nHVt061069;
        Wed, 23 Oct 2019 03:49:17 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip support
Date:   Wed, 23 Oct 2019 11:49:13 +0300
Message-ID: <20191023084916.26895-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On J721e platform, the 2 lanes of SERDES PHY are used to achieve
USB Type-C plug flip support without any additional MUX component
by using a lane swap feature.

However, the driver needs to know the Type-C plug orientation before
it can decide whether to swap the lanes or not. This is achieved via a
GPIO named DIR.

Another constraint is that the lane swap must happen only when the PHY
is in inactive state. This is achieved by sampling the GPIO and
programming the lane swap before bringing the PHY out of reset.

This series adds support to read the GPIO and accordingly program
the Lane swap for Type-C plug flip support.

Series must be applied on top of
https://lkml.org/lkml/2019/10/16/517

cheers,
-roger

Changelog:
v2
- revise commit log of patch 1
- use regmap_field in patch 3

Roger Quadros (3):
  phy: cadence: Sierra: add phy_reset hook
  dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
  phy: ti: j721e-wiz: Manage typec-gpio-dir

 .../bindings/phy/ti,phy-j721e-wiz.txt         |  9 ++++
 drivers/phy/cadence/phy-cadence-sierra.c      | 10 ++++
 drivers/phy/ti/phy-j721e-wiz.c                | 48 +++++++++++++++++++
 3 files changed, 67 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

