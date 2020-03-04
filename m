Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70C1788A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 03:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgCDCvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 21:51:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27958 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387505AbgCDCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:51:21 -0500
X-UUID: d9ff75900a824d6d85d786cf561d1d24-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hICaNOxn3n/TJ2nKOekirNGAVVkQjyBKYCXj0p1qQX8=;
        b=DnjbDt+6lPAKfhG4vNbaB2ChrHTknqluv2eRzdT3mXmzQRuhC7eSvI/38E6zuPNwbiQ3XGsX6MUNdNTNCXVDtoaxwoP/ArpqNqw99CC+6+xUAobYS4TJrLG9XRpBKGNf8o0NBFE+23M/D7MIii7dFrS2CHcthqdBaadV8X++m+Y=;
X-UUID: d9ff75900a824d6d85d786cf561d1d24-20200304
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1754846288; Wed, 04 Mar 2020 10:51:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:48:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:51:54 +0800
From:   <light.hsieh@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuohong.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Subject: [PATCH v1 0/3] set ro attribute of block device according to write-protection status
Date:   Wed, 4 Mar 2020 10:51:11 +0800
Message-ID: <1583290274-5525-1-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 59A6C29AEBE25DCB4E8D7679D2008F7C04344D37A7708C9A0A0046E1FC43673F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlnaHQgSHNpZWggPGxpZ2h0LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KTGlnaHQgSHNp
ZWggKDMpOg0KICBtbWM6IHJlY29yZCB3cF9ncnBfc2l6ZSBhbmQgYm9vdF93cF9zdGF0dXMNCiAg
bW1jOiBjaGVjayB3cml0ZS1wcm90ZWN0aW9uIHN0YXR1cyBkdXJpbmcgQkxLUk9TRVQgaW9jdGwN
CiAgYmxvY2s6IHNldCBwYXJ0aXRpb24gcmVhZC93cml0ZSBwb2xpY3kgYWNjb3JkaW5nIHRvIHdy
aXRlLXByb3RlY3Rpb24NCiAgICBzdGF0dXMNCg0KIGJsb2NrL2lvY3RsLmMgICAgICAgICAgICAg
fCAgIDIgKy0NCiBibG9jay9wYXJ0aXRpb24tZ2VuZXJpYy5jIHwgIDEwICsrKw0KIGRyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYyAgfCAyMTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgICAgfCAgMTYgKysrKw0KIGlu
Y2x1ZGUvbGludXgvYmxrZGV2LmggICAgfCAgIDEgKw0KIGluY2x1ZGUvbGludXgvbW1jL2NhcmQu
aCAgfCAgIDMgKw0KIGluY2x1ZGUvbGludXgvbW1jL21tYy5oICAgfCAgIDIgKw0KIDcgZmlsZXMg
Y2hhbmdlZCwgMjUwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KLS0gDQoxLjguMS4x
LmRpcnR5DQo=

