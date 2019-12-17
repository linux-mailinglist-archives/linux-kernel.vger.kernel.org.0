Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC42122CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfLQNRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 08:17:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3873 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbfLQNRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:17:01 -0500
X-UUID: 0713f54e692d49e39fe00badcde6bed5-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=U0vU+LIZLIDQVGTtq7rkZrJ2CEwoWECUcbI4MOvmIQk=;
        b=mbrzBAE+dtlGeeUtRqeJyBOsRDaiIEJL8vglradYzhEo+Ne7u+WUL+1mIz/zq2pnxYSh0w9EToa6A4j1WuTZb/4yrJAyVeKu5Osi3UtIgm9tyGDda59WuPiSPNO47zj8Rtfo1jlmQ7TYSahKUtPU0YWfjmq2rGPiY/UxgFz17mM=;
X-UUID: 0713f54e692d49e39fe00badcde6bed5-20191217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 338058259; Tue, 17 Dec 2019 21:16:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 17 Dec 2019 21:16:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Dec 2019 21:16:31 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [v2,0/1] Add mt7629 pwm support
Date:   Tue, 17 Dec 2019 21:16:52 +0800
Message-ID: <1576588613-11530-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHB3bSBzdXBwb3J0IGZvciBNVDc2MjkuDQoNCkNoYW5nZSBzaW5jZSB2MToNCnJl
bW92ZSB1bnVzZWQgcHJvcGVydHkgbnVtLXB3bQ0KDQpVc2VkOg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMTE2MDg1MS8NCg0KUmVsYXRlZCBkZXBlbmRlbnQgZHJpdmVyIHVw
ZGF0ZXMgaGF2ZSBiZWVuIG1lcmdlZCBpbnRvIG1haW50YWluZXIncyBrZXJuZWwNCnNvdXJjZSB0
cmVlLg0KDQoNClNhbSBTaGloICgxKToNCiAgYXJtOiBkdHM6IG1lZGlhdGVrOiBhZGQgbXQ3NjI5
IHB3bSBzdXBwb3J0DQoNCiBhcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaSB8IDE0ICsrKysr
KysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCg0KLS0gDQoyLjE3
LjENCg==

