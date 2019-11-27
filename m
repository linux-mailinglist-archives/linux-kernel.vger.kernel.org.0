Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF910A84F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK0B7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:59:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbfK0B70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:26 -0500
X-UUID: b7d0b0f2814b462592b5a2f739da3d89-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=otgyjccjU3Jcg3ZFhBOHDV+FECv2mn5CGbV/nCdhKDk=;
        b=XPUS1bniIemDmYM8r3eQqqRdauoKfNHBaXgs9pplcvFMLg9M0QXz3dR4j1LwoKCeMJBN4K+oOp29CMsRPQ4W2u2aEVuk5Kvs/nM2rPxuLSsQm1qoJxwxEAqTPtN+YaQyNxOzv+msdXgs70l+BDYpyGbQTt+SnNvZL0xUZfcK2h0=;
X-UUID: b7d0b0f2814b462592b5a2f739da3d89-20191127
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2014605050; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:18 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 05/14] arm64: dts: add gce node for mt6779
Date:   Wed, 27 Nov 2019 09:58:48 +0800
Message-ID: <1574819937-6246-7-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGdjZSBkZXZpY2Ugbm9kZSBmb3IgbXQ2Nzc5DQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZ
QyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgfCAxMCArKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
Njc3OS5kdHNpDQppbmRleCBkYWEyNWI3NTc4OGYuLjEwZDU5Mzg1ZjRhMSAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kNCisrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kNCkBAIC04LDYgKzgsNyBAQA0KICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dj
ZS9tdDY3NzktZ2NlLmg+DQogDQogLyB7DQogCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5
IjsNCkBAIC0xNTksNiArMTYwLDE1IEBADQogCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KIAkJfTsN
CiANCisJCWdjZTogbWFpbGJveEAxMDIyODAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDY3NzktZ2NlIjsNCisJCQlyZWcgPSA8MCAweDEwMjI4MDAwIDAgMHg0MDAwPjsNCisJCQlp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgMTg1IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQkJI21ib3gt
Y2VsbHMgPSA8Mz47DQorCQkJY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfR0NFPjsN
CisJCQljbG9jay1uYW1lcyA9ICJnY2UiOw0KKwkJfTsNCisNCiAJCXVhcnQwOiBzZXJpYWxAMTEw
MDIwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LXVhcnQiLA0KIAkJCQkg
ICAgICJtZWRpYXRlayxtdDY1NzctdWFydCI7DQotLSANCjIuMTguMA0K

