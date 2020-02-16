Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14013160237
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 07:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBPGRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 01:17:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726599AbgBPGRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 01:17:34 -0500
X-UUID: 3d05691ae7504b4a9ef902fc8fd47213-20200216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vySsqR8YwL/rCEwOS5ApjszqOvFYlWv2IHCLH9JUPFY=;
        b=HSF7wwgKLLMVSTQtLtUcfbz3zn4qYyE9ODJlaJ6Fyk3plFLgT9bNcE/MVbJQyGTSHEvQCQ3cbdx3dxrJMxxymJElJbwNr2fAr6TJtFRxo9X4bRyCx4Xh8Ov0ZphhaWrGx1ImD4+Tvof4cW2H8vVMWciY9pIK/4fkzMo0YOg/gVQ=;
X-UUID: 3d05691ae7504b4a9ef902fc8fd47213-20200216
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 570924008; Sun, 16 Feb 2020 14:17:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 16 Feb 2020 14:16:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 16 Feb 2020 14:17:17 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Chenglin Xu <chenglin.xu@mediatek.com>, <argus.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <henryc.chen@mediatek.com>,
        <flora.fu@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] soc: mediatek: pwrap: add pwrap driver for MT6779 SoCs
Date:   Sun, 16 Feb 2020 14:17:22 +0800
Message-ID: <1581833843-4485-3-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1581833843-4485-1-git-send-email-argus.lin@mediatek.com>
References: <1581833843-4485-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVQ2Nzc5IGlzIGEgaGlnaGx5IGludGVncmF0ZWQgU29DcywgaXQgdXNlcyBQTUlDX01UNjM1OSBm
b3INCnBvd2VyIG1hbmFnZW1lbnQuIFRoaXMgcGF0Y2ggYWRkcyBwd3JhcCBtYXN0ZXIgZHJpdmVy
IHRvDQphY2Nlc3MgUE1JQ19NVDYzNTkuDQoNClNpZ25lZC1vZmYtYnk6IEFyZ3VzIExpbiA8YXJn
dXMubGluQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbWlj
LXdyYXAuYyB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstcG1pYy13cmFwLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13
cmFwLmMNCmluZGV4IGM3MjUzMTUuLjFmODE4OWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1w
bWljLXdyYXAuYw0KQEAgLTQ5Nyw2ICs0OTcsNDUgQEAgZW51bSBwd3JhcF9yZWdzIHsNCiAJW1BX
UkFQX0RDTV9EQkNfUFJEXSA9CQkweDFFMCwNCiB9Ow0KDQorc3RhdGljIGludCBtdDY3NzlfcmVn
c1tdID0gew0KKwlbUFdSQVBfTVVYX1NFTF0gPQkJMHgwLA0KKwlbUFdSQVBfV1JBUF9FTl0gPQkJ
MHg0LA0KKwlbUFdSQVBfRElPX0VOXSA9CQkweDgsDQorCVtQV1JBUF9SRERNWV0gPQkJCTB4MjAs
DQorCVtQV1JBUF9DU0hFWFRfV1JJVEVdID0JCTB4MjQsDQorCVtQV1JBUF9DU0hFWFRfUkVBRF0g
PQkJMHgyOCwNCisJW1BXUkFQX0NTTEVYVF9XUklURV0gPQkJMHgyQywNCisJW1BXUkFQX0NTTEVY
VF9SRUFEXSA9CQkweDMwLA0KKwlbUFdSQVBfRVhUX0NLX1dSSVRFXSA9CQkweDM0LA0KKwlbUFdS
QVBfU1RBVVBEX0NUUkxdID0JCTB4M0MsDQorCVtQV1JBUF9TVEFVUERfR1JQRU5dID0JCTB4NDAs
DQorCVtQV1JBUF9FSU5UX1NUQTBfQURSXSA9CQkweDQ0LA0KKwlbUFdSQVBfSEFSQl9IUFJJT10g
PQkJMHg2OCwNCisJW1BXUkFQX0hJUFJJT19BUkJfRU5dID0JCTB4NkMsDQorCVtQV1JBUF9NQU5f
RU5dID0JCTB4N0MsDQorCVtQV1JBUF9NQU5fQ01EXSA9CQkweDgwLA0KKwlbUFdSQVBfV0FDUzBf
RU5dID0JCTB4OEMsDQorCVtQV1JBUF9JTklUX0RPTkUwXSA9CQkweDkwLA0KKwlbUFdSQVBfV0FD
UzFfRU5dID0JCTB4OTQsDQorCVtQV1JBUF9XQUNTMl9FTl0gPQkJMHg5QywNCisJW1BXUkFQX0lO
SVRfRE9ORTFdID0JCTB4OTgsDQorCVtQV1JBUF9JTklUX0RPTkUyXSA9CQkweEEwLA0KKwlbUFdS
QVBfSU5UX0VOXSA9CQkweEJDLA0KKwlbUFdSQVBfSU5UX0ZMR19SQVddID0JCTB4QzAsDQorCVtQ
V1JBUF9JTlRfRkxHXSA9CQkweEM0LA0KKwlbUFdSQVBfSU5UX0NMUl0gPQkJMHhDOCwNCisJW1BX
UkFQX0lOVDFfRU5dID0JCTB4Q0MsDQorCVtQV1JBUF9JTlQxX0ZMR10gPQkJMHhENCwNCisJW1BX
UkFQX0lOVDFfQ0xSXSA9CQkweEQ4LA0KKwlbUFdSQVBfVElNRVJfRU5dID0JCTB4RjAsDQorCVtQ
V1JBUF9XRFRfVU5JVF0gPQkJMHhGOCwNCisJW1BXUkFQX1dEVF9TUkNfRU5dID0JCTB4RkMsDQor
CVtQV1JBUF9XRFRfU1JDX0VOXzFdID0JCTB4MTAwLA0KKwlbUFdSQVBfV0FDUzJfQ01EXSA9CQkw
eEMyMCwNCisJW1BXUkFQX1dBQ1MyX1JEQVRBXSA9CQkweEMyNCwNCisJW1BXUkFQX1dBQ1MyX1ZM
RENMUl0gPQkJMHhDMjgsDQorfTsNCisNCiBzdGF0aWMgaW50IG10Njc5N19yZWdzW10gPSB7DQog
CVtQV1JBUF9NVVhfU0VMXSA9CQkweDAsDQogCVtQV1JBUF9XUkFQX0VOXSA9CQkweDQsDQpAQCAt
OTQ1LDYgKzk4NCw3IEBAIGVudW0gcG1pY190eXBlIHsNCiBlbnVtIHB3cmFwX3R5cGUgew0KIAlQ
V1JBUF9NVDI3MDEsDQogCVBXUkFQX01UNjc2NSwNCisJUFdSQVBfTVQ2Nzc5LA0KIAlQV1JBUF9N
VDY3OTcsDQogCVBXUkFQX01UNzYyMiwNCiAJUFdSQVBfTVQ4MTM1LA0KQEAgLTEzNzcsNiArMTQx
Nyw3IEBAIHN0YXRpYyBpbnQgcHdyYXBfaW5pdF9jaXBoZXIoc3RydWN0IHBtaWNfd3JhcHBlciAq
d3JwKQ0KIAkJYnJlYWs7DQogCWNhc2UgUFdSQVBfTVQyNzAxOg0KIAljYXNlIFBXUkFQX01UNjc2
NToNCisJY2FzZSBQV1JBUF9NVDY3Nzk6DQogCWNhc2UgUFdSQVBfTVQ2Nzk3Og0KIAljYXNlIFBX
UkFQX01UODE3MzoNCiAJY2FzZSBQV1JBUF9NVDg1MTY6DQpAQCAtMTc4Myw2ICsxODI0LDE5IEBA
IHN0YXRpYyBpcnFyZXR1cm5fdCBwd3JhcF9pbnRlcnJ1cHQoaW50IGlycW5vLCB2b2lkICpkZXZf
aWQpDQogCS5pbml0X3NvY19zcGVjaWZpYyA9IE5VTEwsDQogfTsNCg0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUgcHdyYXBfbXQ2Nzc5ID0gew0KKwkucmVncyA9IG10Njc3
OV9yZWdzLA0KKwkudHlwZSA9IFBXUkFQX01UNjc3OSwNCisJLmFyYl9lbl9hbGwgPSAweGZiYjdm
LA0KKwkuaW50X2VuX2FsbCA9IDB4ZmZmZmZmZmUsDQorCS5pbnQxX2VuX2FsbCA9IDAsDQorCS5z
cGlfdyA9IFBXUkFQX01BTl9DTURfU1BJX1dSSVRFLA0KKwkud2R0X3NyYyA9IFBXUkFQX1dEVF9T
UkNfTUFTS19BTEwsDQorCS5jYXBzID0gMCwNCisJLmluaXRfcmVnX2Nsb2NrID0gcHdyYXBfY29t
bW9uX2luaXRfcmVnX2Nsb2NrLA0KKwkuaW5pdF9zb2Nfc3BlY2lmaWMgPSBOVUxMLA0KK307DQor
DQogc3RhdGljIGNvbnN0IHN0cnVjdCBwbWljX3dyYXBwZXJfdHlwZSBwd3JhcF9tdDY3OTcgPSB7
DQogCS5yZWdzID0gbXQ2Nzk3X3JlZ3MsDQogCS50eXBlID0gUFdSQVBfTVQ2Nzk3LA0KQEAgLTE4
NjgsNiArMTkyMiw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBwd3JhcF9pbnRlcnJ1cHQoaW50IGly
cW5vLCB2b2lkICpkZXZfaWQpDQogCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtcHdy
YXAiLA0KIAkJLmRhdGEgPSAmcHdyYXBfbXQ2NzY1LA0KIAl9LCB7DQorCQkuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDY3NzktcHdyYXAiLA0KKwkJLmRhdGEgPSAmcHdyYXBfbXQ2Nzc5LA0KKwl9
LCB7DQogCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3OTctcHdyYXAiLA0KIAkJLmRhdGEg
PSAmcHdyYXBfbXQ2Nzk3LA0KIAl9LCB7DQotLQ0KMS44LjEuMS5kaXJ0eQ0K

