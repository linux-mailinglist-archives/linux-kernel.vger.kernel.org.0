Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C63F6CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 03:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKCal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 21:30:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbfKKCal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:30:41 -0500
X-UUID: 2cd0888dcdfe46839709c1a7c88ddaaa-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jHHmqzNubR6Ei6BpDLjgBGHkGAoO17EffQ+vZ8QstxA=;
        b=B667+f/fRpQJ+JkLbdjoQhyPbNJzjR4v/prq/sKzijeryJ/KuCfzw9Gpqx+OsDWyb5E72sRgEktOHZeE8EIdl/XtyB6dflXMPWNu7QeeO4D7IJBaghQuo5rMhGviTiv8i8V2UM7w4ws8bscd2eyH9XLPdVICJuI/bPVwMZBbBOU=;
X-UUID: 2cd0888dcdfe46839709c1a7c88ddaaa-20191111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1677325310; Mon, 11 Nov 2019 10:30:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 10:30:32 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 10:30:30 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v2] soc: mediatek: add SMC fid table for SIP interface
Date:   Mon, 11 Nov 2019 10:30:01 +0800
Message-ID: <1573439402-16249-1-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c29jOiBtZWRpYXRlazogYWRkIFNNQyBmaWQgdGFibGUgZm9yIFNJUCBpbnRlcmZhY2UNCg0KMS4g
QWRkIGEgaGVhZGVyIGZpbGUgdG8gcHJvdmlkZSBTSVAgaW50ZXJmYWNlIHRvIEFURg0KICAgZm9y
IGNsaWVudHMsIHBsZWFzZSBkZWZpbmUgTVRLX1NJUF9YWFggIHdpdGggc3BlY2lmaWMgSUQNCg0K
Mi4gQWRkIEFVRElPIFNNQyBmaWQNCiAgIG10ayBzaXAgY2FsbCBleGFtcGxlOg0KICAgYXJtX3Nt
Y2NjX3NtYyhNVEtfU0lQX0FVRElPX0NPTlRST0wsDQogICAgICAgICAgICAgICAgIE1US19BVURJ
T19TTUNfT1BfRFJBTV9SRVFVRVNULA0KICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwLCAwLCAw
LCAmcmVzKQ0KDQoNCkVhc29uIFllbiAoMSk6DQogIHNvYzogbWVkaWF0ZWs6IGFkZCBTTUMgZmlk
IHRhYmxlIGZvciBTSVAgaW50ZXJmYWNlDQoNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGtfc2lwX3N2Yy5oIHwgICAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaA0K

