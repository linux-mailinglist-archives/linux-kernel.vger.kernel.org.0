Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF416098E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 05:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBQENb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 23:13:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15786 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbgBQENY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:13:24 -0500
X-UUID: 151dcd04cad844bd8910d0ff92e71cac-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=feYX8zW0ZWQoMc1W0bskoB216n7Lm1ZtbWluuzSZ8/c=;
        b=c5eB6geemx5rucAtqpPHKbuhGBy04WpPRoCuL0nAYpLXXx/qrCohn8YdKYRzFCk+jzAVNGzOutQCvE4opaFTX+yZYcogs9rPu1phns9PNhOJc+T6YW3wFOYHeIxgGidXwbMEF60upAIVFYLXLASKNJhmRbYPnLVEyg5f79SLR2k=;
X-UUID: 151dcd04cad844bd8910d0ff92e71cac-20200217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 975314321; Mon, 17 Feb 2020 12:13:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 12:12:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 12:13:05 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH v2 4/4] [4/4] dt-bindings: mmc: mediatek: Add document for mt6779
Date:   Mon, 17 Feb 2020 12:13:10 +0800
Message-ID: <1581912790-19382-5-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581912790-19382-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1581912790-19382-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNvbXBhdGlibGUgbm9kZSBmb3IgbXQ2Nzc5IG1tYw0KDQpDaGFuZ2UtSWQ6IElkMzZhMTM2
YTc1ZTg5MmM5MzYwZWM5NWM3ZjUyZGIwNmY1YjMwOGE0DQpDUi1JZDoNCkZlYXR1cmU6DQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuLUh1bmcgV3UgPGNodW4taHVuZy53dUBtZWRpYXRlay5jb20+DQotLS0N
CiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQgfCAxICsN
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dA0KaW5kZXggOGE1MzJmNC4uMGM5Y2Y2
YSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGst
c2QudHh0DQpAQCAtMTIsNiArMTIsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAkibWVkaWF0
ZWssbXQ4MTczLW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTczDQog
CSJtZWRpYXRlayxtdDgxODMtbW1jIjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBt
dDgxODMNCiAJIm1lZGlhdGVrLG10ODUxNi1tbWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJs
ZSB3aXRoIG10ODUxNg0KKwkibWVkaWF0ZWssbXQ2Nzc5LW1tYyI6IGZvciBtbWMgaG9zdCBpcCBj
b21wYXRpYmxlIHdpdGggbXQ2Nzc5DQogCSJtZWRpYXRlayxtdDI3MDEtbW1jIjogZm9yIG1tYyBo
b3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDI3MDENCiAJIm1lZGlhdGVrLG10MjcxMi1tbWMiOiBm
b3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10MjcxMg0KIAkibWVkaWF0ZWssbXQ3NjIy
LW1tYyI6IGZvciBNVDc2MjIgU29DDQotLSANCjEuOS4xDQo=

