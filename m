Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732401588BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 04:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBKDWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 22:22:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:6033 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727668AbgBKDWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:22:12 -0500
X-UUID: 7352c12215dc44dcb4c5ff3759dbd0de-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fgy9El5Qn0cYg+2CAEdmvpYWsxkRwPD2Er5oAmL8kew=;
        b=IhNSdkB2RLoa3kwel9prW3eQsrMzllkaMqRwNMeaOwiayzrhYX6e9Yv180jz2gcvGKG0B+oYmffPfynyyTOOCEExy31BAnYIid23iSqQ9s9bPNuK6zIwoY2AhT0MgLsBFtkRo4vh+XFXzyUXa4O/bupbdttND/PMpZUB3w6CC5U=;
X-UUID: 7352c12215dc44dcb4c5ff3759dbd0de-20200211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1249954646; Tue, 11 Feb 2020 11:21:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:20:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 05/11] dt-bindings: phy-mtk-tphy: add the properties about address mapping
Date:   Tue, 11 Feb 2020 11:21:10 +0800
Message-ID: <4a18346dc774a4365713ad449bf2b1f991816762.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F0F3D3A5E5CF355AD99478578BD97B1C604053B8B3AD97B86C4745A65AAC9CE92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRocmVlIHJlcXVpcmVkIHByb3BlcnRpZXMgYWJvdXQgdGhlIGFkZHJlc3MgbWFwcGluZywg
aW5jbHVkaW5nDQonI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIGFuZCAncmFuZ2VzJw0K
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjN+djU6
IG5vIGNoYW5nZXMNCg0KdjI6IGFkZCBSZXZpZXdlZC1ieSBSb2INCi0tLQ0KIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dCB8IDEwICsrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRl
eCBhODU5YjBkYjQwNTEuLmRkNzViNjc2YjcxZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtMTQsNiAr
MTQsMTYgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFyZW50KSBub2RlKToN
CiAJCSAgbWFrZSB1c2Ugb2YgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSIgb24gbXQyNzAxIGlu
c3RlYWQgYW5kDQogCQkgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiIG9uIG10MjcxMiBpbnN0
ZWFkLg0KIA0KKy0gI2FkZHJlc3MtY2VsbHM6CXRoZSBudW1iZXIgb2YgY2VsbHMgdXNlZCB0byBy
ZXByZXNlbnQgcGh5c2ljYWwNCisJCWJhc2UgYWRkcmVzc2VzLg0KKy0gI3NpemUtY2VsbHM6CXRo
ZSBudW1iZXIgb2YgY2VsbHMgdXNlZCB0byByZXByZXNlbnQgdGhlIHNpemUgb2YgYW4gYWRkcmVz
cy4NCistIHJhbmdlczoJdGhlIGFkZHJlc3MgbWFwcGluZyByZWxhdGlvbnNoaXAgdG8gdGhlIHBh
cmVudCwgZGVmaW5lZCB3aXRoDQorCQktIGVtcHR5IHZhbHVlOiBpZiBvcHRpb25hbCAncmVnJyBp
cyB1c2VkLg0KKwkJLSBub24tZW1wdHkgdmFsdWU6IGlmIG9wdGlvbmFsICdyZWcnIGlzIG5vdCB1
c2VkLiBzaG91bGQgc2V0DQorCQkJdGhlIGNoaWxkJ3MgYmFzZSBhZGRyZXNzIHRvIDAsIHRoZSBw
aHlzaWNhbCBhZGRyZXNzDQorCQkJd2l0aGluIHBhcmVudCdzIGFkZHJlc3Mgc3BhY2UsIGFuZCB0
aGUgbGVuZ3RoIG9mDQorCQkJdGhlIGFkZHJlc3MgbWFwLg0KKw0KIFJlcXVpcmVkIG5vZGVzCTog
YSBzdWItbm9kZSBpcyByZXF1aXJlZCBmb3IgZWFjaCBwb3J0IHRoZSBjb250cm9sbGVyDQogCQkg
IHByb3ZpZGVzLiBBZGRyZXNzIHJhbmdlIGluZm9ybWF0aW9uIGluY2x1ZGluZyB0aGUgdXN1YWwN
CiAJCSAgJ3JlZycgcHJvcGVydHkgaXMgdXNlZCBpbnNpZGUgdGhlc2Ugbm9kZXMgdG8gZGVzY3Jp
YmUNCi0tIA0KMi4yNS4wDQo=

