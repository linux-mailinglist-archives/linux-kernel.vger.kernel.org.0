Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943B21588B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 04:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBKDWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 22:22:06 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39231 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727668AbgBKDWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:22:05 -0500
X-UUID: 727b468d31034b2382378c627f4690e1-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/hQmkHh+Nb638d1NJSd79qsCtDwqSS7aM4x86Mr5zQo=;
        b=SboTzlEeFcQAf751pjqSfMu/Tib2Ixm4Wv7UuWl4CORH/jMCYh+Ip0DFzTtqXE1DwhY5xZqv0Cpq3ZqVZ1lgRHCkbW/BWLOE5DupbGi3sISjrOeLCBRXEc12gaAua1Jp/xyC9Xihg7zO1uZcamjDBpVwBAokQZB0+Iz890DeVLc=;
X-UUID: 727b468d31034b2382378c627f4690e1-20200211
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2055416526; Tue, 11 Feb 2020 11:21:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:21:02 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 09/11] phy: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Tue, 11 Feb 2020 11:21:14 +0800
Message-ID: <455bed89e738df02eaa4e803a37fce6b4424b9ee.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C089E9FD8BDFBFB18D06FD355F1D61B94850B35900C1B08D50B812359E56B95C2000:8
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
LS0tDQp2Mn52NTogbm8gY2hhbmdlcw0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10
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
ZCB0byBnZXQgcmVmX2NsayhpZC0lZClcbiIsIHBvcnQpOw0KLS0gDQoyLjI1LjANCg==

