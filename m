Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01B618C20E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 17:06:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37297 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:06:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id d12so751513qtj.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMx/8ME+t+O+uhtTdD3/2ZcadFzug6abUR8O/iR4eO8=;
        b=mq9lPlw96H/fgSMpVqJWQXAEQkV4H5luc9q0/aHega6+T+reaLIDnsQoWbCqsK8yBh
         DbBjRyctHUNxn5SG3dnd3+FbY2yitl0d3ooWC7z+h3vFnSwyfKwEKkLw2NHQu9O2fD46
         LZFWUSgngNvVz5TBWV83HiQspYb+L28azXwIkwmL907pS2ewtTKMSzRojP6xQibpkTj6
         54ASnyKKX3huNPhP/xuuWajQ1XdaezLacPfrtAg+mnka0C0NDWcO0vPhyf7haax88jEp
         sGGJRAKqAs6iyJxvCnDY6qe8yDmLRjSYqpTz0HgHMGGMYnI5YfsidRQCauAMgDZdWgEG
         KCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMx/8ME+t+O+uhtTdD3/2ZcadFzug6abUR8O/iR4eO8=;
        b=q8Ju97hzO5aIGgRFC/UnMQ3uvrqPe/gT7V75W6If8ltmFARQROLTqJn716D3dFBlH0
         Ydi9aCKoRIWkjU5rHe967xGUjc9R1/dXWJgorYab2F0MLOeUnCYI3D9gs6chmCYhxsK7
         dJ7egQxQLY7F8ZcfjIQRAEI3yUtFfEx7mT4qAcra6HGlmrLU9Kjk4EtkbhGO1PrxGz0L
         b2Kmurx7OJY6jPmcSv8w1KaFMRvQ0TEcjts32/st9boMkFE9EUgZ74STy2AICnHy0Tfu
         5GDqNC5Y2gPE9x0Y932qLOgJllk3iETQo2pJWJ/kgZZNy8wPjeuknl76KiaqWg8Us/cy
         SU2g==
X-Gm-Message-State: ANhLgQ2AHVri+WtyAaTLt7N5DnLS+snIkRxVigo3bxR4QbETTD9eetxI
        J1yHVdb1rKwGoADFPvneefs=
X-Google-Smtp-Source: ADFU+vsrS0+i9NYd7Ohr9xYe3PUws4AQGLSvj8ovYFCTgMTJF0RiULIyrAQQODniZSoHvLiuqqc7Iw==
X-Received: by 2002:ac8:46d5:: with SMTP id h21mr4985343qto.59.1584651999269;
        Thu, 19 Mar 2020 14:06:39 -0700 (PDT)
Received: from localhost.localdomain ([179.159.236.147])
        by smtp.googlemail.com with ESMTPSA id 31sm2582388qta.56.2020.03.19.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 14:06:38 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Subject: [PATCH v3] drm: Align a comment block
Date:   Thu, 19 Mar 2020 18:06:00 -0300
Message-Id: <20200319210600.1170-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning caused by a misaligned comment block.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

---
Changes in v2:
- Change subject text

Changes in V3
- Fix a typo in the commit message

drivers/gpu/drm/drm_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a9e4a610445a..564acc1f4030 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 		return;
 
 	/*
-	* Must bump handle count first as this may be the last
-	* ref, in which case the object would disappear before we
-	* checked for a name
-	*/
+	 * Must bump handle count first as this may be the last
+	 * ref, in which case the object would disappear before we
+	 * checked for a name
+	 */
 
 	mutex_lock(&dev->object_name_lock);
 	if (--obj->handle_count == 0) {
-- 
2.20.1

