Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80715AF5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfIKGm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 02:42:27 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:20595 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIKGm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:42:27 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Kr0fy78TWTx/7uyhYaTb4pVf1lS3SI1D22i5ivt/iH+3LbcssZwAHRQ1u7De59PHiJBbl/kjNL
 VIGEe8LL2gvSflr8MoTYVgfowqHMhgVbrEYKCBSjuDc4DVkHBTmWm8KMRwUW2fnNAe0Y77Z7pI
 c76IsEWJaMBOVNPFV2jqBa3kGA7zQtliXGO/RtHvR/327vfGkkLd42wN8FGWSybnjThK36hmhy
 YcJNRnvcybQXd+ZQZin0zAMxoNd1T1JXk4iMVm/G45JKbVa7gpZ3tmAPqEJYMYPc4obOOKu+8q
 6PM=
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="47503524"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 23:42:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 23:42:25 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 10 Sep 2019 23:42:24 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <Boris.Krasnovskiy@lairdconnect.com>, <linux-usb@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 0/3] USB: host: ohci-at91: tailor power consumption
Date:   Wed, 11 Sep 2019 08:41:51 +0200
Message-ID: <20190911064154.28633-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a set of experiments we found areas of improvement for OHCI power
consumption (and associated USB analog cells).
This enhances the shutdown of residual power consumption in case of Linux
suspend/resume and removal of the driver (when compiled as a module).

Best regards,
  Nicolas

Boris Krasnovskiy (2):
  USB: host: ohci-at91: completely shutdown the controller in
    at91_stop_hc()
  USB: host: ohci-at91: resume: balance the clock start call

Nicolas Ferre (1):
  USB: host: ohci-at91: suspend: delay needed before to stop clocks

 drivers/usb/host/ohci-at91.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.17.1

