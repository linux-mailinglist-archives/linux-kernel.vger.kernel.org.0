Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56841449AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 03:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAVCFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 21:05:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57986 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726396AbgAVCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:05:11 -0500
X-UUID: 42c461833bd64446be7d75ab67df0a0e-20200122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0FaXYKQ4jfEqR8ee1u10dSXTtk9iSDJYo/sKCwcXsic=;
        b=q9DH0ZSbcDqjoExb4cUgo7cvvLvESqFvS44H8cbklone7QavrEyd6xA1oxeOzfOY1dFFpaUFORNLTRIjtZ2R9F+EdOAYQo3COdGL0sw9cg62AHg7/D1MwlIOx4h/CI6DuAa5trcSkSbELF24ZPRFlfRucanCXn+pc2AyiIlCIsQ=;
X-UUID: 42c461833bd64446be7d75ab67df0a0e-20200122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1956093877; Wed, 22 Jan 2020 10:05:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 22 Jan 2020 10:04:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 22 Jan 2020 10:04:38 +0800
Message-ID: <1579658700.6612.1.camel@mtkswgap22>
Subject: Re: [RESEND 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 22 Jan 2020 10:05:00 +0800
In-Reply-To: <20200120084355.GW15507@dell>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
         <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
         <20200120084355.GW15507@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uZXMsDQpPbiBNb24sIDIwMjAtMDEtMjAgYXQgMDg6NDMgKzAwMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gT24gTW9uLCAyMCBKYW4gMjAyMCwgV2VuIFN1IHdyb3RlOg0KPiANCj4gPiBGcm9t
OiBXZW4gU3UgPHdlbi5zdUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gYWRkIGR0LWJpbmRpbmcg
ZG9jdW1lbnQgZm9yIE1lZGlhVGVrIE1UNjM1OSBQTUlDDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuIFN1
IDx3ZW4uc3VAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhlc2UgYXJlIGluIHRoZSB3cm9uZyBvcmRl
ci4gIFRhZ3Mgc2hvdWxkIGRlc2NyaWJlIGhpc3RvcnksIHRodXMNCj4gc2hvdWxkIGJlIGluIGNo
cm9ub2xvZ2ljYWwgb3JkZXIuICBGb3IgaW5zdGFuY2UsIHRoZSBvcmRlcmluZyB5b3UgdXNlZA0K
PiBkZXNjcmliZXMgUm9iIHJldmlld2luZyB0aGUgcGF0Y2ggKmJlZm9yZSogeW91IHNlbnQgaXQs
IHdoaWNoIGlzIG5vdA0KPiBwb3NzaWJsZS4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50
Lg0KSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLnR4dCAgICAgICAgfCA1OSArKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0DQo+IA0KDQo=

