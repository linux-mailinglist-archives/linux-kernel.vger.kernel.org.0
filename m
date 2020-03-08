Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED0E17D218
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 07:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCHGtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 01:49:52 -0500
Received: from mailgw01.mediatek.com ([216.200.240.184]:38115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCHGtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 01:49:52 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2020 01:49:52 EST
X-UUID: 8a60eed25dd843f99706394371675ac0-20200307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=amPnNjmjefQsyk5bkPNYdHvxBnqS5HcVAeBUw7OCcuY=;
        b=Ax2DXZTx9qOU0YVK64+DxYjQUgqiu5d8juThM7utccukdRnzfKT5jkACsIE29Qds6UArdWVk6pp3vnSEXP7yMJpWMVVWTms67vHtrtw+G0lKPZ8K+ldmZFyqQPUfowkrzvaj7sYtWYCxy9GCILk22PXWx9clUO591cAknpOev7U=;
X-UUID: 8a60eed25dd843f99706394371675ac0-20200307
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 117259514; Sat, 07 Mar 2020 22:44:42 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 7 Mar 2020 22:34:40 -0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 14:34:38 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <john@phrozen.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] arm: dts: mt7623: add phy-mode property for gmac2
Date:   Sun, 8 Mar 2020 14:34:37 +0800
Message-ID: <70e3eff31ecd500ed4862d9de28325a4dbd15105.1583648927.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpBZGQgcGh5LW1vZGUg
cHJvcGVydHkgcmVxdWlyZWQgYnkgcGh5bGluayBvbiBnbWFjMg0KDQpGaXhlczogYjhmYzlmMzA4
MjFlICgibmV0OiBldGhlcm5ldDogbWVkaWF0ZWs6IEFkZCBiYXNpYyBQSFlMSU5LIHN1cHBvcnQi
KQ0KU2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0t
DQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi1yZmItZW1tYy5kdHMgfCAxICsNCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L210NzYyM24tcmZiLWVtbWMuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi1yZmItZW1t
Yy5kdHMNCmluZGV4IGI3NjA2MTMwYWRlOS4uMDQ0Nzc0OGY5ZmEwIDEwMDY0NA0KLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi1yZmItZW1tYy5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL210NzYyM24tcmZiLWVtbWMuZHRzDQpAQCAtMTM4LDYgKzEzOCw3IEBAIGZpeGVkLWxpbmsg
ew0KIAltYWNAMSB7DQogCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLGV0aC1tYWMiOw0KIAkJcmVn
ID0gPDE+Ow0KKwkJcGh5LW1vZGUgPSAicmdtaWkiOw0KIAkJcGh5LWhhbmRsZSA9IDwmcGh5NT47
DQogCX07DQogDQotLSANCjIuMjUuMQ0K

