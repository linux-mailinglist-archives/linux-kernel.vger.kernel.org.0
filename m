Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECACC16BFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgBYLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 06:53:06 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:28900 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729976AbgBYLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:53:05 -0500
X-UUID: aa67ac5ae26f4ba2b599abbbc8d65009-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=39ui2Wv99GeSAlafK/9HYk45gaD1Wuxeozd4Opspg4c=;
        b=Zcb+sFn7eztRNcILpfmwWXSazfCYE4Hus6AKWm1782CYimlDTwsEc2saoZP7Jqes3qFaTEgEfAU3xl2EBO083brcXHJ0lkF4vZAGYvgyxdiaIyJQK6hR33fQyL6CbUQJQ10w6XvhMZBgRLGCnip+/S1d4+M68aA+al0T+cCuepI=;
X-UUID: aa67ac5ae26f4ba2b599abbbc8d65009-20200225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 777796048; Tue, 25 Feb 2020 19:47:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 19:43:44 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 19:46:19 +0800
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
Subject: [PATCH v2 2/4] dt-binds: display: mediatek: get mipitx calibration data from nvmem
Date:   Tue, 25 Feb 2020 19:47:28 +0800
Message-ID: <20200225114730.124939-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225114730.124939-1-jitao.shi@mediatek.com>
References: <20200225114730.124939-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CE2C1B199D80B5DA7756133ED194042CE19C7AAF0C02D93751A82EB184EDC9BD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnRpZXMgdG8gZ2V0IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YS4NCg0KU2ln
bmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0ICAg
IHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGRzaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQppbmRleCA3ODAyMDFkZGNkNWMuLjdmMTJlYjcy
OTc5MSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQNCkBAIC0zNCw2
ICszNCw5IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSAjcGh5LWNlbGxzOiBtdXN0IGJlIDww
Pi4NCiANCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRsZSB0
byB0aGUgY2FsaWJyYXRpb24gZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4gSWYNCisg
ICAgICAgICAgICAgICB1bnNwZWNpZmllZCBkZWZhdWx0IHZhbHVlcyBzaGFsbCBiZSB1c2VkLg0K
Ky0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJjYWxpYnJhdGlvbi1kYXRhIg0KIC0gbWlw
aXR4LWN1cnJlbnQtZHJpdmU6IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAxIH4g
MHhGDQogDQogRXhhbXBsZToNCkBAIC00NSw2ICs0OCw4IEBAIG1pcGlfdHgwOiBtaXBpLWRwaHlA
MTAyMTUwMDAgew0KIAljbG9jay1vdXRwdXQtbmFtZXMgPSAibWlwaV90eDBfcGxsIjsNCiAJI2Ns
b2NrLWNlbGxzID0gPDA+Ow0KIAkjcGh5LWNlbGxzID0gPDA+Ow0KKwludm1lbS1jZWxscz0gPCZt
aXBpX3R4X2NhbGlicmF0aW9uPjsNCisJbnZtZW0tY2VsbC1uYW1lcyA9ICJjYWxpYnJhdGlvbi1k
YXRhIjsNCiAJbWlwaXR4LWN1cnJlbnQtZHJpdmUgPSA8MHg4PjsNCiB9Ow0KIA0KLS0gDQoyLjIx
LjANCg==

