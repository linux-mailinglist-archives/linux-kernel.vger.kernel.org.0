Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F13130C11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 03:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgAFCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 21:25:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2070 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727278AbgAFCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:25:56 -0500
X-UUID: 1353c1f766d641b3b13673e0db1a27a2-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=90we2HNJ1wSvFgeVfDv+pQLV73/5FIpxbNt+xxqxkIg=;
        b=oMePjRk6ZHKZP/k5PhqascXLGAnBk8Mx1nsIYFdo30HT/gcHI1XAGXBE+g/YF+A64qn359k5ORjHsKl+FKoCFTCECwmkd+qTC5pKekcOd7QNVTECeoIIBfQR91wzR5MkS1CJg1TehaESXeB1gAwZ8pMd19O/uO7dvPS45cUpF/k=;
X-UUID: 1353c1f766d641b3b13673e0db1a27a2-20200106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1097889689; Mon, 06 Jan 2020 10:25:48 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 6 Jan 2020 10:25:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 10:26:12 +0800
Message-ID: <1578277539.17435.5.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] phy: mediatek: Fix Kconfig indentation
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 6 Jan 2020 10:25:39 +0800
In-Reply-To: <1578276653.21256.12.camel@mhfsdcap03>
References: <20200103164710.4829-1-krzk@kernel.org>
         <1578276653.21256.12.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 366D91C7E258C65393D58DF059721550643DFB395D1DB2ED4FF626D1C1DF7C892000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDEwOjEwICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
IE9uIEZyaSwgMjAyMC0wMS0wMyBhdCAxNzo0NyArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gPiBBZGp1c3QgaW5kZW50YXRpb24gZnJvbSBzcGFjZXMgdG8gdGFiICgrb3B0aW9u
YWwgdHdvIHNwYWNlcykgYXMgaW4NCj4gPiBjb2Rpbmcgc3R5bGUuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+IA0KPiA+
IC0tLQ0KPiA+IA0KDQpSZXZpZXdlZC1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlh
dGVrLmNvbT4NCg0K

