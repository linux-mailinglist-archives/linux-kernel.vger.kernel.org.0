Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303EE19B9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 03:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbgDBBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 21:23:48 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56115 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgDBBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:23:48 -0400
Received: by mail-pj1-f67.google.com with SMTP id fh8so870721pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECaKk1XEhaLeQWM1QY7b2cbJfc2H+NtdzI3cEs6W3bc=;
        b=lrnBX7I6IKNCgf1u3GPjWv9QoK7is/FfxG+LIXGzXoYz1Q+HIXh/mCNNMKcQjJRmQS
         2dBtTJMH24EcnO3L40rmSFnqUTq5oFVKQBhXCqzS8e3j0lJ3hznCoyUj3CjHiPXPnN/Q
         VLMKCIvdn3WhMDO54WQqDsUf2+bybLMzkzn9nRL30XD/sEozqQi77BBlKBuJ6FJXiniW
         7TT7bLBuDnoDhpTHg77HLwEqzqKv/2C4eKDrFfhbXqDCxcLGgq+FaU01o/cBd6nTlR1I
         1G9feHEB3Z1ObO1GSPb0sMl4d6re664SUkngnuJz9ao8jlwf7D0gJNpEEYp6mwKEqPJl
         x1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECaKk1XEhaLeQWM1QY7b2cbJfc2H+NtdzI3cEs6W3bc=;
        b=W/9wVvFOioZXfAL+hRYUoxqAHy/Bsx7H0SdgnlzkNSXUmGBHUYAabWGCeQZnJOEHJf
         gy8QyjeNMANQCbu6xVi8X0KSvIWGEPP3jJTu8OSWyc88jAM18qOPptntrX5KOHrjHASp
         4UQU3WmW/kjglxvw5xfibsmnGrSmBdQYu+RZ9ffZWrOcmgyP1pzpGva61uhGy/Xig4qA
         SXQbOQxqyACWw0nSrrkOR0qDRimhbcj06fkIvTOh/bI0a8lgS2x2K6W0TfRL8gOmZ4n0
         2KKDc9HgP5Eril5dmMGhh4Tjq+OCI0eTC0DoLlCfQAvRtGY7W5r00ebkdv+/frQx8pGh
         Zdug==
X-Gm-Message-State: AGi0PuY2epHR6rU7bAtzQA2jU25Qnof68EicvsneRpPHKaMS9X8UgKrb
        ulgsxxULUlTpxPMjQhqYpyw=
X-Google-Smtp-Source: APiQypKphdtygtFszPZHfDmC+v0cOhFzs1P9x5/bGH+iexQPlMgBXonWT55xdU1Z9qFQawYE5bgI5Q==
X-Received: by 2002:a17:90a:a602:: with SMTP id c2mr931092pjq.135.1585790627416;
        Wed, 01 Apr 2020 18:23:47 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id x71sm2424587pfd.129.2020.04.01.18.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:23:46 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] staging: android: ion: Fix parenthesis alignment
Date:   Wed,  1 Apr 2020 18:23:15 -0700
Message-Id: <20200402012315.429064-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 2 parenthesis alignment issues.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index f85ec5b16b65..0198b886d906 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -37,7 +37,7 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 	}
 
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							1 << pool->order);
+			    1 << pool->order);
 	mutex_unlock(&pool->mutex);
 }
 
@@ -57,7 +57,7 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 
 	list_del(&page->lru);
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							-(1 << pool->order));
+			    -(1 << pool->order));
 	return page;
 }
 
-- 
2.25.1

