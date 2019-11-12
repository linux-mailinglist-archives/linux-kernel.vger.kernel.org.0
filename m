Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB86DF8A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKLIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 03:37:10 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29380 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727171AbfKLIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:07 -0500
X-UUID: cff17095784c47dbb6fd3cc31a521468-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qy9ivUWj/ElKl+3goTjgwfuF3GW/F0SKTM6aPsZ/8T8=;
        b=fIcrJIcR7vSx051jQEd8ddAx+woWi4HI11eyAzk4W9RoSB8cYZVOvHcwBdY133lFzOirgO3sd8/KrJCmbYiF5ZGVn1xBi9Ghi3tjnjAk9M85xYxkxq9+cxmimPz8L0nfmqfZ7ZAGaFYaMFrQ+I3hFEE7Cp6zAbAvlnHp8iaY5OQ=;
X-UUID: cff17095784c47dbb6fd3cc31a521468-20191112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1547289990; Tue, 12 Nov 2019 16:37:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:37:01 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:37:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 09/11] phy: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Tue, 12 Nov 2019 16:36:34 +0800
Message-ID: <1573547796-29566-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D22098D56DE57EC675AFDE6068FBF972EE78801099749E93CC00EBC1C200C10D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHUzcGh5YV9yZWYgY2xvY2sgaXMgYWxyZWFkeSBtb3ZlZCBpbnRvIHN1Yi1ub2RlLCBhbmQN
CnJlbmFtZWQgYXMgcmVmIGNsb2NrLCBubyB1c2VkIGFueW1vcmUgbm93LCBzbyByZW1vdmUgaXQs
DQp0aGlzIGNhbiBhdm9pZCBjb25mdXNpb24gd2hlbiBzdXBwb3J0IG5ldyBwbGF0Zm9ybXMNCg0K
U2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0K
LS0tDQp2Mn52NDogbm8gY2hhbmdlcw0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10
ay10cGh5LmMgfCAxOCAtLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRw
aHkuYyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQppbmRleCA5NmM2MmUz
YTMzMDAuLmM2NDI0ZmQyYTA2ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstdHBoeS5jDQorKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0K
QEAgLTMxMiw4ICszMTIsNiBAQCBzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSB7DQogc3RydWN0IG10
a190cGh5IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAl2b2lkIF9faW9tZW0gKnNpZl9iYXNl
OwkvKiBvbmx5IHNoYXJlZCBzaWYgKi8NCi0JLyogZGVwcmVjYXRlZCwgdXNlIEByZWZfY2xrIGlu
c3RlYWQgaW4gcGh5IGluc3RhbmNlICovDQotCXN0cnVjdCBjbGsgKnUzcGh5YV9yZWY7CS8qIHJl
ZmVyZW5jZSBjbG9jayBvZiB1c2IzIGFub2xvZyBwaHkgKi8NCiAJY29uc3Qgc3RydWN0IG10a19w
aHlfcGRhdGEgKnBkYXRhOw0KIAlzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSAqKnBoeXM7DQogCWlu
dCBucGh5czsNCkBAIC05MjEsMTIgKzkxOSw2IEBAIHN0YXRpYyBpbnQgbXRrX3BoeV9pbml0KHN0
cnVjdCBwaHkgKnBoeSkNCiAJc3RydWN0IG10a190cGh5ICp0cGh5ID0gZGV2X2dldF9kcnZkYXRh
KHBoeS0+ZGV2LnBhcmVudCk7DQogCWludCByZXQ7DQogDQotCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZSh0cGh5LT51M3BoeWFfcmVmKTsNCi0JaWYgKHJldCkgew0KLQkJZGV2X2Vycih0cGh5LT5k
ZXYsICJmYWlsZWQgdG8gZW5hYmxlIHUzcGh5YV9yZWZcbiIpOw0KLQkJcmV0dXJuIHJldDsNCi0J
fQ0KLQ0KIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoaW5zdGFuY2UtPnJlZl9jbGspOw0KIAlp
ZiAocmV0KSB7DQogCQlkZXZfZXJyKHRwaHktPmRldiwgImZhaWxlZCB0byBlbmFibGUgcmVmX2Ns
a1xuIik7DQpAQCAtOTkyLDcgKzk4NCw2IEBAIHN0YXRpYyBpbnQgbXRrX3BoeV9leGl0KHN0cnVj
dCBwaHkgKnBoeSkNCiAJCXUyX3BoeV9pbnN0YW5jZV9leGl0KHRwaHksIGluc3RhbmNlKTsNCiAN
CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGluc3RhbmNlLT5yZWZfY2xrKTsNCi0JY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKHRwaHktPnUzcGh5YV9yZWYpOw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAt
MTEyNywxMSArMTExOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3RwaHlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCiAJCX0NCiAJfQ0KIA0KLQkvKiBpdCdzIGRlcHJlY2F0ZWQsIG1h
a2UgaXQgb3B0aW9uYWwgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgKi8NCi0JdHBoeS0+dTNw
aHlhX3JlZiA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJ1M3BoeWFfcmVmIik7DQotCWlm
IChJU19FUlIodHBoeS0+dTNwaHlhX3JlZikpDQotCQlyZXR1cm4gUFRSX0VSUih0cGh5LT51M3Bo
eWFfcmVmKTsNCi0NCiAJdHBoeS0+c3JjX3JlZl9jbGsgPSBVM1BfUkVGX0NMSzsNCiAJdHBoeS0+
c3JjX2NvZWYgPSBVM1BfU0xFV19SQVRFX0NPRUY7DQogCS8qIHVwZGF0ZSBwYXJhbWV0ZXJzIG9m
IHNsZXcgcmF0ZSBjYWxpYnJhdGUgaWYgZXhpc3QgKi8NCkBAIC0xMTc4LDEwICsxMTY0LDYgQEAg
c3RhdGljIGludCBtdGtfdHBoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IAkJcGh5X3NldF9kcnZkYXRhKHBoeSwgaW5zdGFuY2UpOw0KIAkJcG9ydCsrOw0KIA0KLQkJLyog
aWYgZGVwcmVjYXRlZCBjbG9jayBpcyBwcm92aWRlZCwgaWdub3JlIGluc3RhbmNlJ3Mgb25lICov
DQotCQlpZiAodHBoeS0+dTNwaHlhX3JlZikNCi0JCQljb250aW51ZTsNCi0NCiAJCWluc3RhbmNl
LT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwaHktPmRldiwgInJlZiIpOw0KIAkJ
aWYgKElTX0VSUihpbnN0YW5jZS0+cmVmX2NsaykpIHsNCiAJCQlkZXZfZXJyKGRldiwgImZhaWxl
ZCB0byBnZXQgcmVmX2NsayhpZC0lZClcbiIsIHBvcnQpOw0KLS0gDQoyLjIzLjANCg==

