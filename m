Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D37764E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfGZLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 07:51:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42725 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfGZLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:51:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so52261378qtm.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9gHO9TyKSj0CYwPdw5b5x4szapbbJYZPZ0dkycmRYIw=;
        b=Lz+s1aFtzaCKwZvoXyQO5kTnZqyxG5Km3oSJi3o2fV/RSZ9KJ/W8VFqh1fHbPR69pJ
         0DxCzExQ8Ik0jbL6zvWbk0XbxBOAqL66kkTrtpUYYSbTBe/ZDcanl4IQz9Ls7may3P66
         mCVOEnWAC5i8r8/ak/utUb9ahKVhPm+tMrd0tgKM+evPLnO3RBa31ib4LV9ILS4W4opa
         rrzHz95pBcokxjI8oeNHOhLpU2Yvq+xUlZPn7qKxV0CWJbvqhOMcP/6Za1/KDA90lgZE
         OLEyF/j5dz0V4QOSArWTfWtqEpiHc1zjwMht/63USIxUuEPxEv/Olk9gnT6vPGGiY15e
         zwPw==
X-Gm-Message-State: APjAAAXLtOt3Qtu3crLCLatI0Cm/bZ3diyOxeD9Ia4mc2PlAQ/V0j+yv
        VE2QQQPfWND+xrQmONCMw3GPY741mtbr2Ywp
X-Google-Smtp-Source: APXvYqymcbOMEQ4lUl13pE8Gi7ZsmsaJk9G/++ds4UPazH2mBxi16XyvfrDkgsSarz23FJllDH4Qvg==
X-Received: by 2002:ac8:520e:: with SMTP id r14mr65932257qtn.50.1564141877674;
        Fri, 26 Jul 2019 04:51:17 -0700 (PDT)
Received: from redhat.com ([212.92.104.165])
        by smtp.gmail.com with ESMTPSA id 39sm28940576qts.41.2019.07.26.04.51.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:51:16 -0700 (PDT)
Date:   Fri, 26 Jul 2019 07:51:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] vhost: disable metadata prefetch optimization
Message-ID: <20190726115021.7319-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to cause guest and host memory corruption.
Disable for now until we get a better handle on that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I put this in linux-next, we'll re-enable if we can fix
the outstanding issues in a short order.

 drivers/vhost/vhost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 819296332913..42a8c2a13ab1 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -96,7 +96,7 @@ struct vhost_uaddr {
 };
 
 #if defined(CONFIG_MMU_NOTIFIER) && ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE == 0
-#define VHOST_ARCH_CAN_ACCEL_UACCESS 1
+#define VHOST_ARCH_CAN_ACCEL_UACCESS 0
 #else
 #define VHOST_ARCH_CAN_ACCEL_UACCESS 0
 #endif
-- 
MST
