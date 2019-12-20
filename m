Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E521273E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 04:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLTDab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 22:30:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:18254 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbfLTDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:30:31 -0500
X-UUID: f1449e3015d840ac9df8648132ffaedf-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=b3BvJEb+vzVbaT4+/7UIh98dwFNwj/jxNR863LYiVIU=;
        b=hwJbKIEIEzH9hG2TrYeOLm5v/bg9Po6J63oUtAw58+NKE6zGzWtl+k3mY3CF3/5faC6jfcCya++9SHfZVtwUJr5aR4m7nY1KzuKynEirPdeBjqiKf7GNRrWH4S7LkP/7Oubvk++53d1mATTvfxfonphVawoODnLLhBuZjto24ZQ=;
X-UUID: f1449e3015d840ac9df8648132ffaedf-20191220
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 969353804; Fri, 20 Dec 2019 11:30:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 11:29:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 11:30:26 +0800
Message-ID: <1576812619.8410.8.camel@mtksdaap41>
Subject: Re: [PATCH v10 05/12] soc: mediatek: Add multiple step bus
 protection control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Fri, 20 Dec 2019 11:30:19 +0800
In-Reply-To: <CANMq1KAB9vTDY+d1ktmAtxCGMYqc_C9-SzLzOkLyBmgLz39KYQ@mail.gmail.com>
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
         <1576657848-14711-6-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KAB9vTDY+d1ktmAtxCGMYqc_C9-SzLzOkLyBmgLz39KYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTE5IGF0IDExOjUxICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDE4LCAyMDE5IGF0IDQ6MzEgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBCb3RoIE1UODE4MyAmIE1UNjc2NSBoYXZlIG1v
cmUgY29udHJvbCBzdGVwcyBvZiBidXMgcHJvdGVjdGlvbg0KPiA+IHRoYW4gcHJldmlvdXMgcHJv
amVjdC4gQW5kIHRoZXJlIGFkZCBtb3JlIGJ1cyBwcm90ZWN0aW9uIHJlZ2lzdGVycw0KPiA+IHJl
c2lkZSBhdCBpbmZyYWNmZyAmIHNtaS1jb21tb24uIEFsc28gYWRkIG5ldyBBUElzIGZvciBtdWx0
aXBsZQ0KPiA+IHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCB3aXRoIG1vcmUgY3VzdG9taXpl
ZCBhcmd1bWVudHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVA
bWVkaWF0ZWsuY29tPg0KPiAuLi4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvc2Nwc3lzLWV4dC5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvc2Nwc3lz
LWV4dC5oDQo+IA0KPiBXaWxsIHRoaXMgaW5jbHVkZSBmaWxlIGJlIHVzZWQgYnkgYW55dGhpbmcg
b3RoZXIgdGhhbg0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9zY3BzeXMqLmM/IElmIHNvIEkgdGhp
bmsgeW91IHNob3VsZCBrZWVwIGl0IGluDQo+IGRyaXZlcnMvc29jL21lZGlhdGVrLyBpbnN0ZWFk
Lg0KPiANCg0KTm8uIEFuZCBJJ2xsIG1vdmUgaXQgdW5kZXIgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
DQoNCj4gSSBhbHNvIHN0aWxsIGhhZCBhIGNvbW1lbnQgaW4gdjkgYWJvdXQgY2xyX21hc2ssIG90
aGVyd2lzZSB0aGlzIGxvb2tzIG9rLg0KDQo=

