Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1EC1ADD2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 20:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfELSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 14:41:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44152 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfELSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:41:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so5264185plj.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/tiqLBXOZvXdZPkWEHxuqsfybmaWhHqaUojJWwn//o=;
        b=gmE7gAbSlzGEhZ8LpGR33W5phzB49ia1QW0WhEOtOQV4k2UM+5pRETcVfWCpKKNILw
         cgDKa+e0YZK+3bK/PXSD01TnlI0nZLmqs/H6hXf77K1sJ5EEbzgDeiNjoWyIB0J/QXCB
         UX5Ea+tsVIzso1qwvUxryk/+dq/YdCVEM5Cn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/tiqLBXOZvXdZPkWEHxuqsfybmaWhHqaUojJWwn//o=;
        b=QqJ4pnY5JaZGFpD2E0HLJfhb27k3vey9GwlOCstoghkRp6fA159TT0YVUYWBNXGUHE
         db/bBaHLz8njvWtueey3kpR6VNsXpVuu4h+exAqXaVzbetw8TMb6tYscDniMecG5MKA9
         1XokE6U+JHJz1qJhRCVTTrDOZGXRMWlmJz9aDcuEbbcTYro0HrPUOwUnVtSmJVwdh5MF
         orCUIs0sF5aV/HDZIDNsNBeADPNBDp6VGgor8lCaUuhxDgxlvcF9w++e4YXHLXLrhFhP
         VCxV2sMCoeOqI6SxB2ugbcPpEmPmmeSzoDh6Gp4VqygasNA+axJ/HE1ZDwoEhSRVbnFf
         lI/Q==
X-Gm-Message-State: APjAAAXi+2UQJAetBk+g7fcMo1fCSmM1sMGuPN6D5yuXPDk9PclRfYiv
        XCXg5gPVLBMSJK/5zQx+nL7AGA==
X-Google-Smtp-Source: APXvYqwLAkLdPyesxE21ArrmkGjGcpu4anTuk5SMx6PYeET8I99rpV7dKeZpH6UnhBbAr5A8i0TpDw==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr26647580pln.10.1557686511560;
        Sun, 12 May 2019 11:41:51 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id 37sm11041291pgn.21.2019.05.12.11.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 11:41:51 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 2/2] drm/sun4i: sun6i_mipi_dsi: Support DSI GENERIC_SHORT_WRITE_2 transfer
Date:   Mon, 13 May 2019 00:11:27 +0530
Message-Id: <20190512184128.13720-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190512184128.13720-1-jagan@amarulasolutions.com>
References: <20190512184128.13720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DSI panels do use GENERIC_SHORT_WRITE_2 transfer protocol to host
DSI driver and which is similar to GENERIC_SHORT_WRITE.

Add support for the same transfer, so-that so-that the panels which are
requesting similar transfer type will process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index bfa7e2b146df..a1fc8b520985 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -980,6 +980,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

