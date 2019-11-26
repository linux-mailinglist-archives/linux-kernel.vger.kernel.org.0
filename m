Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA841109930
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 07:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKZG3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 01:29:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725769AbfKZG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:29:41 -0500
X-UUID: 9d0fcb589ac6436b89daf72e7efaff54-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9GsnXvbnUrM4k+eDi7ySE7vOla/0pQZQxmPpNzdrWyI=;
        b=KN/m0VC/T2QpfsJz8VjCn+kuY6pUUtyX3+kCbpa3Dasv0VcaUBKhxEiiKcR+YGWmHapOvNJlz4jitSsTnzrNZJAcLw4A90mEV2h1fKWsdUoFjDaY1u0ohK5b8vYy+wpNzEP51B4n4JDmmZ6SzRQST6GxlihRIajhizL4b+8WOCc=;
X-UUID: 9d0fcb589ac6436b89daf72e7efaff54-20191126
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 111076575; Tue, 26 Nov 2019 14:29:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 14:29:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 14:29:15 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 4/7] drm/mediatek: handle events when enabling/disabling crtc
Date:   Tue, 26 Nov 2019 14:29:29 +0800
Message-ID: <20191126062932.19773-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
References: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRyaXZlciBjdXJyZW50bHkgaGFuZGxlcyB2YmxhbmsgZXZlbnRzIG9ubHkgd2hlbiB1cGRh
dGluZyBwbGFuZXMgb24NCmFuIGFscmVhZHkgZW5hYmxlZCBDUlRDLiBUaGUgYXRvbWljIHVwZGF0
ZSBBUEkgaG93ZXZlciBhbGxvd3MgcmVxdWVzdGluZw0KYW4gZXZlbnQgd2hlbiBlbmFibGluZyBv
ciBkaXNhYmxpbmcgYSBDUlRDLiBUaGlzIGN1cnJlbnRseSBsZWFkcyB0bw0KZXZlbnQgb2JqZWN0
cyBiZWluZyBsZWFrZWQgaW4gdGhlIGtlcm5lbCBhbmQgdG8gZXZlbnRzIG5vdCBiZWluZyBzZW50
DQpvdXQuIEZpeCBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVo
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmluZGV4IGUzODUwNmQ3YTRlOC4u
NDA4YTZkNmExNWJhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMN
CkBAIC0zMzUsNiArMzM1LDcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1
Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfaHdf
ZmluaShzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiB7DQogCXN0cnVjdCBkcm1fZGV2
aWNlICpkcm0gPSBtdGtfY3J0Yy0+YmFzZS5kZXY7DQorCXN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9
ICZtdGtfY3J0Yy0+YmFzZTsNCiAJaW50IGk7DQogDQogCURSTV9ERUJVR19EUklWRVIoIiVzXG4i
LCBfX2Z1bmNfXyk7DQpAQCAtMzU4LDYgKzM1OSwxMyBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19k
ZHBfaHdfZmluaShzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJbXRrX2Rpc3BfbXV0
ZXhfdW5wcmVwYXJlKG10a19jcnRjLT5tdXRleCk7DQogDQogCXBtX3J1bnRpbWVfcHV0KGRybS0+
ZGV2KTsNCisNCisJaWYgKGNydGMtPnN0YXRlLT5ldmVudCAmJiAhY3J0Yy0+c3RhdGUtPmFjdGl2
ZSkgew0KKwkJc3Bpbl9sb2NrX2lycSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrKTsNCisJCWRybV9j
cnRjX3NlbmRfdmJsYW5rX2V2ZW50KGNydGMsIGNydGMtPnN0YXRlLT5ldmVudCk7DQorCQljcnRj
LT5zdGF0ZS0+ZXZlbnQgPSBOVUxMOw0KKwkJc3Bpbl91bmxvY2tfaXJxKCZjcnRjLT5kZXYtPmV2
ZW50X2xvY2spOw0KKwl9DQogfQ0KIA0KIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9jb25maWco
c3RydWN0IGRybV9jcnRjICpjcnRjKQ0KLS0gDQoyLjE4LjANCg==

