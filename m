Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189121788FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 04:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgCDDM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 22:12:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38104 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbgCDDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:12:27 -0500
X-UUID: 51ce0c828caa4f2a967070d0ecd4d841-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ms2wWqOqtGBB8GyMpY5bqE7MNpxudDVwWEf/7/Mb/Dg=;
        b=GsivpPa1gd+n9L+zvhxhuDHEZPzzY6VfrVZF4NlkkEpgwzJeCa3vmR7qD6KeaMtxWV9RseYD9f/0vyb8ZDH1+nLLf2IxqEMxn9urKSb1s3uuW5011XVpoZNkOEuj/I/1M17DbJmicgd42X7yw3s6y23CxHZF0g2yc/tGa50KRRY=;
X-UUID: 51ce0c828caa4f2a967070d0ecd4d841-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1005341639; Wed, 04 Mar 2020 11:12:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:09:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 11:09:47 +0800
From:   <light.hsieh@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuohong.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Subject: [RESEND PATCH v1 0/3] set ro attribute of block device according to write-protection status
Date:   Wed, 4 Mar 2020 11:12:14 +0800
Message-ID: <1583291537-15053-1-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 258F618788D8BD34AD63C33AFEEC9AB93F696BD063FC16ED2CD906E508FB6E5F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlnaHQgSHNpZWggPGxpZ2h0LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KICBzZXQgcm8g
YXR0cmlidXRlIG9mIGJsb2NrIGRldmljZSBhY2NvcmRpbmcgdG8gd3JpdGUtcHJvdGVjdGlvbiBz
dGF0dXMNCg0KTGlnaHQgSHNpZWggKDMpOg0KICBtbWM6IHJlY29yZCB3cF9ncnBfc2l6ZSBhbmQg
Ym9vdF93cF9zdGF0dXMNCiAgbW1jOiBjaGVjayB3cml0ZS1wcm90ZWN0aW9uIHN0YXR1cyBkdXJp
bmcgQkxLUk9TRVQgaW9jdGwNCiAgYmxvY2s6IHNldCBwYXJ0aXRpb24gcmVhZC93cml0ZSBwb2xp
Y3kgYWNjb3JkaW5nIHRvIHdyaXRlLXByb3RlY3Rpb24NCiAgICBzdGF0dXMNCg0KIGJsb2NrL2lv
Y3RsLmMgICAgICAgICAgICAgfCAgIDIgKy0NCiBibG9jay9wYXJ0aXRpb24tZ2VuZXJpYy5jIHwg
IDEwICsrKw0KIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyAgfCAyMTcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMg
ICAgfCAgMTYgKysrKw0KIGluY2x1ZGUvbGludXgvYmxrZGV2LmggICAgfCAgIDEgKw0KIGluY2x1
ZGUvbGludXgvbW1jL2NhcmQuaCAgfCAgIDMgKw0KIGluY2x1ZGUvbGludXgvbW1jL21tYy5oICAg
fCAgIDIgKw0KIDcgZmlsZXMgY2hhbmdlZCwgMjUwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCg0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

