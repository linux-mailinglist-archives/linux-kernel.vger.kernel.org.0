Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918DD12E223
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgABEDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 23:03:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727657AbgABEC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:27 -0500
X-UUID: 2ace1321fba54e79bcd008e1019f9bb0-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y/vJLnyBeXDTIbHy1w5jhjW/sztW0xwTybiSIq3qNe0=;
        b=FEUX6eNM7LraE6a/7dZ2ew/sSMSjECgempQhyROzqW4P9S9un7eAEHaQJCBjrniEZGa0XdMh8zcuDVLXsl3aV+bBzWoW5XG/0R7PqqPMgCtK5rv8TZCkgg9vRalcBb4P7IANG2IC5MhHW+j43KKJwoDL0pua6MMhH1IYua/HPgE=;
X-UUID: 2ace1321fba54e79bcd008e1019f9bb0-20200102
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 29830907; Thu, 02 Jan 2020 12:02:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:37 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6, 06/14] drm/mediatek: add connection from OVL0 to OVL_2L0
Date:   Thu, 2 Jan 2020 12:00:16 +0800
Message-ID: <1577937624-14313-7-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIE9WTDAgdG8gT1ZMXzJMMA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXgg
OTkwMDIxZC4uNGY3MTgyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
Yw0KQEAgLTEzNyw2ICsxMzcsOCBAQA0KICNkZWZpbmUgRFBJX1NFTF9JTl9CTFMJCQkweDANCiAj
ZGVmaW5lIERTSV9TRUxfSU5fUkRNQQkJCTB4MQ0KIA0KKyNkZWZpbmUgT1ZMMF9NT1VUX0VOX09W
TDBfMkwJCUJJVCg0KQ0KKw0KIHN0cnVjdCBtdGtfZGlzcF9tdXRleCB7DQogCWludCBpZDsNCiAJ
Ym9vbCBjbGFpbWVkOw0KQEAgLTMwMCw2ICszMDIsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10
a19kZHBfbW91dF9lbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KIAl9
IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX09EMSAmJiBuZXh0ID09IEREUF9DT01QT05F
TlRfUkRNQTEpIHsNCiAJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RJU1BfT0RfTU9VVF9FTjsN
CiAJCXZhbHVlID0gT0QxX01PVVRfRU5fUkRNQTE7DQorCX0gZWxzZSBpZiAoY3VyID09IEREUF9D
T01QT05FTlRfT1ZMMCAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfT1ZMXzJMMCkgew0KKwkJKmFk
ZHIgPSBkYXRhLT5vdmwwX21vdXRfZW47DQorCQl2YWx1ZSA9IE9WTDBfTU9VVF9FTl9PVkwwXzJM
Ow0KIAl9IGVsc2Ugew0KIAkJdmFsdWUgPSAwOw0KIAl9DQotLSANCjEuOC4xLjEuZGlydHkNCg==

