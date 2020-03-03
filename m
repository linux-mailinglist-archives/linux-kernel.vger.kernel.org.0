Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5371774C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgCCK6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:58:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59889 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727824AbgCCK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:58:54 -0500
X-UUID: b974398f39a94f56a5065b1923579d4e-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tvJwnCsxKOoCpY4EO2ACWGPLaJ529RvRvxVs2WE/jK0=;
        b=lOiIk3V0gvMpVTfuzTLbO7Z9tngXOcn6U5g9wUT3UX6i1Oe8utk4HPc+Zjpdmzv5zMHL9TA2ZVWUSGxvpMBd3Yj1LgIX0CN+UZ2JTxiIcV44VPVWiw8ES4uiozGBn30zhMpSdbAkKEEo7m5s/DF5bz4d7yeP5tobA6GywuEHPRg=;
X-UUID: b974398f39a94f56a5065b1923579d4e-20200303
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1075989224; Tue, 03 Mar 2020 18:58:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:57:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:12 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v4 13/13] soc: mediatek: cmdq: add set event function
Date:   Tue, 3 Mar 2020 18:58:45 +0800
Message-ID: <1583233125-7827-14-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAx
NSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIHwgIDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAg
OSArKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDRmNzY3MTk4ZDBmYy4uZTdjYWQ4
YTRiNmM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzI2
LDYgKzMyNiwyMSBAQCBpbnQgY21kcV9wa3RfY2xlYXJfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9jbGVhcl9ldmVudCk7
DQogDQoraW50IGNtZHFfcGt0X3NldF9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorDQor
CWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCisJaW5zdC52YWx1ZSA9IENNRFFfV0ZFX1VQREFURSB8
IENNRFFfV0ZFX1VQREFURV9WQUxVRTsNCisJaW5zdC5ldmVudCA9IGV2ZW50Ow0KKw0KKwlyZXR1
cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9zZXRfZXZlbnQpOw0KKw0KIGludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogCQkgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSkNCiB7DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDQyZDJhMzBlNmE3
MC4uYmEyZDgxMTE4M2E5IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KQEAgLTE3LDYgKzE3LDcgQEANCiAjZGVmaW5lIENNRFFfSlVNUF9QQVNTCQkJQ01EUV9J
TlNUX1NJWkUNCiANCiAjZGVmaW5lIENNRFFfV0ZFX1VQREFURQkJCUJJVCgzMSkNCisjZGVmaW5l
IENNRFFfV0ZFX1VQREFURV9WQUxVRQkJQklUKDE2KQ0KICNkZWZpbmUgQ01EUV9XRkVfV0FJVAkJ
CUJJVCgxNSkNCiAjZGVmaW5lIENNRFFfV0ZFX1dBSVRfVkFMVUUJCTB4MQ0KIA0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBkNjM3NDk0NDA2OTcuLmNhNzAyOTZhZTEy
MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xNjgsNiArMTY4
LDE1IEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwg
Ym9vbCBjbGVhcik7DQogICovDQogaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0X3NldF9ldmVudCgp
IC0gYXBwZW5kIHNldCBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdG8gYmUgc2V0
DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMg
cmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfc2V0X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgZXZlbnQpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBw
b2xsaW5nIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFIHRvDQogICoJCSAgICAg
ZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHdhaXQgZm9yIGEgc3BlY2lmaWVkDQotLSANCjIu
MTguMA0K

