Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6918122E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgCKHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:41:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728408AbgCKHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:56 -0400
X-UUID: c3db92029253409ab9606dc55780707f-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kmuKx8yXnrVZRj26G1wT2tuW6nPEGkF1XeVUsCNtoWg=;
        b=kshX+c6dHL/AB3e7H0xyPP/tvUkeBy3YvwTu+9VZisgDrQl4vlVDDHLmMVhd/EYcc1ENJT5wyHv+daO1zWHMeLYYzX0NUPtJS9L/6OPKcmSh8D1mxAHTxS559r+aqGcrdXRxliIGVMmB3tJtQMrt0q7LnytmDjt8bcP6wnwm8l4=;
X-UUID: c3db92029253409ab9606dc55780707f-20200311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1501939638; Wed, 11 Mar 2020 15:40:52 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:41:10 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:42:00 +0800
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
Subject: [PATCH v3 0/4] Config mipi tx drive current and impedance
Date:   Wed, 11 Mar 2020 15:40:28 +0800
Message-ID: <20200311074032.119481-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8B87C366A05019574894C8BE919C0DEE41E6FDE2156CBE9411D871362E6DA08A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MjoNCiAtIGZpeCB0aGUgdGl0bGUgb2YgY29tbWl0IG1lc3NhZ2UuDQog
LSByZW5hbWUgbWlwaXR4LWN1cnJlbnQtZHJpdmUgdG8gZHJpdmUtc3RyZW5ndGgtbWljcm9hbXAN
Cg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIGZpeCBjb2Rpbmcgc3R5bGUuDQogLSBjaGFuZ2UgbXRr
X21pcGlfdHhfY29uZmlnX2NhbGlicmF0aW9uX2RhdGEoKSB0byB2b2lkDQoNCkppdGFvIFNoaSAo
NCk6DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazogYWRkIHByb3BlcnR5IHRvIGNv
bnRyb2wgbWlwaSB0eCBkcml2ZQ0KICAgIGN1cnJlbnQNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6
IG1lZGlhdGVrOiBnZXQgbWlwaXR4IGNhbGlicmF0aW9uIGRhdGEgZnJvbSBudm1lbQ0KICBkcm0v
bWVkaWF0ZWs6IGFkZCB0aGUgbWlwaXR4IGRyaXZpbmcgY29udHJvbA0KICBkcm0vbWVkaWF0ZWs6
IGNvbmZpZyBtaXBpdHggaW1wZWRhbmNlIHdpdGggY2FsaWJyYXRpb24gZGF0YQ0KDQogLi4uL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgICAgIHwgIDkgKysrDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgICAgICAgIHwgIDYgKysNCiBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguaCAgICAgICAgfCAgMSArDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jIHwgNjQgKysrKysrKysrKysrKysr
KysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMjEuMA0K

