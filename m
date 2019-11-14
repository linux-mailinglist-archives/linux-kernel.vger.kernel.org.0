Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748DEFA700
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 04:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKMDCU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Nov 2019 22:02:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49829 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:02:20 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD323qX017518, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD323qX017518
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Nov 2019 11:02:03 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 13 Nov 2019 11:02:03 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 13 Nov 2019 11:02:02 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Wed, 13 Nov
 2019 11:02:02 +0800
From:   James Tai <james.tai@realtek.com>
To:     James Tai <james.tai@realtek.com>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
Thread-Topic: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
Thread-Index: AQHVmD0LJFqIXtM2kU2Y99tlfWut1aeIZHwwgAAHQPA=
Date:   Wed, 13 Nov 2019 03:02:02 +0000
Message-ID: <a4d9c42767ac4f3a9eacab72be224f3c@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-4-afaerber@suse.de>
 <f70d00d8b1f8446fb138b36c61d952f4@realtek.com>
In-Reply-To: <f70d00d8b1f8446fb138b36c61d952f4@realtek.com>
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

> Hi Andreas,
> 
> > +		rbus: r-bus@98000000 {
> > +			compatible = "simple-bus";
> > +			reg = <0x98000000 0x100000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x0 0x98000000 0x100000>;
> > +
> 
> The r-bus size of RTD1395 is 0x200000.
> 

Sorry for the typo. The r-bus size of RTD1295 is 0x200000.


Regards,
James


