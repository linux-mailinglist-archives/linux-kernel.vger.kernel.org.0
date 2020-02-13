Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41D15B699
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 02:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgBMBYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 20:24:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57784 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727071AbgBMBYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:24:00 -0500
X-UUID: 180daabd8bad4639b3012420b6cc388d-20200213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y2Th+gHYhXqwVTZtN+Ab3LnVwLW4lWLwZX1aM07dOp4=;
        b=eZQJRZ81MC9LeheYsOJ5sGcT3KMUqpOknl2xYlRPQAOQ5nyNQKiEpAEfjcyrONm1MBGUCEHbC02+LSVB0lxntMFCTkjkDNnAgvEgL7dNT+okQ1zYIFZwQMMlTk7JlsVhx9RyeZ0HZS9/RubEvEmo6rjhnQ6yCZjMcEtkgDLCXc8=;
X-UUID: 180daabd8bad4639b3012420b6cc388d-20200213
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1850770704; Thu, 13 Feb 2020 09:23:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Feb 2020 09:24:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Feb 2020 09:23:59 +0800
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
Subject: [PATCH 1/2] drm/mediatek: add plane check in async_check function
Date:   Thu, 13 Feb 2020 09:23:52 +0800
Message-ID: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVRLIGRvIHJvdGF0aW9uIGNoZWNraW5nIGFuZCB0cmFuc2ZlcnJpbmcgaW4gbGF5ZXIgY2hlY2sg
ZnVuY3Rpb24sDQpidXQgd2UgZG8gbm90IGNoZWNrIHRoYXQgaW4gYXRvbWljX2NoZWNrLA0Kc28g
YWRkIGJhY2sgaW4gYXRvbWljX2NoZWNrIGZ1bmN0aW9uLg0KDQpGaXhlczogOTIwZmZmY2M4OTEy
ICgiZHJtL21lZGlhdGVrOiB1cGRhdGUgY3Vyc29ycyBieSB1c2luZyBhc3luYyBhdG9taWMgdXBk
YXRlIikNCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgfCA2
ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQppbmRleCAxODk3NDRkMzRmNTMuLmQzMmI0OTRm
ZjFkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5l
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCkBAIC04
MSw2ICs4MSw3IEBAIHN0YXRpYyBpbnQgbXRrX3BsYW5lX2F0b21pY19hc3luY19jaGVjayhzdHJ1
Y3QgZHJtX3BsYW5lICpwbGFuZSwNCiAJCQkJCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKnN0YXRl
KQ0KIHsNCiAJc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlOw0KKwlpbnQgcmV0Ow0K
IA0KIAlpZiAocGxhbmUgIT0gc3RhdGUtPmNydGMtPmN1cnNvcikNCiAJCXJldHVybiAtRUlOVkFM
Ow0KQEAgLTkxLDYgKzkyLDExIEBAIHN0YXRpYyBpbnQgbXRrX3BsYW5lX2F0b21pY19hc3luY19j
aGVjayhzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCiAJaWYgKCFwbGFuZS0+c3RhdGUtPmZiKQ0K
IAkJcmV0dXJuIC1FSU5WQUw7DQogDQorCXJldCA9IG10a19kcm1fY3J0Y19wbGFuZV9jaGVjayhz
dGF0ZS0+Y3J0YywgcGxhbmUsDQorCQkJCSAgICAgICB0b19tdGtfcGxhbmVfc3RhdGUoc3RhdGUp
KTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQogCWlmIChzdGF0ZS0+c3RhdGUpDQog
CQljcnRjX3N0YXRlID0gZHJtX2F0b21pY19nZXRfZXhpc3RpbmdfY3J0Y19zdGF0ZShzdGF0ZS0+
c3RhdGUsDQogCQkJCQkJCQlzdGF0ZS0+Y3J0Yyk7DQotLSANCjIuMTguMA0K

