Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565025D357
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGBPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 11:48:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfGBPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:48:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62FkSbB002392;
        Tue, 2 Jul 2019 17:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eo0SzcMpscMimbmWzsOIbcgLXEFvCBh20u1KgFabFbU=;
 b=bNblDuWO7jsVSN+PfB2xxe0ZDiUyeLXWo9o19zQpFArkhjHGUlIZjoe3y6ozfdtvABAP
 pML3jxpdhSHUr0F+rW9u+8eDOVVxoLwjl72bwQm4mvdgihEK0F6GQu344lB/NNK55Zx2
 6ps1iKV9RlCN9mT9wRTpM7LmiaKcXU7hBQmU2Xn9Nk/i0yan20CCTNOfZ19w9gBWSCKY
 fd8d5mfLUoPJTKUMTwDYgSuD12wohApr0fn+P9FnDW6pvalvQt98b1PmWIgZa7OEdtjG
 kirHv3JZVJvm3fSoJILvjvIbBcBFoIOP3PT9oveWGCciIeCjII4W1Mzei/wRDh0XMmns KQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwf0w4ux-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Jul 2019 17:47:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 839AC31;
        Tue,  2 Jul 2019 15:47:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49270487E;
        Tue,  2 Jul 2019 15:47:37 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 2 Jul 2019
 17:47:37 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 2 Jul 2019 17:47:36
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@st.com>, <jsarha@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] drm/bridge: sii902x: fix audio mclk management
Date:   Tue, 2 Jul 2019 17:47:03 +0200
Message-ID: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix audio master clock use for Silab sii902x HDMI transceiver.
Make audio master clock optional, as this clock is not mandatory.

Olivier Moysan (3):
  drm/bridge: sii902x: fix missing reference to mclk clock
  dt-bindings: display: sii902x: Change audio mclk binding
  drm/bridge: sii902x: make audio mclk optional

 .../devicetree/bindings/display/bridge/sii902x.txt |  5 ++-
 drivers/gpu/drm/bridge/sii902x.c                   | 40 +++++++++++++---------
 2 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.7.4

