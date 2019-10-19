Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD7DD8F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfJSOHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 10:07:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53544 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJSOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:07:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so8863610wmd.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnTNLw2zsQ+5FjLMZo6V27teAR8omoAiJIuKZyNFMzg=;
        b=Ada3B9dY1uk12JQ19eWuDMptg1aPGMH0mO3rVcZ8Q0JJ0dJfgYJlGo64uNHpgbj+bS
         sHMFewjUMl7apRYWPCrz682VekIr/DxSmGu+HZ3nTzA3apqlFW7twjiqhaRIiBc4SFK0
         3V+RvOE13cJm3Xuc8NdauZ0Jc3HBhciuA2XeXwIPd9yFSMLyk6ebn1Zs1eSsDrNxt1LX
         p/4ypmiwwGvGjH4C9LClKX1bEgQhaBPTnYEaBcZYVkwYMEdC5zT1YUI7uc9Sh4eDMHHn
         vzAEaU4J/DkTJlMvwg4haXWG+SM1XsDGBoq1ws45kbkB4o/BAs6Dj5VhmTNIvDiF7mcF
         cQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnTNLw2zsQ+5FjLMZo6V27teAR8omoAiJIuKZyNFMzg=;
        b=Sebci5q2mYpMT1L8EidMunQ7nTBrAWDnAGDs4oQXLxdam0Fe9qFO9dCFC0jW1HMq/T
         tU935Exd8MiMdKRgJ8gdVYCl7HI1J9tCVTwaABcKWFqNSwBOApOjLWvAhTgD45NoIg4R
         s229jdshg6k9lNHg4cGtu6/yPEZNrG2qVoPrXsP+JSRQ7RqRFYIoLU/M24sJFn8vomkI
         vZKcyERQy02e70d7svP2tgbmFs3cQsABMmlKJO5N58cITOtqr/7VNwuvwvD0Q2ASGGJ2
         hGZnKNuzoOaUTmVwPmFs8OW5Q1im6xGPezUmd86legZylHpc+zCAhJAfdd1KTprMxlAK
         wtxA==
X-Gm-Message-State: APjAAAUpxr4cewiBTFEDIsBjV4qAH5rCEfIEMuhvcpkpzo7fp/ZndIgE
        lIKa6U0Mpbrh+o9c9SFpOZiz3X1iu4oO
X-Google-Smtp-Source: APXvYqyyZFhcAjD+pH849bBLedrj+1FxuREkCnHl+gYSWWl2csv5twqCEmCZkzI3wEALyplnRMejWA==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr12232552wma.77.1571494070148;
        Sat, 19 Oct 2019 07:07:50 -0700 (PDT)
Received: from ninjahub.lan (host-92-23-80-57.as13285.net. [92.23.80.57])
        by smtp.googlemail.com with ESMTPSA id t4sm7893080wrm.13.2019.10.19.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 07:07:49 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v1 3/5] staging: wfx: fix warnings of logical continuation
Date:   Sat, 19 Oct 2019 15:07:17 +0100
Message-Id: <20191019140719.2542-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019140719.2542-1-jbi.octave@gmail.com>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check warnings of logical continuations
should be on the previous line.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/data_rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index 522592d71aac..52fb0f255dcd 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -163,14 +163,14 @@ void wfx_rx_cb(struct wfx_vif *wvif, struct hif_ind_rx *arg,
 	}
 
 	/* Filter block ACK negotiation: fully controlled by firmware */
-	if (ieee80211_is_action(frame->frame_control)
-	    && arg->rx_flags.match_uc_addr
-	    && mgmt->u.action.category == WLAN_CATEGORY_BACK)
+	if (ieee80211_is_action(frame->frame_control) &&
+	    arg->rx_flags.match_uc_addr &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK)
 		goto drop;
-	if (ieee80211_is_beacon(frame->frame_control)
-	    && !arg->status && wvif->vif
-	    && ether_addr_equal(ieee80211_get_SA(frame),
-				wvif->vif->bss_conf.bssid)) {
+	if (ieee80211_is_beacon(frame->frame_control) &&
+	    !arg->status && wvif->vif &&
+	    ether_addr_equal(ieee80211_get_SA(frame),
+			     wvif->vif->bss_conf.bssid)) {
 		const u8 *tim_ie;
 		u8 *ies = mgmt->u.beacon.variable;
 		size_t ies_len = skb->len - (ies - skb->data);
-- 
2.21.0

