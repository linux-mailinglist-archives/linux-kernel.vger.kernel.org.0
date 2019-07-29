Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0779C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfG2W14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 18:27:56 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:25244 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfG2W1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:27:55 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 5BD0AEA772
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 17:27:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sE7WhkHHT3Qi0sE7WhV2cZ; Mon, 29 Jul 2019 17:27:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jilYGKdJFUI07LgQEXiOG/Wx5IwotOgB3vmpT+7jOis=; b=TDlUM0e1F+7nTBHCJv4IHNaNTR
        vP2N3srXJTCTFRzhdCAXt5DbWsXElv57PG7gfXAA7OZEOngLZAcbO//tBgVofJ6sid1y94squEaLK
        Ytg5+5G2lCXpDinW5Hdi6KscCuOVlSAsiEK9winQLRxL7oEXglqSvybdOgMcRA/EZzSHPm4QZmI4R
        LQbqeScDgBKtLvf1PWmjl1ZjifjQYcLrLMylJ63pL1DAIOCyq/UzzHZ/EdDIDlBuCF1MLf/sxAWam
        hE4o8u0Ak8BSfQryMq3rSCMtYsApxmu0TSvJIkILNE23gmqc4DoRjugGmMV8e8/s0QSyCSOeOhTIZ
        HL7HQp7A==;
Received: from [187.192.11.120] (port=60868 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsE7V-0025GC-2q; Mon, 29 Jul 2019 17:27:53 -0500
Date:   Mon, 29 Jul 2019 17:27:52 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm: sti: Mark expected switch fall-throughs
Message-ID: <20190729222752.GA20277@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsE7V-0025GC-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60868
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/gpu/drm/sti/sti_hdmi.c: In function ‘hdmi_audio_configure’:
drivers/gpu/drm/sti/sti_hdmi.c:851:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
drivers/gpu/drm/sti/sti_hdmi.c:852:2: note: here
  case 6:
  ^~~~
drivers/gpu/drm/sti/sti_hdmi.c:853:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
drivers/gpu/drm/sti/sti_hdmi.c:854:2: note: here
  case 4:
  ^~~~
drivers/gpu/drm/sti/sti_hdmi.c:855:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
drivers/gpu/drm/sti/sti_hdmi.c:856:2: note: here
  case 2:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f03d617edc4c..1617c5098a50 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -849,10 +849,13 @@ static int hdmi_audio_configure(struct sti_hdmi *hdmi)
 	switch (info->channels) {
 	case 8:
 		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
+		/* fall through */
 	case 6:
 		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
+		/* fall through */
 	case 4:
 		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
+		/* fall through */
 	case 2:
 		audio_cfg |= HDMI_AUD_CFG_CH12_VALID;
 		break;
-- 
2.22.0

