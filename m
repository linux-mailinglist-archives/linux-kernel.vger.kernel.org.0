Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08D160CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBQIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:20:01 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:6024 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726932AbgBQIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:19:59 -0500
X-UUID: ff7f0e148cd24634a7b15f226d40318f-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From; bh=CNjl2hI20d68vxiX1u56Xsi7CnowTCfuliL82LhhtjI=;
        b=GxMEtP+yMSdYfaEG+zQl7drojz7GwZx6v5XDzZta5sC2zPXw0IXexSNaBSRXusjMZ7EtspKGhyT6fo39F9a/H7LqFGif3XXJdtS/VIapnAhbLM8B4Leq4hfeptFuIVuA8Wyt25RNiq+hciLOP02XjIxjYwm2AfXJq9lTbJczNUM=;
X-UUID: ff7f0e148cd24634a7b15f226d40318f-20200217
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.liang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 449462894; Mon, 17 Feb 2020 16:19:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 16:18:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 16:19:20 +0800
From:   Yong Liang <yong.liang@mediatek.com>
To:     <yong.liang@mediatek.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Add watchdog device node
Date:   Mon, 17 Feb 2020 16:19:21 +0800
Message-ID: <20200217081922.22544-1-yong.liang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Add watchdog device node>
References: <Add watchdog device node>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AA4A247E4141285BF863CB3E3630B1908C7C738F9C63F62CDE6CC0D77BA2CC8E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogInlvbmcubGlhbmciIDx5b25nLmxpYW5nQG1lZGlhdGVrLmNvbT4NCg0KQWRkIHdhdGNo
ZG9nIGRldmljZSBub2RlDQoNCnlvbmcubGlhbmcgKDEpOg0KICBhbXI2NDogZHRzOiBtb2RpZnkg
bXQ4MTgzLmR0c2kNCg0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kg
fCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCi0tIA0KMi4x
OC4wDQo=

