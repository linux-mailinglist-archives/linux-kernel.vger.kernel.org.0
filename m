Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEDFB2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKMOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:53:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40361 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfKMOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:53:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id z16so1937593qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EV9duUB20/YZc6E2ELm2TTu7APGuZfnzFklhjn/rE/4=;
        b=rPsmQxrDSL0/1IhhJWjsM/ANeR9qZpEfg9bGpp/wJkzJUrUBpEUz5ORvkwcpDEtWqq
         hQyNFatT8w1gnL0Xw9PhxePJU/ipVM/SuTml1MaljT5Vj/oPQZw8vf7FM82pKFbiJbZL
         pM2ZE1RT3rNtXgA7g3CTKmlDqT/W9HUZ25uraMzMeerHqG+P8YIfgPjjE9kzhhdWKWby
         cTaslc/tlL9/f0lpJqEhx7XeuMEbhHrLFeCrTuQS+aS+pNIfwIhWP/tzsi5MFbbB1V/U
         EHCWEjtIvXhdHDR8w5zKiCWJLnE7C8BxcaDpI9Vg/Bk3Malwm7+PQyjxjlXsXK8emH2K
         CKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EV9duUB20/YZc6E2ELm2TTu7APGuZfnzFklhjn/rE/4=;
        b=j1k8m8Lcz3wxNVkT56Qc+J8WKiSu+6Z/VohVCR6F3uVFbvDCRY8wmcLf+nXpGvBijy
         4ajvl3fP7MaMoitP5C0x9ofSszvak2zcnV0hLPYgnCD4rhp+Cbyk0plN1xW+HK9baD6A
         K4aZ+iCbNQzJwV5REDgmS36zEN5hLFXoVXy9bY+hks+f8rWPCNkTSCORUl5PWtxR3ogP
         GNQJZUK7fNw8KvukAQyi90adS3Lqw8YwKYFQ+1ZNOgs6xIc2KTO7mm8Shpwf5nzf4UZN
         YIy8XJRJVpVbGnYnj501DcyhT3g9+DoJJF9gjE/HlDJWzS5OR6fg2VHp7Lw0KqpteyHt
         TF5g==
X-Gm-Message-State: APjAAAWy4WPXPi9k4P1Ra2j58X/52k2vZt6WoPCIgjQ6JkZlBOXLPr4Z
        9EHKIS6S1tyve+FkF0zYQPvAGlv7YS9B0Q==
X-Google-Smtp-Source: APXvYqx7Ug/zdzKda2v1avPaxNGosvn5Riek12upOf3cp2p7tgVeb/KstKNQ2lVy+MUrK7dqERXkFg==
X-Received: by 2002:a37:81c1:: with SMTP id c184mr2799675qkd.59.1573656812274;
        Wed, 13 Nov 2019 06:53:32 -0800 (PST)
Received: from gmail.com ([184.75.212.4])
        by smtp.gmail.com with ESMTPSA id p3sm995799qkf.107.2019.11.13.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:53:31 -0800 (PST)
Date:   Wed, 13 Nov 2019 09:53:30 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] staging: rtl8723bs: Remove empty block
Message-ID: <25794e45eeb676fd76012db80ac2f12462de7055.1573656487.git.jarias.linux@gmail.com>
References: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an empty else block that produced an unbalanced
brace warning.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
Changes in V3:
	- Edit the commit message and description.
Changes in V2:
        - Reduce the scope of the change given that the previous
          patch had to perform some of these changes.

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 44fc604ea5b7..5856c6e34922 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1844,8 +1844,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 		queue = &pxmitpriv->free_xmit_queue;
 	else if (pxmitframe->ext_tag == 1)
 		queue = &pxmitpriv->free_xframe_ext_queue;
-	else {
-	}
 
 	spin_lock_bh(&queue->lock);
 
-- 
2.20.1

