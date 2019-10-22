Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D66E050B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfJVNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:30:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1813 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbfJVNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:30:21 -0400
X-UUID: 8b3a63d9d49a40abbc5a661991e2c3c6-20191022
X-UUID: 8b3a63d9d49a40abbc5a661991e2c3c6-20191022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1771341005; Tue, 22 Oct 2019 21:30:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Oct 2019 21:30:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Oct 2019 21:30:09 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [RESEMD, PATCH 0/1] Add mt7629 pwm support
Date:   Tue, 22 Oct 2019 21:30:00 +0800
Message-ID: <1571751001-28588-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping on this whole patch series

This adds pwm support for MT7629.
Separate this dtsi update from pwm patches series,

Used:
https://patchwork.kernel.org/patch/11160851/

Related dependent driver updates have been merged into maintainer's kernel
source tree.

Sam Shih (1):
  arm: dts: mediatek: add mt7629 pwm support

 arch/arm/boot/dts/mt7629.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.17.1

