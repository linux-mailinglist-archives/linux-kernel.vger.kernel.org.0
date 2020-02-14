Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8165615D10D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 05:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgBNEdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 23:33:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:18727 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728685AbgBNEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:33:33 -0500
X-UUID: cd2c6037d22a490c930049dd8f1e3ba2-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Qo8BOftgtpr94g/ytzEhzTCNFVahY6Atxbr6wGr9X9g=;
        b=TMpwb0JPNaQd5KQjp7/zzEsARIhLqWpbx8/SQvKhZOB7TXj/hnzp7K0TqYM84jwXanDMiJoQRtLbNl+gDSCMyA8Lg38A3DZmbjPe1NO4ovfFofb5jOYmTeX0JQcX/Ltcqyu45DBENVOrStTzxfTkqQROPqxpvSL2twV1JK4DJSk=;
X-UUID: cd2c6037d22a490c930049dd8f1e3ba2-20200214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1152523129; Fri, 14 Feb 2020 12:33:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:32:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:33:19 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 3/3] dt-binding: gce: remove atomic_exec in mboxes property
Date:   Fri, 14 Feb 2020 12:33:25 +0800
Message-ID: <20200214043325.16618-4-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 66A1543FC5E76F88AED2AD249D9CC60E022BE468315C4A65EB02F258A509C41A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgbm90IGFueSBjbGllbnQgZHJpdmVyIHVzaW5nIHRoaXMgZmVhdHVyZSBub3csDQpz
byByZW1vdmUgaXQgZnJvbSBiaW5kaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8
YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQgfCAxMCArKysrLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQNCmluZGV4
IDdiMTM3ODdhYjEzZC4uMGI1YjJhNmJjYzQ4IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0DQpAQCAtMTQsMTMgKzE0
LDExIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBpbnRlcnJ1cHRzOiBUaGUgaW50ZXJydXB0
IHNpZ25hbCBmcm9tIHRoZSBHQ0UgYmxvY2sNCiAtIGNsb2NrOiBDbG9ja3MgYWNjb3JkaW5nIHRv
IHRoZSBjb21tb24gY2xvY2sgYmluZGluZw0KIC0gY2xvY2stbmFtZXM6IE11c3QgYmUgImdjZSIg
dG8gc3RhbmQgZm9yIEdDRSBjbG9jaw0KLS0gI21ib3gtY2VsbHM6IFNob3VsZCBiZSAzLg0KLQk8
JnBoYW5kbGUgY2hhbm5lbCBwcmlvcml0eSBhdG9taWNfZXhlYz4NCistICNtYm94LWNlbGxzOiBT
aG91bGQgYmUgMi4NCisJPCZwaGFuZGxlIGNoYW5uZWwgcHJpb3JpdHk+DQogCXBoYW5kbGU6IExh
YmVsIG5hbWUgb2YgYSBnY2Ugbm9kZS4NCiAJY2hhbm5lbDogQ2hhbm5lbCBvZiBtYWlsYm94LiBC
ZSBlcXVhbCB0byB0aGUgdGhyZWFkIGlkIG9mIEdDRS4NCiAJcHJpb3JpdHk6IFByaW9yaXR5IG9m
IEdDRSB0aHJlYWQuDQotCWF0b21pY19leGVjOiBHQ0UgcHJvY2Vzc2luZyBjb250aW51b3VzIHBh
Y2tldHMgb2YgY29tbWFuZHMgaW4gYXRvbWljDQotCQl3YXkuDQogDQogUmVxdWlyZWQgcHJvcGVy
dGllcyBmb3IgYSBjbGllbnQgZGV2aWNlOg0KIC0gbWJveGVzOiBDbGllbnQgdXNlIG1haWxib3gg
dG8gY29tbXVuaWNhdGUgd2l0aCBHQ0UsIGl0IHNob3VsZCBoYXZlIHRoaXMNCkBAIC01NCw4ICs1
Miw4IEBAIEV4YW1wbGUgZm9yIGEgY2xpZW50IGRldmljZToNCiANCiAJbW1zeXM6IGNsb2NrLWNv
bnRyb2xsZXJAMTQwMDAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbW1z
eXMiOw0KLQkJbWJveGVzID0gPCZnY2UgMCBDTURRX1RIUl9QUklPX0xPV0VTVCAxPiwNCi0JCQkg
PCZnY2UgMSBDTURRX1RIUl9QUklPX0xPV0VTVCAxPjsNCisJCW1ib3hlcyA9IDwmZ2NlIDAgQ01E
UV9USFJfUFJJT19MT1dFU1Q+LA0KKwkJCSA8JmdjZSAxIENNRFFfVEhSX1BSSU9fTE9XRVNUPjsN
CiAJCW11dGV4LWV2ZW50LWVvZiA9IDxDTURRX0VWRU5UX01VVEVYMF9TVFJFQU1fRU9GDQogCQkJ
CUNNRFFfRVZFTlRfTVVURVgxX1NUUkVBTV9FT0Y+Ow0KIAkJbWVkaWF0ZWssZ2NlLWNsaWVudC1y
ZWcgPSA8JmdjZSBTVUJTWVNfMTQwMFhYWFggMHgzMDAwIDB4MTAwMD4sDQotLSANCjIuMTguMA0K

