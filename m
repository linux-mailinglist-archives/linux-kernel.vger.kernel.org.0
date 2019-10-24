Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A996E313A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439250AbfJXLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 07:47:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfJXLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:47:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9OBlMuq023712;
        Thu, 24 Oct 2019 06:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571917642;
        bh=KFH23Zz587V5zlsZXX7LnZPhmrmINJOANLZsLFgUq3o=;
        h=From:To:CC:Subject:Date;
        b=I5mlWPAxP6mYYM612k9HGqKL8DPPl0JSvve3CSE2tXfB2AbVDhkIpTBBtowRxQIBp
         xb8KmnFVLsrtJd+Vfa2LfGlKkCzT20+wjDnZHJQbGOvNVWawteOe/h04Dutd+pOA5Q
         C66hZ1Y2pWY0HmFw8LnHeQXCkKaEGszSMyN9BRdA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OBlM6c130668;
        Thu, 24 Oct 2019 06:47:22 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 06:47:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 06:47:21 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OBlIAJ061379;
        Thu, 24 Oct 2019 06:47:19 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/2] usb: cdns3: Add TI wrapper
Date:   Thu, 24 Oct 2019 14:47:15 +0300
Message-ID: <20191024114717.30984-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Texas Instruments SoCs have a wrapper module around the Cadence
USB3 core. It takes care of clocking and powering the core and providing
initial configuration to the core.

This series adds the driver for the TI wrapper and associated DT binding
document. This is for -next kernel. Thanks.

cheers,
-roger

Changelog:
v3:
- switch to yaml DT schema
- fix typo in driver header

v2:
- dt-binding fixes to address Rob's comments
	- convert dt-binding document name to DT schema
	- get rid of bootstrap properties
	- fix DT example

Roger Quadros (2):
  dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3
    controller
  usb: cdns3: Add TI specific wrapper driver

 .../devicetree/bindings/usb/ti,j721e-usb.yaml |  86 +++++++
 drivers/usb/cdns3/Kconfig                     |  10 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-ti.c                  | 236 ++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
 create mode 100644 drivers/usb/cdns3/cdns3-ti.c

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

