Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC41166D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 07:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLIGUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 01:20:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:29189 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726396AbfLIGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:27 -0500
X-UUID: e0c41756b00f408ea1420c4be82dbc27-20191209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qnw6wE33vyzkOMWjMb+vL2f0wAVHY35hnYQicUwyzko=;
        b=CGTh9vnf9a50clTnAQoaw0f/5YdaW3XVkainGr+YegszTCeJAA3LylmAD6VaJX0aHym38r48PPJMt1RFiqxpXAvxUQEnFXbikkgWv85ULDwURi94Xs+QzmP2HY1SatR8KUvCpdtaNz7tvkS/pAZXMblWgpcuxnNtkIbh8CrIr9w=;
X-UUID: e0c41756b00f408ea1420c4be82dbc27-20191209
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1675659469; Mon, 09 Dec 2019 14:20:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Dec 2019 14:20:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Dec 2019 14:20:10 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2] memory: mtk-smi: Add bandwidth initial setting for MT6779
Date:   Mon, 9 Dec 2019 14:19:28 +0800
Message-ID: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24gYW5kIGJhbmR3aWR0aCBpbml0aWFsIGdvbGRlbiBz
ZXR0aW5nIGZvciBNVDY3NzkgU01JLg0KVGhlIHNldHRpbmcgbWFrZSBiZXR0ZXIgcGVyZm9ybWFu
Y2Ugb2YgbWVtb3J5IGNvbnRyb2wgZm9yIG11bHRpbWVkaWEgbW9kdWxlcy4NCg0KY2hhbmdlbG9n
IHNpbmNlIHYxOg0KLWFkZCBkZXNjcmlwdGlvbiBvZiBHQUxTIGZvciBtdDY3NzkgaW50byBzbWkt
Y29tbW9uIGRvY3VtZW50YXRpb24NCi1yZW1vdmUgdW51c2VkIGRlZmluZQ0KLXJlbmFtZSBzdHJ1
Y3R1cmUgbWVtYmVyIHRvIGNvcnJlc3BvbmQgdG8gcmVsYXRlZCByZWdpc3RlcnMNCi1yZXBsYWNl
IHBvaW50ZXIgb2YgYXJyYXkgd2l0aCBzaW5nbGUgcG9pbnRlciB0byByZWR1Y2UgaW50ZW50aW9u
DQoNCg0KTWluZy1GYW4gQ2hlbiAoMik6DQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogQWRkIGJp
bmRpbmcgZm9yIE1UNjc3OSBTTUkNCiAgbWVtb3J5OiBtdGstc21pOiBBZGQgYmFuZHdpZHRoIGlu
aXRpYWwgZ29sZGVuIHNldHRpbmcgZm9yIE1UNjc3OQ0KDQogLi4uL21lbW9yeS1jb250cm9sbGVy
cy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgICA1ICstDQogLi4uL21lbW9yeS1jb250
cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgICAgICAgfCAgICAzICstDQogZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQzICsrKysrKysr
KysrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAxNDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSk=

