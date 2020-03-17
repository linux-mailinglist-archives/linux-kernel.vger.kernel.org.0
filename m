Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE1886D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCQOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:07:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65061 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726801AbgCQOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:07:01 -0400
X-UUID: 9de378c7284d431fa4b40d7312af7db1-20200317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0n+EUTSUdOSSkaTkHUmDbzhJFVoxjbBJTb+B0M4gX+k=;
        b=GD3yhkeDghllX42ih60yP9mdIwvBOSlzuT4zvqH9MF5EjuyOFM7yZ4twACfesGW9fqOlDXr2oC0yru2DOkBxAosEDqCrfzttVBpjSA2FAzgmNlq+Dh3PDJA0ZG/WSf18G3xBtSwsPr4wUygS8wKmIm//da075bjvMoMI5NNfh9I=;
X-UUID: 9de378c7284d431fa4b40d7312af7db1-20200317
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1978049119; Tue, 17 Mar 2020 22:06:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 17 Mar 2020 22:04:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Mar 2020 22:06:09 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v3 5/6] pinctrl: mediatek: add mt6779 eint support
Date:   Tue, 17 Mar 2020 22:06:46 +0800
Message-ID: <1584454007-2115-6-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1584454007-2115-1-git-send-email-hanks.chen@mediatek.com>
References: <1584454007-2115-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 47B14C710CFFAA80ADE3503705E4D4F0968EE967D7DF180D60C4E3E5F90EC9022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGRyaXZlciBzZXR0aW5nIHRvIHN1cHBvcnQgbXQ2Nzc5IGVpbnQNCg0KQ2hhbmdlLUlkOiBJ
N2FhMWU2NDExMmNiMmU0MzgxMzMyOGQ5OTcxZmQ2NDQ2MjllZGYwYQ0KU2lnbmVkLW9mZi1ieTog
SGFua3MgQ2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNYXJz
IENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9waW5jdHJsLW10Njc3OS5jIHwgICAgOCArKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRl
ay9waW5jdHJsLW10Njc3OS5jIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2
Nzc5LmMNCmluZGV4IDE0NWJmMjIuLjMyODIyNjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NzkuYw0KKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCkBAIC03MzEsMTEgKzczMSwxOSBAQA0KIAkiaW9jZmdfcnQi
LCAiaW9jZmdfbHQiLCAiaW9jZmdfdGwiLA0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZWludF9odyBtdDY3NzlfZWludF9odyA9IHsNCisJLnBvcnRfbWFzayA9IDcsDQorCS5wb3J0
cyAgICAgPSA2LA0KKwkuYXBfbnVtICAgID0gMTk1LA0KKwkuZGJfY250ICAgID0gMTMsDQorfTsN
CisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19waW5fc29jIG10Njc3OV9kYXRhID0gew0KIAku
cmVnX2NhbCA9IG10Njc3OV9yZWdfY2FscywNCiAJLnBpbnMgPSBtdGtfcGluc19tdDY3NzksDQog
CS5ucGlucyA9IEFSUkFZX1NJWkUobXRrX3BpbnNfbXQ2Nzc5KSwNCiAJLm5ncnBzID0gQVJSQVlf
U0laRShtdGtfcGluc19tdDY3NzkpLA0KKwkuZWludF9odyA9ICZtdDY3NzlfZWludF9odywNCiAJ
LmdwaW9fbSA9IDAsDQogCS5pZXNfcHJlc2VudCA9IHRydWUsDQogCS5iYXNlX25hbWVzID0gbXQ2
Nzc5X3BpbmN0cmxfcmVnaXN0ZXJfYmFzZV9uYW1lcywNCi0tIA0KMS43LjkuNQ0K

