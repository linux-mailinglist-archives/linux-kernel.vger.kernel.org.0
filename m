Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0A1166D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 07:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLIGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 01:20:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26952 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbfLIGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:26 -0500
X-UUID: 497ee2484aca4dbcbfa1c79dde75c3dd-20191209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kTqvlfGMvsUZzVP+Eq0py88Up+EX3EjeHOY7T3c+KBw=;
        b=AjglW8JnEcZ/snhOf9Bfp/5FeVE5dBMugjVUhOGoYrsJON6WC2+1s2wlJ4muqJY/2OAbHnRfPh7KGnRG8XTgVM74HviWVHXCRvp+CuARzkGBy2Ub1wFUevrU5/8BBrCFaZ+Ff1D3bph9Pl1ePh+W9GYDeFF/rcAWFmfHkk7Ycj0=;
X-UUID: 497ee2484aca4dbcbfa1c79dde75c3dd-20191209
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1368284063; Mon, 09 Dec 2019 14:20:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Dec 2019 14:20:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Dec 2019 14:20:11 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 0/2] memory: mtk-smi: Add bandwidth initial setting for MT6779
Date:   Mon, 9 Dec 2019 14:19:29 +0800
Message-ID: <1575872371-671-2-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KioqIEJMVVJCIEhFUkUgKioqDQoNCk1pbmctRmFuIENoZW4gKDIpOg0KICBkdC1iaW5kaW5nczog
bWVkaWF0ZWs6IEFkZCBiaW5kaW5nIGZvciBNVDY3NzkgU01JDQogIG1lbW9yeTogbXRrLXNtaTog
QWRkIGJhbmR3aWR0aCBpbml0aWFsIGdvbGRlbiBzZXR0aW5nIGZvciBNVDY3NzkNCg0KIC4uLi9t
ZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgIHwgICAgNSArLQ0K
IC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIudHh0ICAgICAgIHwgICAg
MyArLQ0KIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDE0MyArKysrKysrKysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMS43LjkuNQ0K

