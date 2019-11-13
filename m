Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4AFA6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 03:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKMCyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 21:54:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47146 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMCyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:54:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD2s1OK011829, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD2s1OK011829
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 10:54:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 13 Nov 2019 10:54:01 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 13 Nov 2019 10:53:56 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Wed, 13 Nov
 2019 10:53:56 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Topic: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Index: AQHVmD0XE9qksqLMuUeBNyO+ccQCh6eIaL1A
Date:   Wed, 13 Nov 2019 02:53:55 +0000
Message-ID: <a43d184d74c34e269714858b2635c35e@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
In-Reply-To: <20191111030434.29977-6-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiArCQlyYnVzOiByLWJ1c0AxODAwMDAwMCB7DQo+ICsJCQljb21wYXRp
YmxlID0gInNpbXBsZS1idXMiOw0KPiArCQkJcmVnID0gPDB4MTgwMDAwMDAgMHgxMDAwMDA+Ow0K
PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
KwkJCXJhbmdlcyA9IDwweDAgMHgxODAwMDAwMCAweDEwMDAwMD47DQo+ICsNCg0KVGhlIHItYnVz
IHNpemUgb2YgUlREMTE5NSBpcyAweDcwMDAw4oCsLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=
