Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDC159F19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 03:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBLCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 21:35:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26515 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727535AbgBLCf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:35:57 -0500
X-UUID: 98dc227d23ee404abdc8607fa4f21b0f-20200212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=steg/jhASvVNwtaBUkvukNOa1G0B8v/8ufnbMNN4fNM=;
        b=UUE9RGU5gpuy8uWkfsxX8HZ8J7BVWiaAR9gKz+EdDcWyCSlcv4vxQe0PaIIgbCSftJc3x20Mhc5RdxZqwq2NG1oBXRmxTM9rC7zAn9aa1VDj/bNU+HbDdyj8NAvKBDrFy/yplJ26Z+Esb3R9juV8OKJq4ZnTTZIx5mS7a4Qe6cw=;
X-UUID: 98dc227d23ee404abdc8607fa4f21b0f-20200212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 587823013; Wed, 12 Feb 2020 10:35:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Feb 2020 10:34:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Feb 2020 10:34:48 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [RESEND,v2,0/1] Add mt7629 pwm support
Date:   Wed, 12 Feb 2020 10:35:25 +0800
Message-ID: <1581474926-28633-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBnZW50bGUgcGluZyBvbiB0aGlzIHdob2xlIHBhdGNoIHNlcmllcw0KDQpUaGlzIGFkZHMgcHdt
IHN1cHBvcnQgZm9yIE1UNzYyOS4NCg0KQ2hhbmdlIHNpbmNlIHYxOg0KcmVtb3ZlIHVudXNlZCBw
cm9wZXJ0eSBudW0tcHdtDQoNClVzZWQ6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzExMTYwODUxLw0KDQpSZWxhdGVkIGRlcGVuZGVudCBkcml2ZXIgdXBkYXRlcyBoYXZlIGJl
ZW4gbWVyZ2VkIGludG8gbWFpbnRhaW5lcidzIGtlcm5lbA0Kc291cmNlIHRyZWUuDQoNCg0KU2Ft
IFNoaWggKDEpOg0KICBhcm06IGR0czogbWVkaWF0ZWs6IGFkZCBtdDc2MjkgcHdtIHN1cHBvcnQN
Cg0KIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpIHwgMTQgKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMTcuMQ0K

