Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE00C16A161
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBXJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:12:48 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:58783 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgBXJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C4C93616;
        Mon, 24 Feb 2020 04:10:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=hKVRtL0uL3hgd
        oZOi9U39towoF/TFyELVBoPINOnrVA=; b=FFNwPKkvgAgjPLwGQ+wYtIkzQ1pNg
        GZawvETvOEJmuD3b7VcgmfrHPjhhcOYN0+Kv2rAWkjD1GzK/r+BhaDUYWJfoK9U2
        OOXV11lkX9S3rCIR+hBmu9Aw4bgq4jXb87UWt48t832NXRs66LtnPWI/HlRSSI6C
        +hkv8PXzn6FNCNOlhLiXW/4bUmsrT6lK5dQLKkp7wA03iMZV2X4DhR1CObZveCTl
        HSU8HTAwErumhejqVWtb5cY0Vx+Zif7eK1OxQGwFuoTmSe2dTvsCdlxuOCWyHixh
        /9twQzZUffdzcIov7MActMKkkNqFdEGJibeQjM6KNPu3XW2tA+DevY2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hKVRtL0uL3hgdoZOi9U39towoF/TFyELVBoPINOnrVA=; b=AzL+CVwf
        a9N5IqzmiojHkdLjbTVE2a5K3IDHYJdo3dALD86IzDzfS1cu3cle/uitOEU0Iv2E
        7IkLiDDQlMc31kWkj8Tn11NCqPzP1S/4LV1j0sJjvvj/QevszbTGKgzjQIbbDwOW
        cyN7Kvr79p9paeAC6kDftvPhfOJXtDbQnNfQy9qwfl3JUzj9U7DunCS75CQ81hSx
        q4NiZPpkMCrLXV045zufySQy77VMyFHp1ynxlPgNrnoXRrdBJb77paRnGLOnCr0D
        uK2z6IfqvPWQWIdN6bc18RcmOJf/vJKvWjPvrxnOoc4E6uwNpwqm4Hencmi6E4lm
        EZETa6xWEaABWQ==
X-ME-Sender: <xms:6ZJTXsJ7N7nGkoGGvEFJ_CUykwxSE3FsLkMYx5H0Sjjkuw6Aebt6zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepgeegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6ZJTXoMG7TM335l_S7DotE5GFvIyNambRV6vWGbp9gJkv2-CnyCHOw>
    <xmx:6ZJTXioyKEHzS5On1Z2jizBJSvZkvpZiXrHv2jHV6s5tozdaoMeNUA>
    <xmx:6ZJTXqUlOXzTc57wUn6JkAPoffUfW16o1TFVssHSin_8Tuu2Bpqt3Q>
    <xmx:6ZJTXnhHQX3aDLOVxgdv0jHYEqdytoSOHJMgmkAquwime7payNem_hEYCfM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16FC53280066;
        Mon, 24 Feb 2020 04:10:01 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 50/89] drm/vc4: crtc: Use local chan variable
Date:   Mon, 24 Feb 2020 10:06:52 +0100
Message-Id: <3e902ce1e4f07af302997f827fc736d951d752ad.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_crtc_handle_page_flip already has a local variable holding the
value of vc4_crtc->channel, so let's use it instead.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d03bd7946a84..d3ff32daf60a 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -815,7 +815,7 @@ static void vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
 		 * the CRTC and encoder already reconfigured, leading to
 		 * underruns. This can be seen when reconfiguring the CRTC.
 		 */
-		vc4_hvs_unmask_underrun(dev, vc4_crtc->channel);
+		vc4_hvs_unmask_underrun(dev, chan);
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
-- 
git-series 0.9.1
