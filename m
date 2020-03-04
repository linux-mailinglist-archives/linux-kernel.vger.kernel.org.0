Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4A178873
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 03:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgCDCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 21:38:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59082 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387457AbgCDCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:38:40 -0500
X-UUID: 966109f9695a4bcab70ef04ffe4ec9cf-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gwG234eP2pizyd5C4jAhNxs4bxHFKwNJ44qV05ygkU8=;
        b=E5eg/7QZDpv5h2ta9LKJCC6rY+h2jMFCp5gc8+FzR2rIN1+EfWe+rkZRQm5eItDOeqyLaXG6aLYg/DFCoQOdZAxkCuizz/MftbkUGy44kwSERlsOQOWHLBU2Z6cmNrkcfYi+U2cS7v9jil+ACIy9PAkWOdbosleC1tDw9/Yanpc=;
X-UUID: 966109f9695a4bcab70ef04ffe4ec9cf-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 249110076; Wed, 04 Mar 2020 10:38:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:37:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:37:52 +0800
Message-ID: <1583289512.32049.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 05/13] soc: mediatek: cmdq: return send msg error code
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 4 Mar 2020 10:38:32 +0800
In-Reply-To: <1583233125-7827-6-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-6-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IFJldHVybiBlcnJvciBjb2RlIHRvIGNsaWVudCBpZiBzZW5kIG1l
c3NhZ2UgZmFpbCwNCj4gc28gdGhhdCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGlu
Zy4NCj4gDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNp
Z25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNv
bT4NCj4gRml4ZXM6IDU3NmYxYjRiYzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBD
TURRIGhlbHBlciIpDQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGlu
ZGV4IDJlMWJjNTEzNTY5Yi4uOThmMjNiYTNiYTQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMzUxLDcgKzM1MSw5IEBAIGludCBjbWRxX3BrdF9m
bHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwN
Cj4gIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2xpZW50LT5sb2NrLCBmbGFncyk7DQo+ICAJ
fQ0KPiAgDQo+IC0JbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFuLCBwa3QpOw0KPiArCWVy
ciA9IG1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsNCj4gKwlpZiAoZXJyIDwg
MCkNCj4gKwkJcmV0dXJuIGVycjsNCj4gIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tldCBpbW1l
ZGlhdGVseSwgc28ganVzdCBjYWxsIHR4ZG9uZS4gKi8NCj4gIAltYm94X2NsaWVudF90eGRvbmUo
Y2xpZW50LT5jaGFuLCAwKTsNCj4gIA0KDQo=

