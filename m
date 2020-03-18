Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B8189658
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 08:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCRHx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 03:53:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45062 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:53:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so13204288pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ix5gR+5tSADkG65bVowPOhtK65TNERJ9gTTgrdl498s=;
        b=cUv+Wg8jSCf8pGEQXq7PrK6Kkk1wWraRdky+Q9IGdq4hXTb5mT13mvFhkL56wlHJL8
         VQUfXTy0hElD/ymLJ6e8XXLlkbXYXMrnGjTESn7ZJncsdII5q9P9HkC4XZymZhoAiKdO
         zyUrkInXCg9FwLWjuy0VYtljdpNrY6irRxfktuCTcKq8lXn/E/be8hcPQd716X1j4OAH
         IG2hpXtIsuCVgRhrRED+Jl/b8627CkaXWOai4EvoKnTsJse5odgBUoKLY/3jQKjO2dvu
         TFvvUQjxcJVG6YFVZd0aMHxhuAw2Qo4R4HzIcOqkghq+prqZsRt+1L+Ks9hrWz0bCsrS
         jT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ix5gR+5tSADkG65bVowPOhtK65TNERJ9gTTgrdl498s=;
        b=L51l9aYSXmiKJuxXm2E6Uu5lI4oiHBjivA9F9rRaRNyrEH24eCGdLlDo3tDY6fmuEo
         LLDkdj6L9A9VyDVIEa+/GBXf7Kcv1wTn4MCrjZ/jJ5rLdyTG561ecgHf7amk7Pi4iSPF
         00uM7nmPIGtwwtPfTZpzoobFKiFUTgrVVJR8fbH9lvw8mAzTKTQ8bjklOxhm9X948nfl
         gUt/SzXmm6Q7iInvzKNq0aHSTDXufFxOoy+l5/hVKGXM06Qb6YxQA7NvYp3+aSWJ5YIn
         Cvc5XwNWlayUoZUFkEij7BlP9+1l/I6jhpFU+92aQIQ7F6FTm6pGFsjHlnDe6Swt/y25
         4ojg==
X-Gm-Message-State: ANhLgQ2Al13oxbgjXk9I4QuHa7z8G8o4PzZDv8bNJDKl6p+5qzF7HaBw
        8N5wt7GeONle5V724B2+eypsda/Hs6M=
X-Google-Smtp-Source: ADFU+vshiSpx2NHtpGATn2PO9MyVUCdUwHWsEwJ3tKMFf6OagvK22K2ivh9NXPoh8qFgR34zHfIlwA==
X-Received: by 2002:a63:b52:: with SMTP id a18mr3361810pgl.130.1584518035689;
        Wed, 18 Mar 2020 00:53:55 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id j17sm5507117pfd.175.2020.03.18.00.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:53:55 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] drm/lease: fix WARNING in idr_destroy
Date:   Wed, 18 Mar 2020 15:53:50 +0800
Message-Id: <1584518030-4173-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_lease_create takes ownership of leases. And leases will be released
by drm_master_put.

drm_master_put
    ->drm_master_destroy
            ->idr_destroy

So we needn't call idr_destroy again.

Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index b481caf..825abe3 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -542,10 +542,12 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	}
 
 	DRM_DEBUG_LEASE("Creating lease\n");
+	/* lessee will take the ownership of leases */
 	lessee = drm_lease_create(lessor, &leases);
 
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
+		idr_destroy(&leases);
 		goto out_leases;
 	}
 
@@ -580,7 +582,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 out_leases:
 	put_unused_fd(fd);
-	idr_destroy(&leases);
 
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;
-- 
1.8.3.1

