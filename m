Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3FF43B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfKHJn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Nov 2019 04:43:26 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56621 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfKHJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:43:26 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA89guVu009625, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA89guVu009625
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 8 Nov 2019 17:42:56 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 8 Nov
 2019 17:42:56 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: [PATCH v2 0/2] Initial RTD1619 SoC and Realtek Mjolnir EVB support
Thread-Topic: [PATCH v2 0/2] Initial RTD1619 SoC and Realtek Mjolnir EVB
 support
Thread-Index: AdWWGJhW6hHY3ZYJQ8qKkqaxghH5QQ==
Date:   Fri, 8 Nov 2019 09:42:55 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF91F9CB@RTITMBSVM04.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series adds Device Trees for the Realtek RTD1619 SoC and Realtek's
Mjolnir EVB.

v1 -> v2:
* Define compatible strings for Realtek RTD1619 SoC and Realtek Mjolnir
* Add uart1 and uart2 device node into rtd16xx.dtsi
* move cpus node and the interrupt-affinity into rtd16xx.dtsi
* Specify the r-bus ranges

James Tai (2):
  dt-bindings: arm: realtek: Document RTD1619 and Realtek Mjolnir EVB
  arm64: dts: Initial RTD1619 SoC and Realtek Mjolnir EVB support

 .../devicetree/bindings/arm/realtek.yaml      |   6 +
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1619-mjolnir.dts      |  40 +++++
 arch/arm64/boot/dts/realtek/rtd1619.dtsi      |  12 ++
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      | 154 ++++++++++++++++++
 5 files changed, 214 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi

--
2.17.1

