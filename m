Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88EA99E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393267AbfHVRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 13:48:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390153AbfHVRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:48:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so4419547pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKPaTzLWDYHVrXr9xDJMJ0YlW1PawE9mWGi+KiPZfk4=;
        b=fRfhrMA61H6irTDGq+QNDBg7D/WfWx6Aa7Ry6MaNiZ5jo8Ao7ORFSCjqwXoE9PGvkc
         nnUTPsSgPK1kwHFnLVdRLxmv4ZtxNrw7F6i7nY5dKPHFlD039ZdQtJPiBxGo2P/k9nYm
         QxOU5Y6gjKYKCQKdmtk+qw1HRBjedVFZX5sSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKPaTzLWDYHVrXr9xDJMJ0YlW1PawE9mWGi+KiPZfk4=;
        b=Y/y25tJQ8p5gz7BdoshWfdfQMe46U3JMtn09kc7PGm4cAMvnn4RpW5g3hgwXysKhb+
         Zy57sJP2yBBX+on0ntQbbg0mJEzY/GH/UXRN8vQcEqn1v8swvexx6tPCHPexdmuidHoX
         SdbHVI+sjK1VMVUhmtop/YL6jE6ITrchabFsiH6+KQFTFjuSzC7eih10vJVci8tNAo9G
         m70ZXywCfDE6sWceTCQfJjLiTZ3O067jPSOmWAe2/LeTakb0vVySSzgRHzLCUqtpSzWo
         n+aEBna0HF3ZKJqQljd0ZvdVUaVBf8VX/WVjx+lRwRpWnM/Pv4o0N/Eurxei8ZCm05ve
         JJ2g==
X-Gm-Message-State: APjAAAWvv7S6Fp7A2HUy68gHkDibbhAGoKiHyUJbsDPUyA4WopToRxQe
        gh8WYrDRluoQRQ3BcWUU2jBTug==
X-Google-Smtp-Source: APXvYqyABwKNcJpe0wLJVSYK7zv+DWUUI9QzW8L3iG7a6vg6E5gDC+/cfX9TidXavQMb+eYaKUhDcw==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr937055pjw.58.1566496101340;
        Thu, 22 Aug 2019 10:48:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2b10:8627:31e7:c5ec])
        by smtp.gmail.com with ESMTPSA id m37sm8943184pjb.0.2019.08.22.10.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 10:48:20 -0700 (PDT)
From:   Matthew Wang <matthewmwang@chromium.org>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wang <matthewmwang@chromium.org>
Subject: [PATCH] nl80211: add NL80211_CMD_UPDATE_FT_IES to supported commands
Date:   Thu, 22 Aug 2019 10:48:06 -0700
Message-Id: <20190822174806.2954-1-matthewmwang@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NL80211_CMD_UPDATE_FT_IES to supported commands. In mac80211 drivers,
this can be implemented via existing NL80211_CMD_AUTHENTICATE and
NL80211_ATTR_IE, but non-mac80211 drivers have a separate command for
this. A driver supports FT if it either is mac80211 or supports this
command.

Signed-off-by: Matthew Wang <matthewmwang@chromium.org>
Change-Id: I93e3d09a6d949466d1aea48bff2c3ad862edccc6
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd05ae1437a9..c2f9e6b429b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2065,6 +2065,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				CMD(add_tx_ts, ADD_TX_TS);
 			CMD(set_multicast_to_unicast, SET_MULTICAST_TO_UNICAST);
 			CMD(update_connect_params, UPDATE_CONNECT_PARAMS);
+			CMD(update_ft_ies, UPDATE_FT_IES);
 		}
 #undef CMD
 
-- 
2.23.0.187.g17f5b7556c-goog

