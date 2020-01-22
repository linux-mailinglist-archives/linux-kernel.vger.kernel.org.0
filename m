Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE714491A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 01:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAVAuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 19:50:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40308 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAVAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:50:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so2118925plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2ahSYYVtBJclG2sCuGcuPAZHs8BDStKSUcf592lFM0=;
        b=MA+CRcuyDTOdAfzsZ7Z7CJZMe+HyIHqR+cWC9yRjuPlJnJU/ktLIAtqU46srg3lRXq
         UBUmaP81R2jUiOKLC3HfGk7YT9riO6+ZfS63iYj3QTRx58jhwNKZRtQkFyDM4rVhgcMa
         CmuPFwgiKppw7Q+TRJed+gQQ9kLI24OuV6GCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2ahSYYVtBJclG2sCuGcuPAZHs8BDStKSUcf592lFM0=;
        b=qob6KF4rs+oY+WlSOSHwomSF23aYPSz1a4QxkuFLaVO9aC+rBNR1+dWi3ZBXKOgSpD
         gYfpaA75ixTBxDqPtiLthwuPhWNiqR7IrqkwR5h01R2SOdImleBFRAgnlLYR1/5smNmV
         sqEU+0fLHzyyGf3N14348eZZQg1DdCplciqYqYDiLY0goi3Me0Crrs5EvP1NEP22rkm3
         +9rp335VjRO8w3UPIxToisbHq+t7Ico4nphgMbSuS2JRN/F5P3ELZmIQU6/m/rwBqtsV
         DbLWAAqSChzZoFI+xhTl5HP7Vrv9FmnLpSOUqL1DD+stuD8ZqvdCCXp5mNwEZyZvDzTG
         HnSQ==
X-Gm-Message-State: APjAAAU0frlE7TXGS5VosPWOpenmNoSkaD2Z6ynHtKIdNe4XLbhWj8RT
        kZccdA78WuRqZLt9s694XYe3j9vSilicmg==
X-Google-Smtp-Source: APXvYqxvoUm+DPKz0pv/uboBEGHYnvcl8ne/lAilt1CR4Weg1WWtSIt8yv0Op0ekDTUvV0LKqVR+8A==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr7879424plk.15.1579654199989;
        Tue, 21 Jan 2020 16:49:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g26sm44569791pfo.130.2020.01.21.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:49:59 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec: Drop unaligned.h include
Date:   Tue, 21 Jan 2020 16:49:58 -0800
Message-Id: <20200122004958.71836-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This include isn't used. Remove it.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6d6ce86a1408..81054de0dd81 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -16,7 +16,6 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/suspend.h>
-#include <asm/unaligned.h>
 
 #define CROS_EC_DEV_EC_INDEX 0
 #define CROS_EC_DEV_PD_INDEX 1
-- 
Sent by a computer, using git, on the internet

