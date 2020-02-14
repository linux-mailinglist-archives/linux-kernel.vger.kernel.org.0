Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8C15D13B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 05:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgBNEuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 23:50:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:16603 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728239AbgBNEuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:50:05 -0500
X-UUID: 572ec62ff9b94ce7898416d56bb2f441-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=os5KCgWF6A0fLJJLfDvO49SGJNON7eejfxhvN78nWGs=;
        b=qrEqsyTXSX3k1sKRs4pjQK1/7XNbCOS0w0pvEKxv/GNg4srcK7UEuNocgDqnTbO/ndHnHZXrdgt4BOdudFMc2TKvRhdSYpyb00ZkuEjC2JjNbMlpmCupvZmrg4mlyjo4eT6tDhRugl1sSxdqi9qH1Up94YbiWis2KRp1YKoiyNY=;
X-UUID: 572ec62ff9b94ce7898416d56bb2f441-20200214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1145880752; Fri, 14 Feb 2020 12:49:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:49:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:49:56 +0800
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
Subject: [PATCH 3/3] drm/mediatek: move gce event property to mutex device node
Date:   Fri, 14 Feb 2020 12:49:54 +0800
Message-ID: <20200214044954.16923-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
References: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIG10ayBoYXJkd2FyZSBkZXNpZ24sIHN0cmVhbV9kb25lMCBhbmQgc3RyZWFtX2Rv
bmUxIGFyZQ0KZ2VuZXJhdGVkIGJ5IG11dGV4LCBzbyB3ZSBtb3ZlIGdjZSBldmVudCBwcm9wZXJ0
eSB0byBtdXRleCBkZXZpY2UgbW9kZS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJp
YmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5k
ZXggZTM1YjY2YzViYTBmLi5lMWNjNzcwM2EzMTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KQEAgLTgyMCw3ICs4MjAsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2Ny
ZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCiAJCQlkcm1fY3J0Y19pbmRleCgmbXRr
X2NydGMtPmJhc2UpKTsNCiAJCW10a19jcnRjLT5jbWRxX2NsaWVudCA9IE5VTEw7DQogCX0NCi0J
cmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWss
Z2NlLWV2ZW50cyIsDQorCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KHByaXYtPm11
dGV4X25vZGUsICJtZWRpYXRlayxnY2UtZXZlbnRzIiwNCiAJCQkJCSBkcm1fY3J0Y19pbmRleCgm
bXRrX2NydGMtPmJhc2UpLA0KIAkJCQkJICZtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQogCWlmIChy
ZXQpDQotLSANCjIuMTguMA0K

