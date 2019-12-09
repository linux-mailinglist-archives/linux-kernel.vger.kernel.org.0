Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF47117166
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 17:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLIQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 11:21:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55642 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:21:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9GL3un050848;
        Mon, 9 Dec 2019 10:21:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575908463;
        bh=j6oTo7CVj7FuC1SsWtEc1sMrNwxCQCHweFOub4ID3sE=;
        h=From:To:CC:Subject:Date;
        b=sPV3StQqHscdsaHS1sRGIPzRXcVB9O2HmH0QuMq9nqulQFOALFa2zdW0glW8ZTkGN
         JZFOJZkGDbMod/sqrUQf2PV70+ggrVc2PmzZdA7HXhfC3kHNNDXVa70R0BAsC+RryZ
         SwykPXHYS8heebmx29zhsUPmZrHSG0kXh/arOndw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9GL224125266;
        Mon, 9 Dec 2019 10:21:03 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 10:21:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 10:21:03 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9GL0LJ129687;
        Mon, 9 Dec 2019 10:21:00 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <rogerq@ti.com>, <jsarha@ti.com>
Subject: [PATCH 0/3] phy: ti: j721e-wiz: Add support for DisplayPort mode
Date:   Mon, 9 Dec 2019 18:20:59 +0200
Message-ID: <cover.1575906694.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wiz wrapper need slightly different configuration when the wrapped
serdes is used for DisplayPort. This series adds devicetree properties
for selecting the mode for each individual serdes lane separately.

The patch series should apply on top of these series:
https://lkml.org/lkml/2019/10/23/589
https://lkml.org/lkml/2019/10/28/197

Jyri Sarha (3):
  dt-bindings: phy: Add PHY_TYPE_DP definition
  dt-bindings: phy: Add lane<n>-mode property to WIZ (SERDES wrapper)
  phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver

 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 12 ++++
 drivers/phy/ti/phy-j721e-wiz.c                | 55 +++++++++++++++++--
 include/dt-bindings/phy/phy.h                 |  1 +
 3 files changed, 64 insertions(+), 4 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

