Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9164C162A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBRQIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:08:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43183 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:08:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so8243720plq.10;
        Tue, 18 Feb 2020 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/PWlIRrux36Z8YXu1c6rYJDQ0dR+HkQHRAcmTGfpRHA=;
        b=Wgikwh8/fq9qwIWTMaJkaQThHgvxfDWhHENraP0DiIzzSAj35YjR+DZaMV2WEQg67v
         JCmyiY4bh+10crmZGGwVT5CgYfpW190885U7uL6UAmLbwDC2Zm9vY7wNHnsryOZN/zop
         2k/831O1h3NE7MgvJb2DqelTL//+p6B3dNlyrTN0mIrcaceW0MjdSYroz8zc9FeIJMoV
         oCpyOf3f4asPzYEWn1RxRcGajYYQ09A8mb3hT9wkqIDHwnVWTJybmnh+WdXwf3TTqxxz
         9ibr0nmuoeQdvagcy8IKje9E6lBy75/n34mv2YVmchT75KVwkmU/SIfI2s+3nRMRuEZ0
         c3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/PWlIRrux36Z8YXu1c6rYJDQ0dR+HkQHRAcmTGfpRHA=;
        b=Kdi331CMS1AH087jAuTjky9Njjlkr8NvbYx9vSXapNb1j8FpCzl0UNNf0fmc8QEWBu
         P7MArz5AA5VIsiOCApXc6svppbbCAqDcSJwEap47CEwpf1F6m5f1c4O3yfdB2a2eggbQ
         +DdHq5Usafr/9NO1Pyn19qXjIRG+hBD2vIYJoHOi2OtHYUtV1hPDMPuwcMVQoPrKwVxL
         L48IhzRmQ1/MRdQWe/jEfN8jtwTtSHgGqRQPLcAe7JoKuK+/39/zwPcc5EZX9/6o5Y2D
         HDeDdaC1yx0cAaM+/lU3XT16z9nkPrkh27uoUqAe6VHyB48pPLmdUTauWnM4mWrySvU2
         6b/g==
X-Gm-Message-State: APjAAAX86Qpb5crh4LYaBJHj5EEJuosCDZ9rR6swHEsBjGmbs/tXAbdf
        39m1yOzdk4qt7Ct9d9cESZ4=
X-Google-Smtp-Source: APXvYqwq30136YrcBJPF6QwgqCw02zX8wuOYcx6L1EtvZLWymcIhi+ooZhvqNMzsFO3Arf/VYTO5VA==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr20297850plb.274.1582042123021;
        Tue, 18 Feb 2020 08:08:43 -0800 (PST)
Received: from localhost.localdomain ([1.39.134.248])
        by smtp.gmail.com with ESMTPSA id 7sm4866755pfc.21.2020.02.18.08.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 08:08:41 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     benh@kernel.crashing.org, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video: fbdev: radeon: Remove dead code
Date:   Tue, 18 Feb 2020 21:45:56 +0530
Message-Id: <1582042556-21555-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is dead code since 3.15 and can be removed if not
going to be useful further.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 3af00e3..ccf888e 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -849,12 +849,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
 		case 9 ... 16:
 			v.bits_per_pixel = 16;
 			break;
-		case 17 ... 24:
-#if 0 /* Doesn't seem to work */
-			v.bits_per_pixel = 24;
-			break;
-#endif			
-			return -EINVAL;
 		case 25 ... 32:
 			v.bits_per_pixel = 32;
 			break;
@@ -2548,16 +2542,6 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
 	if (rinfo->mon2_EDID)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
 
-#if 0
-	/* restore original state
-	 * 
-	 * Doesn't quite work yet, I suspect if we come from a legacy
-	 * VGA mode (or worse, text mode), we need to do some VGA black
-	 * magic here that I know nothing about. --BenH
-	 */
-        radeon_write_mode (rinfo, &rinfo->init_state, 1);
- #endif
-
 	del_timer_sync(&rinfo->lvds_timer);
 	arch_phys_wc_del(rinfo->wc_cookie);
         unregister_framebuffer(info);
-- 
1.9.1

