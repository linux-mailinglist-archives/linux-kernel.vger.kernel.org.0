Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7AF117F60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 06:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJFFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 00:05:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25163 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726739AbfLJFFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:05:35 -0500
X-UUID: 0c9d82d0eccf4322beeb320fa2a49a4a-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IK4gWXtcGlr7PmGqenQ/QPAyzQiJMHQsa+snS0lUQJY=;
        b=cGhJkoWc2USqEJxGGwqOGlz0vYGIWXLGjRq4fub+lXT6xptm9zikQDYFDnNNUftJ9gZQBtt+BDlLyWv+SU/ywGWFSxBf+3IR82xjovDbckK8/0AkCl807oLrkNIlmkDaJh5ascaP3xOJsbG6zhJkbKLUDWrtlsg+gsJdGIyt9Dk=;
X-UUID: 0c9d82d0eccf4322beeb320fa2a49a4a-20191210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2097352641; Tue, 10 Dec 2019 13:05:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 13:05:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 13:05:22 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v5 4/7] drm/mediatek: disable all the planes in atomic_disable
Date:   Tue, 10 Dec 2019 13:05:23 +0800
Message-ID: <20191210050526.4437-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VW5kZXIgc2hhZG93IHJlZ2lzdGVyIGNhc2UsIHdlIGRvIG5vdCBkaXNhYmxlIGFsbCB0aGUgcGxh
bmUgYmVmb3JlDQpkaXNhYmxlIGFsbCB0aGUgaGFyZHdhcmVzLiBGaXggaXQuDQoNCkZpeGVzOiA5
ZGM4NGU5OGEzMWYgKCJkcm0vbWVkaWF0ZWs6IGFkZCBzaGFkb3cgcmVnaXN0ZXIgc3VwcG9ydCIp
DQoNClNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+
DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpp
bmRleCBiNzcxZWUwNTk2OGIuLmFkZjA3MmZiNGFlMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNTQ3LDYgKzU0Nyw3IEBAIHN0YXRpYyB2b2lkIG10a19k
cm1fY3J0Y19hdG9taWNfZGlzYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogCX0NCiAJbXRr
X2NydGMtPnBlbmRpbmdfcGxhbmVzID0gdHJ1ZTsNCiANCisJbXRrX2RybV9jcnRjX2h3X2NvbmZp
ZyhtdGtfY3J0Yyk7DQogCS8qIFdhaXQgZm9yIHBsYW5lcyB0byBiZSBkaXNhYmxlZCAqLw0KIAlk
cm1fY3J0Y193YWl0X29uZV92YmxhbmsoY3J0Yyk7DQogDQotLSANCjIuMTguMA0K

