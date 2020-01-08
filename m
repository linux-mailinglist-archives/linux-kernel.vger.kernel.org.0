Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90827133D17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 03:30:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39606 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:30:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0088UCN3040999;
        Wed, 8 Jan 2020 02:30:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578472212;
        bh=GI7gkdauZLR5mRQSIHW7zu5bpHRqesH98CX+JcZcEWM=;
        h=From:To:CC:Subject:Date;
        b=OJC3vQG8qN3Gyox9p+4RJklN3ynzwO9oRkv/vNITDykRvzqciiwP01UP7/W2Qme2o
         SnSxhqAsN5dwL2PzaA2lkOyrpGrEExM1x59Pt+uswkyIeKw68rZ2/ROq77mn2WhZNO
         /K4b63oD5Ip8TeN6TRMFi/4g5Wqiz3NW97MyK2f0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0088UC47108208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 02:30:12 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 02:30:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 02:30:11 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0088U8vY048698;
        Wed, 8 Jan 2020 02:30:09 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <jsarha@ti.com>, <rogerq@ti.com>
Subject: [PATCH v2 0/2] phy: ti: j721e-wiz: Add support for DisplayPort mode
Date:   Wed, 8 Jan 2020 10:30:06 +0200
Message-ID: <cover.1578471433.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since the first version:
- Remove the ti,j721e-wiz-10g binding change ("lane<n>-mode"-property)
- Add code to dig lane phy-type from the serdes's link subnodes cdns,phy-type
  property, defined in sierra-phy-t0 binding and hopefully soon in torrent-phy
  binding too.
- Rebase the patches on top of phy-next

The wiz wrapper need slightly different configuration when the wrapped
serdes is used for DisplayPort. This series adds devicetree properties
for selecting the mode for each individual serdes lane separately.

Jyri Sarha (2):
  dt-bindings: phy: Add PHY_TYPE_DP definition
  phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver

 drivers/phy/ti/phy-j721e-wiz.c | 59 +++++++++++++++++++++++++++++++---
 include/dt-bindings/phy/phy.h  |  1 +
 2 files changed, 56 insertions(+), 4 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

