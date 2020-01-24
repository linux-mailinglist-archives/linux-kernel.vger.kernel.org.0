Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C147984
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgAXIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 03:41:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgAXIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:41:52 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O8cLi4009557;
        Fri, 24 Jan 2020 09:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6YN6uRI+tL0RDCkjsa7KMknLT70Rl4troyt+Y2tOtyQ=;
 b=G627GwUva+dpPyfCp5ytx+OmRrxerrsKs9gj1FakrHCoQiqQEFooZInNOVvQAECAq01x
 fKl/4swugfCnT4ZD46Gpu2QGPdQ1yL/yIbFPoah2NAeepn4w4hdaigLIL3mau4YAhWFK
 Td2l3twaeTXz+fEQxkTFm1jgyeXwaAGoHhlO6hnBmHqR1KL2Lo2GlGDRWBn8VaF6glsn
 SG573uHseDuMhdpbmexeHn2idnHIjjVg7yXOcEsyX2NErxkUMYwQecvAh2O09Vbj57w6
 sM5J5HlYYf0h3zU2GVpR2OsVSyGaXvaNA3ZMLb65I6g0b1NOA+ymc4D+JYrmlZpq/2OC xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc5eu6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 09:41:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD44E100038;
        Fri, 24 Jan 2020 09:41:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2C6920EDC8;
        Fri, 24 Jan 2020 09:41:39 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jan 2020 09:41:39
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 0/2] USB DWC2 support for STM32MP15 SoCs USB OTG
Date:   Fri, 24 Jan 2020 09:41:29 +0100
Message-ID: <20200124084131.23749-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_02:2020-01-24,2020-01-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for STM32MP15 SoCs USB OTG HS and FS based on DWC2 IP.

STM32MP15 SoCs embeds a DWC2 IP that can be used in HS or in FS, and
uses an external Vbus and ID level detection to support OTG operations.

Amelie Delaunay (2):
  dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and
    FS
  usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS

---
Changes in v3:
- fix usb33d-supply in bindings

Changes in v2:
- add Minas Acked-by on driver
- use dwc2.yaml bindings

 .../devicetree/bindings/usb/dwc2.yaml         |  6 ++
 drivers/usb/dwc2/core.h                       |  8 ++
 drivers/usb/dwc2/hw.h                         |  8 ++
 drivers/usb/dwc2/params.c                     | 33 +++++++
 drivers/usb/dwc2/platform.c                   | 94 ++++++++++++++++++-
 5 files changed, 147 insertions(+), 2 deletions(-)

-- 
2.17.1

