Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25AF10E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 09:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfKFISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 03:18:37 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:8468 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729896AbfKFISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:18:37 -0500
X-UUID: fd14b75e471340fc975bdfe9a259912b-20191106
X-UUID: fd14b75e471340fc975bdfe9a259912b-20191106
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1103170162; Wed, 06 Nov 2019 16:17:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Nov
 2019 16:17:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 6 Nov 2019 16:17:53 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 0/1] boe-tv101wum-n16 seperate the panel power control
Date:   Wed, 6 Nov 2019 16:17:51 +0800
Message-ID: <20191106081752.12944-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 5C7772E381FF907920DE1024D3E7413568274CFB0DA3A0DE6ABC037186520C202000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on v5.4-rc6 and these patches:
https://patchwork.kernel.org/patch/11229375/
https://patchwork.kernel.org/patch/11229609/
https://patchwork.kernel.org/patch/11186565/
https://patchwork.kernel.org/patch/11186569/
https://patchwork.kernel.org/patch/11186571/
https://patchwork.kernel.org/patch/11186577/
https://patchwork.kernel.org/patch/11186581/
https://patchwork.kernel.org/patch/11186585/
https://patchwork.kernel.org/patch/11186589/
https://patchwork.kernel.org/patch/11186595/

Jitao Shi (1):
  drm/panel: boe-tv101wum-n16 seperate the panel power control

 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 69 +++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

-- 
2.21.0

