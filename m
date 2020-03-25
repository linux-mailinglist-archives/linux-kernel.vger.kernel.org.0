Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8319240F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCYJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 05:31:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22729 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbgCYJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:31:47 -0400
X-UUID: 301a8601b05549c88b2ad0e01bf2627d-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=B71l7gQY32AVSPj0Iz+n3QYxFS0Q7pqS5cd7ybjbLfI=;
        b=kdio/mUZ2e+QYgCvT6vpi4W+/wVOT5DZ+NUhzOluD+1Dj2jPR+1cwAnKGnotiVQc6MIR/4F0iP63jkyPjLse9gMGky5QX1LyLx91PRBI8XeRoXNy/kFIKaqJOZPbwlChZpBtTCpoHVdm9yW41IXHxfzIwyCKTWB4Ld1ycNDIjaw=;
X-UUID: 301a8601b05549c88b2ad0e01bf2627d-20200325
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 816349840; Wed, 25 Mar 2020 17:31:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 17:31:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 17:31:42 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v5 5/6] pinctrl: mediatek: add mt6779 eint support
Date:   Wed, 25 Mar 2020 17:31:33 +0800
Message-ID: <1585128694-13881-6-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGRyaXZlciBzZXR0aW5nIHRvIHN1cHBvcnQgbXQ2Nzc5IGVpbnQNCg0KQWNrZWQtYnk6IFNl
YW4gV2FuZyA8c2Vhbi53YW5nQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBIYW5rcyBDaGVu
IDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hcnMgQ2hlbmcgPG1h
cnMuY2hlbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtbXQ2Nzc5LmMgfCAgICA4ICsrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwt
bXQ2Nzc5LmMgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NzkuYw0KaW5k
ZXggMTQ1YmYyMi4uMzI4MjI2MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRl
ay9waW5jdHJsLW10Njc3OS5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3Ry
bC1tdDY3NzkuYw0KQEAgLTczMSwxMSArNzMxLDE5IEBADQogCSJpb2NmZ19ydCIsICJpb2NmZ19s
dCIsICJpb2NmZ190bCIsDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19laW50X2h3
IG10Njc3OV9laW50X2h3ID0gew0KKwkucG9ydF9tYXNrID0gNywNCisJLnBvcnRzICAgICA9IDYs
DQorCS5hcF9udW0gICAgPSAxOTUsDQorCS5kYl9jbnQgICAgPSAxMywNCit9Ow0KKw0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX3Bpbl9zb2MgbXQ2Nzc5X2RhdGEgPSB7DQogCS5yZWdfY2FsID0g
bXQ2Nzc5X3JlZ19jYWxzLA0KIAkucGlucyA9IG10a19waW5zX210Njc3OSwNCiAJLm5waW5zID0g
QVJSQVlfU0laRShtdGtfcGluc19tdDY3NzkpLA0KIAkubmdycHMgPSBBUlJBWV9TSVpFKG10a19w
aW5zX210Njc3OSksDQorCS5laW50X2h3ID0gJm10Njc3OV9laW50X2h3LA0KIAkuZ3Bpb19tID0g
MCwNCiAJLmllc19wcmVzZW50ID0gdHJ1ZSwNCiAJLmJhc2VfbmFtZXMgPSBtdDY3NzlfcGluY3Ry
bF9yZWdpc3Rlcl9iYXNlX25hbWVzLA0KLS0gDQoxLjcuOS41DQo=

