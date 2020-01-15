Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAED13C4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgAOOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:01:33 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:36398 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729697AbgAOOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:24 -0500
X-UUID: e17ba0cc0d9142efad2d09c625ac8f73-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oZYrr2LEPwbdNLpuKoMeOVVJNsOiZbhJJb8h4ktYfYk=;
        b=FVmk2u9djdawoG27yWeax2/PSlVH6YSNQQlZb+JlmRRjUmcGLjCITtnmp4ilLuaxZxSCxNzstDPBaua9KoUaQg1H0fp8ZsWdg1hT5nvhO9pP5AIxLbgsO4WNTZTw3liLQ1M6JpeaWN7cFJWE9xcZhyWRx8O62mpRUxNR2B/smCQ=;
X-UUID: e17ba0cc0d9142efad2d09c625ac8f73-20200115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1935524702; Wed, 15 Jan 2020 22:01:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 22:01:40 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:01:23 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v8 8/8] drm/panel: support for auo,b101uan08.3 wuxga dsi video mode panel
Date:   Wed, 15 Jan 2020 21:59:58 +0800
Message-ID: <20200115135958.126303-9-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115135958.126303-1-jitao.shi@mediatek.com>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4A2ED715479501E90EC666853CA3146553CBE76094AEC6A42B2C4770B0B57D342000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXVvLGF1byxiMTAxdWFuMDguMydzIGNvbm5lY3RvciBpcyBzYW1lIGFzIGJvZSx0djEwMXd1bS1u
bDYuDQpUaGUgbW9zdCBjb2RlcyBjYW4gYmUgcmV1c2UuDQpTbyBhdW8sYjEwMXVhbjA4LjMgYW5k
IGJvZSx0djEwMXd1bS1ubDYgdXNlIG9uZSBkcml2ZXIgZmlsZS4NCkFkZCB0aGUgZGlmZmVyZW50
IHBhcnRzIGluIGRyaXZlciBkYXRhLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFv
LnNoaUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJv
cmcub3JnPg0KLS0tDQogLi4uL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5j
ICAgIHwgNzggKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3OCBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2
MTAxd3VtLW5sNi5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1u
bDYuYw0KaW5kZXggMDEwOGJmZjI4M2M1Li41MTAwMTk0MGVhYjMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jDQpAQCAtMzc3LDYgKzM3Nyw1
MyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBhbmVsX2luaXRfY21kIGF1b19rZDEwMW44MF80NW5h
X2luaXRfY21kW10gPSB7DQogCXt9LA0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5l
bF9pbml0X2NtZCBhdW9fYjEwMXVhbjA4XzNfaW5pdF9jbWRbXSA9IHsNCisJX0lOSVRfREVMQVlf
Q01EKDI0KSwNCisJX0lOSVRfRENTX0NNRCgweEIwLCAweDAxKSwNCisJX0lOSVRfRENTX0NNRCgw
eEMwLCAweDQ4KSwNCisJX0lOSVRfRENTX0NNRCgweEMxLCAweDQ4KSwNCisJX0lOSVRfRENTX0NN
RCgweEMyLCAweDQ3KSwNCisJX0lOSVRfRENTX0NNRCgweEMzLCAweDQ3KSwNCisJX0lOSVRfRENT
X0NNRCgweEM0LCAweDQ2KSwNCisJX0lOSVRfRENTX0NNRCgweEM1LCAweDQ2KSwNCisJX0lOSVRf
RENTX0NNRCgweEM2LCAweDQ1KSwNCisJX0lOSVRfRENTX0NNRCgweEM3LCAweDQ1KSwNCisJX0lO
SVRfRENTX0NNRCgweEM4LCAweDY0KSwNCisJX0lOSVRfRENTX0NNRCgweEM5LCAweDY0KSwNCisJ
X0lOSVRfRENTX0NNRCgweENBLCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgweENCLCAweDRGKSwN
CisJX0lOSVRfRENTX0NNRCgweENDLCAweDQwKSwNCisJX0lOSVRfRENTX0NNRCgweENELCAweDQw
KSwNCisJX0lOSVRfRENTX0NNRCgweENFLCAweDY2KSwNCisJX0lOSVRfRENTX0NNRCgweENGLCAw
eDY2KSwNCisJX0lOSVRfRENTX0NNRCgweEQwLCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgweEQx
LCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgweEQyLCAweDQxKSwNCisJX0lOSVRfRENTX0NNRCgw
eEQzLCAweDQxKSwNCisJX0lOSVRfRENTX0NNRCgweEQ0LCAweDQ4KSwNCisJX0lOSVRfRENTX0NN
RCgweEQ1LCAweDQ4KSwNCisJX0lOSVRfRENTX0NNRCgweEQ2LCAweDQ3KSwNCisJX0lOSVRfRENT
X0NNRCgweEQ3LCAweDQ3KSwNCisJX0lOSVRfRENTX0NNRCgweEQ4LCAweDQ2KSwNCisJX0lOSVRf
RENTX0NNRCgweEQ5LCAweDQ2KSwNCisJX0lOSVRfRENTX0NNRCgweERBLCAweDQ1KSwNCisJX0lO
SVRfRENTX0NNRCgweERCLCAweDQ1KSwNCisJX0lOSVRfRENTX0NNRCgweERDLCAweDY0KSwNCisJ
X0lOSVRfRENTX0NNRCgweERELCAweDY0KSwNCisJX0lOSVRfRENTX0NNRCgweERFLCAweDRGKSwN
CisJX0lOSVRfRENTX0NNRCgweERGLCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgweEUwLCAweDQw
KSwNCisJX0lOSVRfRENTX0NNRCgweEUxLCAweDQwKSwNCisJX0lOSVRfRENTX0NNRCgweEUyLCAw
eDY2KSwNCisJX0lOSVRfRENTX0NNRCgweEUzLCAweDY2KSwNCisJX0lOSVRfRENTX0NNRCgweEU0
LCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgweEU1LCAweDRGKSwNCisJX0lOSVRfRENTX0NNRCgw
eEU2LCAweDQxKSwNCisJX0lOSVRfRENTX0NNRCgweEU3LCAweDQxKSwNCisJX0lOSVRfREVMQVlf
Q01EKDE1MCksDQorCXt9LA0KK307DQorDQogc3RhdGljIGlubGluZSBzdHJ1Y3QgYm9lX3BhbmVs
ICp0b19ib2VfcGFuZWwoc3RydWN0IGRybV9wYW5lbCAqcGFuZWwpDQogew0KIAlyZXR1cm4gY29u
dGFpbmVyX29mKHBhbmVsLCBzdHJ1Y3QgYm9lX3BhbmVsLCBiYXNlKTsNCkBAIC02MjEsNiArNjY4
LDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGFuZWxfZGVzYyBib2VfdHYxMDF3dW1fbjUzX2Rl
c2MgPSB7DQogCS5pbml0X2NtZHMgPSBib2VfaW5pdF9jbWQsDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYXVvX2IxMDF1YW4wOF8zX2RlZmF1bHRfbW9kZSA9
IHsNCisJLmNsb2NrID0gMTU5NjY3LA0KKwkuaGRpc3BsYXkgPSAxMjAwLA0KKwkuaHN5bmNfc3Rh
cnQgPSAxMjAwICsgNjAsDQorCS5oc3luY19lbmQgPSAxMjAwICsgNjAgKyA0LA0KKwkuaHRvdGFs
ID0gMTIwMCArIDYwICsgNCArIDgwLA0KKwkudmRpc3BsYXkgPSAxOTIwLA0KKwkudnN5bmNfc3Rh
cnQgPSAxOTIwICsgMzQsDQorCS52c3luY19lbmQgPSAxOTIwICsgMzQgKyAyLA0KKwkudnRvdGFs
ID0gMTkyMCArIDM0ICsgMiArIDI0LA0KKwkudnJlZnJlc2ggPSA2MCwNCisJLnR5cGUgPSBEUk1f
TU9ERV9UWVBFX0RSSVZFUiB8IERSTV9NT0RFX1RZUEVfUFJFRkVSUkVELA0KK307DQorDQorc3Rh
dGljIGNvbnN0IHN0cnVjdCBwYW5lbF9kZXNjIGF1b19iMTAxdWFuMDhfM19kZXNjID0gew0KKwku
bW9kZXMgPSAmYXVvX2IxMDF1YW4wOF8zX2RlZmF1bHRfbW9kZSwNCisJLmJwYyA9IDgsDQorCS5z
aXplID0gew0KKwkJLndpZHRoX21tID0gMTM1LA0KKwkJLmhlaWdodF9tbSA9IDIxNiwNCisJfSwN
CisJLmxhbmVzID0gNCwNCisJLmZvcm1hdCA9IE1JUElfRFNJX0ZNVF9SR0I4ODgsDQorCS5tb2Rl
X2ZsYWdzID0gTUlQSV9EU0lfTU9ERV9WSURFTyB8IE1JUElfRFNJX01PREVfVklERU9fU1lOQ19Q
VUxTRSB8DQorCQkgICAgICBNSVBJX0RTSV9NT0RFX0xQTSwNCisJLmluaXRfY21kcyA9IGF1b19i
MTAxdWFuMDhfM19pbml0X2NtZCwNCit9Ow0KKw0KIHN0YXRpYyBpbnQgYm9lX3BhbmVsX2dldF9t
b2RlcyhzdHJ1Y3QgZHJtX3BhbmVsICpwYW5lbCwNCiAJCQkgICAgICAgc3RydWN0IGRybV9jb25u
ZWN0b3IgKmNvbm5lY3RvcikNCiB7DQpAQCAtNzU2LDYgKzgzMSw5IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIGJvZV9vZl9tYXRjaFtdID0gew0KIAl7IC5jb21wYXRpYmxlID0g
ImJvZSx0djEwMXd1bS1uNTMiLA0KIAkgIC5kYXRhID0gJmJvZV90djEwMXd1bV9uNTNfZGVzYw0K
IAl9LA0KKwl7IC5jb21wYXRpYmxlID0gImF1byxiMTAxdWFuMDguMyIsDQorCSAgLmRhdGEgPSAm
YXVvX2IxMDF1YW4wOF8zX2Rlc2MNCisJfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9DQogfTsNCiBN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBib2Vfb2ZfbWF0Y2gpOw0KLS0gDQoyLjIxLjANCg==

