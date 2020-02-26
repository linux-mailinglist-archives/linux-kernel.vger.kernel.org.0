Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEE16F76A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBZFfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:35:16 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:60749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgBZFfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:35:15 -0500
X-UUID: acd367779a0b457ea034396ab21f7311-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C+alJd8SySA09GfW2zJ8YtQVLjjTVb/Bs9/MLtrlNkc=;
        b=Lj4miGoL8WRhYNF7TU0lHE3yxdxuRZZOxRv3HpZ7TJfUmeO0UVENggSXST1XEBXq35VIPnBXi8cH1lwbZa0gSEbfbQg+FKHmvkT63jxlrrGk+n1HpwSf61xLyp3Ne3ehl1+nCEfSRaFUSrO2U+y7Gb2Xcc5Z3F0nAAFg1vCV6Hc=;
X-UUID: acd367779a0b457ea034396ab21f7311-20200226
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 342425320; Wed, 26 Feb 2020 13:32:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Feb
 2020 13:33:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Feb 2020 13:31:25 +0800
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
Subject: [PATCH v9 3/5] dt-bindings: display: mediatek: dpi sample data in dual edge support
Date:   Wed, 26 Feb 2020 13:32:36 +0800
Message-ID: <20200226053238.31646-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226053238.31646-1-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5400F7844E94B32A68983448F56EE6FB8608AD2B8247DA0C509CB1BF81ADC9342000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkgc2FtcGxlIG9uIGZh
bGxpbmcgKDApLA0KcmlzaW5nICgxKSwgYm90aCBmYWxsaW5nIGFuZCByaXNpbmcgKDIpLg0KDQpT
aWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQg
ICAgICAgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IGE3YjFiOGJmYjY1ZS4uNDI5OWFh
MWFkZjQ1IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTIw
LDYgKzIwLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
IC0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZ3Bpb21vZGUiIGFuZCAiZHBpbW9kZSIuDQogICBw
aW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3Ry
bHBpbmN0cmwtYmluZGluZ3MudHh0DQorLSBwY2xrLXNhbXBsZTogcmVmZXIgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0Lg0KIA0KIEV4
YW1wbGU6DQogDQpAQCAtMzcsNiArMzgsNyBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KIA0KIAlw
b3J0IHsNCiAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQorCQkJcGNsay1zYW1wbGUgPSAwOw0KIAkJ
CXJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KIAkJfTsNCiAJfTsNCi0tIA0KMi4yMS4w
DQo=

