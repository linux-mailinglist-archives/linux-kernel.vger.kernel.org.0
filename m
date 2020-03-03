Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65913176EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 06:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCCF2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 00:28:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgCCF2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:28:12 -0500
X-UUID: 73f8a5e49bfe4f10847b61f6964efd72-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VrGM0yng3zE6ibYl4KMQlVLDnOBJXUKNw3E1HJFiQo4=;
        b=b5vKKQD6VM6XzABQ1pX2UIsve9W8vFurHj9cqxcyE25vmyXOGQXmk8CfCyKyQTfcw3ZyV3OrQumAds0GE44lp3jfzsQZpq/g15jtnMV3jfoYRwj8KM6IVkjujyIq8KkpKDOjdUfJ+2qM4pfavW1O9SGsmowEoj+Mb+9Q4JVUtx0=;
X-UUID: 73f8a5e49bfe4f10847b61f6964efd72-20200303
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1728220448; Tue, 03 Mar 2020 13:27:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:28:06 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:07 +0800
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
Subject: [PATCH v12 0/6] mt8183 dpi supports dual edge and pin mode swap
Date:   Tue, 3 Mar 2020 13:27:16 +0800
Message-ID: <20200303052722.94795-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C50C8E93721BCC28BF2C5FB574BD8F7FED538630EACC9D503EDD5790C96266982000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHNpbmNlIHYxMToNCiAtIGZpbmUgdHVuZSBtZWRpYXRlayxkcGkueWFtbC4NCiAtIGFk
ZCBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4uDQoNCkNoYW5nZSBzaW5j
ZSB2MTA6DQogLSBjb252ZXJ0IHRoZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQogICB0byB5YW1sIGZvcm1hdC4NCiAt
IHJlYWQgdGhlIHBjbGstc2FtcGxlIGluIGVuZHBvaW50Lg0KDQpDaGFuZ2VzIHNpbmNlIHY5Og0K
IC0gcmVuYW1lIHBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUiLCAiZHBpbW9kZSIgdG8gImFjdGl2
ZSIsICJpZGxlIi4NCiAtIGZpeCBzb21lIHR5cG8uDQoNCkNoYW5nZXMgc2luY2Ugdjg6DQogLSBk
cm9wIHBjbGstc2FtcGxlIHJlZGVmaW5lIGluIG1lZGlhdGVrLGRwaS50eHQNCiAtIG9ubHkgZ2V0
IHRoZSBncGlvbW9kZSBhbmQgZHBpbW9kZSB3aGVuIGRwaS0+cGluY3RybCBpcyBzdWNjZXNzZnVs
Lg0KDQpDaGFuZ2VzIHNpbmNlIHY3Og0KIC0gc2VwYXJhdGUgZHQtYmluZGluZ3MgdG8gaW5kZXBl
bmRlbnQgcGF0Y2hlcy4NCiAtIG1vdmUgZHBpIGR1YWwgZWRnZSB0byBvbmUgcGF0Y2guDQoNCkNo
YW5nZXMgc2luY2UgdjY6DQogLSBjaGFuZ2UgZHVhbF9lZGdlIHRvIHBjbGstc2FtcGxlDQogLSBy
ZW1vdmUgZHBpX3Bpbl9tb2RlX3N3YXAgYW5kDQoNCkNoYW5nZXMgc2luY2UgdjU6DQogLSBmaW5l
IHR1bmUgdGhlIGR0LWJpbmRpbmdzIGNvbW1pdCBtZXNzYWdlLg0KDQpDaGFuZ2VzIHNpbmNlIHY0
Og0KIC0gbW92ZSBwaW4gbW9kZSBjb250cm9sIGFuZCBkdWFsIGVkZ2UgY29udHJvbCB0byBkZXZl
aWNlIHRyZWUuDQogLSB1cGRhdGUgZHQtYmluZGluZ3MgZG9jdW1lbnQgZm9yIHBpbiBtb2RlIHN3
YXAgYW5kIGR1YWwgZWRnZSBjb250cm9sLg0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KIC0gYWRkIGRw
aSBwaW4gbW9kZSBjb250cm9sIHdoZW4gZHBpIG9uIG9yIG9mZi4NCiAtIHVwZGF0ZSBkcGkgZHVh
bCBlZGdlIGNvbW1lbnQuDQoNCkNoYW5nZXMgc2luY2UgdjI6DQogLSB1cGRhdGUgZHQtYmluZGlu
Z3MgZG9jdW1lbnQgZm9yIG10ODE4MyBkcGkuDQogLSBzZXBhcmF0ZSBkdWFsIGVkZ2UgbW9kZmlj
YXRpb24gYXMgaW5kZXBlbmRlbnQgcGF0Y2guDQoNCkppdGFvIFNoaSAoNik6DQogIGR0LWJpbmRp
bmdzOiBtZWRpYTogYWRkIHBjbGstc2FtcGxlIGR1YWwgZWRnZSBwcm9wZXJ0eQ0KICBkdC1iaW5k
aW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGNvbnRyb2wgZHBpIHBpbnMgbW9kZSB0byBhdm9pZCBs
ZWFrYWdlDQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazogZHBpIHNhbXBsZSBkYXRh
IGluIGR1YWwgZWRnZSBzdXBwb3J0DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazog
Y29udmVydCB0aGUgZG9jdW1lbnQgZm9ybWF0IGZyb20gdHh0DQogICAgdG8geWFtbA0KICBkcm0v
bWVkaWF0ZWs6IGRwaSBzYW1wbGUgbW9kZSBzdXBwb3J0DQogIGRybS9tZWRpYXRlazogc2V0IGRw
aSBwaW4gbW9kZSB0byBncGlvIGxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQNCg0KIC4uLi9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAgICAgICB8IDM2IC0tLS0tLS0tDQog
Li4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgICAgICAgIHwgOTIgKysrKysr
KysrKysrKysrKysrKw0KIC4uLi9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dCAg
ICAgICB8ICA0ICstDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgICAg
ICAgIHwgNTggKysrKysrKysrKystDQogNCBmaWxlcyBjaGFuZ2VkLCAxNTAgaW5zZXJ0aW9ucygr
KSwgNDAgZGVsZXRpb25zKC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwNCg0KLS0gDQoyLjIxLjANCg==

