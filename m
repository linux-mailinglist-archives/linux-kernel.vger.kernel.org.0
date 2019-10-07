Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86A5CE0B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfJGLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:41:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfJGLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:41:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97Bfm08013343;
        Mon, 7 Oct 2019 06:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570448508;
        bh=PN3pQoxV5ig78XkDXaqCq87dAf1gxVYRw5Xe2hzSChM=;
        h=From:To:CC:Subject:Date;
        b=UjYWphDnk/dTF8ZvzKP4dDRj7bOWAbjBnmkUUbrqhTBrgL8deV+xj1ZiDgBUKETN9
         m8r9WmC3YC1Kw0K2RoMslG9dfPt9o/kWpFn+jCfnJ2rik3WEmKo+0EDS0ZEpwSbBm6
         gXkOJX7nK5wLgcRP8LApl56sSPmFmRZDH5ZYvQvY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97BfmUH009482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 06:41:48 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 06:41:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 06:41:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97BfjMK024908;
        Mon, 7 Oct 2019 06:41:45 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <pawell@cadence.com>,
        <nsekhar@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] usb: cdns3: Add TI wrapper
Date:   Mon, 7 Oct 2019 14:41:40 +0300
Message-ID: <20191007114142.5182-1-rogerq@ti.com>
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

Roger Quadros (2):
  dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3
    controller
  usb: cdns3: Add TI specific wrapper driver

 .../devicetree/bindings/usb/cdns-usb3-ti.txt  |  59 +++++
 drivers/usb/cdns3/Kconfig                     |  10 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-ti.c                  | 244 ++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
 create mode 100644 drivers/usb/cdns3/cdns3-ti.c

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

