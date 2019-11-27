Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC67310B11B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfK0OXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:23:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:1717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbfK0OXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:23:15 -0500
X-UUID: dea260d0f5c7453a82d2c8ba4cb62079-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cF2Om7X85XQimoGPg+VUY4Aqoy6qnXHiU7JTF0y3r6E=;
        b=uRMQFQupvqFkrThMzspsv6IPiZ3M81H8L2EF9Xd9zrcWL2OgcFJOI0Rs5SUYEyO4u5mQmxYO/hbNqmcEBbFPuAZO1e8uRIBppL+vVHi6Ah0QxqwhdcxUO++yxn2PEYEKLMaUqcaI0xy16LJ/NGUv/7rPJOh5sjtu4GYhvt7BTXw=;
X-UUID: dea260d0f5c7453a82d2c8ba4cb62079-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1900528197; Wed, 27 Nov 2019 22:23:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 22:23:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 22:23:03 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v5 2/3] dt-bindings: rng: add bindings for MediaTek ARMv8 SoCs
Date:   Wed, 27 Nov 2019 22:22:57 +0800
Message-ID: <1574864578-467-3-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574864578-467-1-git-send-email-neal.liu@mediatek.com>
References: <1574864578-467-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9jdW1lbnQgdGhlIGJpbmRpbmcgdXNlZCBieSB0aGUgTWVkaWFUZWsgQVJNdjggU29DcyByYW5k
b20NCm51bWJlciBnZW5lcmF0b3Igd2l0aCBUcnVzdFpvbmUgZW5hYmxlZC4NCg0KU2lnbmVkLW9m
Zi1ieTogTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5n
cy9hcm0vZmlybXdhcmUvbWVkaWF0ZWssbXRrLXNlYy1ybmcudHh0IHwgICAxOCArKysrKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zpcm13YXJlL21l
ZGlhdGVrLG10ay1zZWMtcm5nLnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9maXJtd2FyZS9tZWRpYXRlayxtdGstc2VjLXJuZy50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zpcm13YXJlL21lZGlhdGVrLG10
ay1zZWMtcm5nLnR4dA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjc0MWZj
ZGMNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZmlybXdhcmUvbWVkaWF0ZWssbXRrLXNlYy1ybmcudHh0DQpAQCAtMCwwICsxLDE4IEBA
DQorTWVkaWFUZWsgcmFuZG9tIG51bWJlciBnZW5lcmF0b3Igd2l0aCBUcnVzdFpvbmUgZW5hYmxl
ZA0KKw0KK1JlcXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxlICAgICAgIDogU2hvdWxk
IGNvbnRhaW4gIm1lZGlhdGVrLG10ay1zZWMtcm5nIg0KKw0KKy0gbWV0aG9kICAgICAgICAgICA6
IFRoZSBtZXRob2Qgb2YgY2FsbGluZyBBcm0gVHJ1c3RlZCBGaXJtd2FyZS4gUGVybWl0dGVkDQor
CQkgICAgIHZhbHVlcyBhcmU6DQorDQorCQkgICAgICJzbWMiIDogU01DICMwLCB3aXRoIHRoZSBy
ZWdpc3RlciBhc3NpZ25tZW50cyBzcGVjaWZpZWQNCisJCSAgICAgaW4gdGhpcyBiaW5kaW5nLg0K
Kw0KK0V4YW1wbGU6DQorCWZpcm13YXJlIHsNCisJCWh3cm5nIHsNCisJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ay1zZWMtcm5nIjsNCisJCQltZXRob2RzID0gInNtYyI7DQorCQl9Ow0KKwl9
Ow0KLS0gDQoxLjcuOS41DQo=

