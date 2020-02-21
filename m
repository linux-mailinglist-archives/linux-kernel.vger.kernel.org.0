Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4C167A50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgBUKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 05:12:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9240 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728396AbgBUKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:12:38 -0500
X-UUID: 2fec0106058b4108b7102098fe56fd44-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ARXJmjqMj0hTx5/WyykP1t7usiaCNGTpnwPDf5OrFYI=;
        b=l4nBRRhCOPOQWMinALq2q2u300Ha+r+ovp6y5rwObVBXbach3VOHcd6BxfQjnrM8JR/Lj9AsdA5BQ6K1D9V57Cc4GlJpFDF3Rp69scv/ANazREZQsbErpr5PJGAJ1nbjKSMT0RwjMTOMNtDybbdHvo9DgfDgsDqnzUvQCoyH1ng=;
X-UUID: 2fec0106058b4108b7102098fe56fd44-20200221
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1465237031; Fri, 21 Feb 2020 18:12:32 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 18:09:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 18:11:53 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v8 4/4] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks
Date:   Fri, 21 Feb 2020 18:12:09 +0800
Message-ID: <1582279929-11535-5-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C739C5E12C447902CF866A1404BB87A25E2BD863623992A5BE480521300D28D92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT3dlbiBDaGVuIDxvd2VuLmNoZW5AbWVkaWF0ZWsuY29tPg0KDQpFbmFibGUgTVQ2NzY1
IGNsb2NrIGNvbmZpZ3MsIGluY2x1ZGUgdG9wY2tnZW4sIGFwbWl4ZWRzeXMsDQppbmZyYWNmZywg
YW5kIHN1YnN5c3RlbSBjbG9ja3MuDQoNClNpZ25lZC1vZmYtYnk6IE93ZW4gQ2hlbiA8b3dlbi5j
aGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxp
bkBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgICAg
NiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNv
bmZpZw0KaW5kZXggNmE4M2JhMi4uOWQzZGE4MSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvY29u
Zmlncy9kZWZjb25maWcNCisrKyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCkBAIC00
ODksNiArNDg5LDEyIEBAIENPTkZJR19SRUdVTEFUT1JfUUNPTV9TTURfUlBNPXkNCiBDT05GSUdf
UkVHVUxBVE9SX1FDT01fU1BNST15DQogQ09ORklHX1JFR1VMQVRPUl9SSzgwOD15DQogQ09ORklH
X1JFR1VMQVRPUl9TMk1QUzExPXkNCitDT05GSUdfQ09NTU9OX0NMS19NVDY3NjVfQVVESU9TWVM9
eQ0KK0NPTkZJR19DT01NT05fQ0xLX01UNjc2NV9DQU1TWVM9eQ0KK0NPTkZJR19DT01NT05fQ0xL
X01UNjc2NV9NTVNZUz15DQorQ09ORklHX0NPTU1PTl9DTEtfTVQ2NzY1X0lNR1NZUz15DQorQ09O
RklHX0NPTU1PTl9DTEtfTVQ2NzY1X1ZDT0RFQ1NZUz15DQorQ09ORklHX0NPTU1PTl9DTEtfTVQ2
NzY1X01JUEkwQVNZUz15DQogQ09ORklHX1JFR1VMQVRPUl9WQ1RSTD1tDQogQ09ORklHX1JDX0NP
UkU9bQ0KIENPTkZJR19SQ19ERUNPREVSUz15DQotLSANCjEuNy45LjUNCg==

