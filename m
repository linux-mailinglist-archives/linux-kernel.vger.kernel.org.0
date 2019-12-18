Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0FD1241C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLRIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:31:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:13541 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbfLRIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:10 -0500
X-UUID: 18f95b2b25c44619b5ac86fab6178320-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nyKqbutaaCHQgIz0tIDMWCfASb943xl96hXjeHKXdmc=;
        b=pxb3yQL/4Mkc1DsMmGe93ucaNDA+3O38Sd2ht46VnELsA80pb9zhCPdn241pV2zkVDywTvU3mVyMq1ut/8VjwF6kQgeHl50HF7bTGRkPmn7jG/oKKyfYNR6g4R1ww/xUDMtLoxEIiy2pNA2eNkkn8w7p/VtXrLo4FsX8dMDUxsQ=;
X-UUID: 18f95b2b25c44619b5ac86fab6178320-20191218
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1769752438; Wed, 18 Dec 2019 16:30:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:30:29 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v10 02/12] dt-bindings: soc: Add MT8183 power dt-bindings
Date:   Wed, 18 Dec 2019 16:30:38 +0800
Message-ID: <1576657848-14711-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGR0LWJpbmRpbmdzIG9mIE1UODE4MyBhbmQgaW50cm9kdWNlcyAiQkFTSUMiIGFu
ZA0KIlNVQlNZUyIgY2xvY2sgdHlwZXMgaW4gYmluZGluZyBkb2N1bWVudC4NClRoZSAiQkFTSUMi
IHR5cGUgaXMgY29tcGF0aWJsZSB0byB0aGUgb3JpZ2luYWwgcG93ZXIgY29udHJvbCB3aXRoDQpj
bG9jayBuYW1lIFthLXpdK1swLTldKiwgZS5nLiBtbSwgdnB1MS4NClRoZSAiU1VCU1lTIiB0eXBl
IGlzIHVzZWQgZm9yIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgd2l0aCBjbG9jaw0KbmFtZSBbYS16
XSstWzAtOV0rLCBlLmcuIGlzcC0wLCBjYW0tMS4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUg
PHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9tZWRpYXRlay9zY3BzeXMudHh0ICAgIHwgMjAgKysrKysrKysrKysrKystLS0NCiBpbmNsdWRl
L2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAgICAgICAgICB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIv
bXQ4MTgzLXBvd2VyLmgNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KaW5kZXggOGY0NjlkOC4uOGUwZTFl
ZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvc2Nwc3lzLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQpAQCAtMTQsNiArMTQsNyBAQCBwb3dlci9wb3dlci1k
b21haW4ueWFtbC4gSXQgcHJvdmlkZXMgdGhlIHBvd2VyIGRvbWFpbnMgZGVmaW5lZCBpbg0KIC0g
aW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDI3MDEtcG93ZXIuaA0KIC0gaW5jbHVkZS9kdC1i
aW5kaW5ncy9wb3dlci9tdDI3MTItcG93ZXIuaA0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dl
ci9tdDc2MjItcG93ZXIuaA0KKy0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93
ZXIuaA0KIA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlOiBTaG91bGQgYmUg
b25lIG9mOg0KQEAgLTI1LDE4ICsyNiwzMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAktICJt
ZWRpYXRlayxtdDc2MjNhLXNjcHN5cyI6IEZvciBNVDc2MjNBIFNvQw0KIAktICJtZWRpYXRlayxt
dDc2Mjktc2Nwc3lzIiwgIm1lZGlhdGVrLG10NzYyMi1zY3BzeXMiOiBGb3IgTVQ3NjI5IFNvQw0K
IAktICJtZWRpYXRlayxtdDgxNzMtc2Nwc3lzIg0KKwktICJtZWRpYXRlayxtdDgxODMtc2Nwc3lz
Ig0KIC0gI3Bvd2VyLWRvbWFpbi1jZWxsczogTXVzdCBiZSAxDQogLSByZWc6IEFkZHJlc3MgcmFu
Z2Ugb2YgdGhlIFNDUFNZUyB1bml0DQogLSBpbmZyYWNmZzogbXVzdCBjb250YWluIGEgcGhhbmRs
ZSB0byB0aGUgaW5mcmFjZmcgY29udHJvbGxlcg0KLS0gY2xvY2ssIGNsb2NrLW5hbWVzOiBjbG9j
a3MgYWNjb3JkaW5nIHRvIHRoZSBjb21tb24gY2xvY2sgYmluZGluZy4NCi0gICAgICAgICAgICAg
ICAgICAgICAgVGhlc2UgYXJlIGNsb2NrcyB3aGljaCBoYXJkd2FyZSBuZWVkcyB0byBiZQ0KLSAg
ICAgICAgICAgICAgICAgICAgICBlbmFibGVkIGJlZm9yZSBlbmFibGluZyBjZXJ0YWluIHBvd2Vy
IGRvbWFpbnMuDQorLSBjbG9jaywgY2xvY2stbmFtZXM6IENsb2NrcyBhY2NvcmRpbmcgdG8gdGhl
IGNvbW1vbiBjbG9jayBiaW5kaW5nLg0KKyAgICAgICAgICAgICAgICAgICAgICBTb21lIFNvQ3Mg
aGF2ZSB0byBncm91cHMgb2YgY2xvY2tzLg0KKyAgICAgICAgICAgICAgICAgICAgICBCQVNJQyBj
bG9ja3MgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSBlbmFibGluZyB0aGUNCisgICAgICAgICAg
ICAgICAgICAgICAgY29ycmVzcG9uZGluZyBwb3dlciBkb21haW4uDQorICAgICAgICAgICAgICAg
ICAgICAgIFNVQlNZUyBjbG9ja3MgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSByZWxlYXNpbmcg
dGhlDQorICAgICAgICAgICAgICAgICAgICAgIGJ1cyBwcm90ZWN0aW9uLg0KIAlSZXF1aXJlZCBj
bG9ja3MgZm9yIE1UMjcwMSBvciBNVDc2MjM6ICJtbSIsICJtZmciLCAiZXRoaWYiDQogCVJlcXVp
cmVkIGNsb2NrcyBmb3IgTVQyNzEyOiAibW0iLCAibWZnIiwgInZlbmMiLCAianBnZGVjIiwgImF1
ZGlvIiwgInZkZWMiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ2Nzk3OiAibW0iLCAibWZnIiwg
InZkZWMiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ3NjIyIG9yIE1UNzYyOTogImhpZl9zZWwi
DQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ3NjIzQTogImV0aGlmIg0KIAlSZXF1aXJlZCBjbG9j
a3MgZm9yIE1UODE3MzogIm1tIiwgIm1mZyIsICJ2ZW5jIiwgInZlbmNfbHQiDQorCVJlcXVpcmVk
IGNsb2NrcyBmb3IgTVQ4MTgzOiBCQVNJQzogImF1ZGlvIiwgIm1mZyIsICJtbSIsICJjYW0iLCAi
aXNwIiwNCisJCQkJCSAgICJ2cHUiLCAidnB1MSIsICJ2cHUyIiwgInZwdTMiDQorCQkJCSAgICBT
VUJTWVM6ICJtbS0wIiwgIm1tLTEiLCAibW0tMiIsICJtbS0zIiwNCisJCQkJCSAgICAibW0tNCIs
ICJtbS01IiwgIm1tLTYiLCAibW0tNyIsDQorCQkJCQkgICAgIm1tLTgiLCAibW0tOSIsICJpc3At
MCIsICJpc3AtMSIsDQorCQkJCQkgICAgImNhbS0wIiwgImNhbS0xIiwgImNhbS0yIiwgImNhbS0z
IiwNCisJCQkJCSAgICAiY2FtLTQiLCAiY2FtLTUiLCAiY2FtLTYiLCAidnB1LTAiLA0KKwkJCQkJ
ICAgICJ2cHUtMSIsICJ2cHUtMiIsICJ2cHUtMyIsICJ2cHUtNCIsDQorCQkJCQkgICAgInZwdS01
Ig0KIA0KIE9wdGlvbmFsIHByb3BlcnRpZXM6DQogLSB2ZGVjLXN1cHBseTogUG93ZXIgc3VwcGx5
IGZvciB0aGUgdmRlYyBwb3dlciBkb21haW4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRp
bmdzL3Bvd2VyL210ODE4My1wb3dlci5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgx
ODMtcG93ZXIuaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjVjMGM4YzcN
Ci0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBv
d2VyLmgNCkBAIC0wLDAgKzEsMjYgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDE4IE1lZGlhVGVrIEluYy4NCisgKiBBdXRo
b3I6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorICovDQorDQorI2lmbmRlZiBf
RFRfQklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0gNCisjZGVmaW5lIF9EVF9CSU5ESU5HU19Q
T1dFUl9NVDgxODNfUE9XRVJfSA0KKw0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9BVURJ
TwkwDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0NPTk4JMQ0KKyNkZWZpbmUgTVQ4MTgz
X1BPV0VSX0RPTUFJTl9NRkdfQVNZTkMJMg0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9N
RkcJCTMNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NPUkUwCTQNCisjZGVmaW5l
IE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NPUkUxCTUNCisjZGVmaW5lIE1UODE4M19QT1dFUl9E
T01BSU5fTUZHXzJECTYNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fRElTUAk3DQorI2Rl
ZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0NBTQkJOA0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RP
TUFJTl9JU1AJCTkNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVkRFQwkxMA0KKyNkZWZp
bmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WRU5DCTExDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9N
QUlOX1ZQVV9UT1AJMTINCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBVX0NPUkUwCTEz
DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX1ZQVV9DT1JFMQkxNA0KKw0KKyNlbmRpZiAv
KiBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0ggKi8NCi0tIA0KMS44LjEuMS5kaXJ0
eQ0K

