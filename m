Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B14198E57
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgCaI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 04:28:16 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:10921 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730106AbgCaI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:14 -0400
X-UUID: 19d6c108d34f40ab864139469fd91c52-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5o+60Ykpu4QaOR8sM8BtdowpYIMKFLDI/axtPlIoxEU=;
        b=vDkn68gXSEj0djHm+u5Qh7q/2wO0ACEIP4iBaScwqfEYARDgDuIPFivoNBJgKYhqfp9/m3puOeptMuc+RIi6RIXceTCr+ch6oTUQghha+E37vVe/WT89mEQRZglhypJvCBHRwqQrhSotHNwiqga5wYNwusao6b3XkwXDrmIjnO0=;
X-UUID: 19d6c108d34f40ab864139469fd91c52-20200331
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 991516779; Tue, 31 Mar 2020 16:27:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 16:27:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 31 Mar 2020 16:27:52 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 0/4] Config mipi tx current and impedance
Date:   Tue, 31 Mar 2020 16:27:21 +0800
Message-ID: <20200331082725.81048-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 765C563F980AD3CE409FCDB0899B9382D2D47E9FF25AA5CE15BD52FF03A4E3272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MzoNCiAtIHJlZmluZSBkcml2ZS1zdHJlbmd0aC1taWNyb2FtcCBhcyBm
cm9tIDMwMDAgdG8gNjAwMC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIGZpeCB0aGUgdGl0bGUg
b2YgY29tbWl0IG1lc3NhZ2UuDQogLSByZW5hbWUgbWlwaXR4LWN1cnJlbnQtZHJpdmUgdG8gZHJp
dmUtc3RyZW5ndGgtbWljcm9hbXANCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIGZpeCBjb2Rpbmcg
c3R5bGUuDQogLSBjaGFuZ2UgbXRrX21pcGlfdHhfY29uZmlnX2NhbGlicmF0aW9uX2RhdGEoKSB0
byB2b2lkDQoNCkppdGFvIFNoaSAoNCk6DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRl
azogYWRkIHByb3BlcnR5IHRvIGNvbnRyb2wgbWlwaSB0eCBkcml2ZQ0KICAgIGN1cnJlbnQNCiAg
ZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBnZXQgbWlwaXR4IGNhbGlicmF0aW9uIGRh
dGEgZnJvbSBudm1lbQ0KICBkcm0vbWVkaWF0ZWs6IGFkZCB0aGUgbWlwaXR4IGRyaXZpbmcgY29u
dHJvbA0KICBkcm0vbWVkaWF0ZWs6IGNvbmZpZyBtaXBpdHggaW1wZWRhbmNlIHdpdGggY2FsaWJy
YXRpb24gZGF0YQ0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAg
ICAgIHwgMTAgKysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgICAg
ICAgIHwgMTQgKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oICAg
ICAgICB8ICAxICsNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4
LmMgfCA2NCArKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRp
b25zKCspDQoNCi0tIA0KMi4yMS4wDQo=

