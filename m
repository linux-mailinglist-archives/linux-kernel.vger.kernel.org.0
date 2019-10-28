Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0077E6D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfJ1H3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:29:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9489 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730235AbfJ1H3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:29:18 -0400
X-UUID: 6665dee921e145518eb79a6c2a994445-20191028
X-UUID: 6665dee921e145518eb79a6c2a994445-20191028
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 913583040; Mon, 28 Oct 2019 15:29:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 15:29:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 15:29:11 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Eason Yen <eason.yen@mediatek.com>
Subject: [PATCH v1 1/1] soc: mediatek: add SMC fid table for SIP interface
Date:   Mon, 28 Oct 2019 15:29:08 +0800
Message-ID: <1572247749-4276-1-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add SMC fid table for SIP interface.

1. Add a header file to provide SIP interface to ATF
2. Add AUDIO SMC fid

Signed-off-by: Eason Yen <eason.yen@mediatek.com>


Eason Yen (1):
  soc: mediatek: add SMC fid table for SIP interface

 include/linux/soc/mediatek/mtk_sip_svc.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/linux/soc/mediatek/mtk_sip_svc.h
