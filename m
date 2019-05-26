Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5E2A953
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfEZLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 07:06:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33067 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfEZLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 07:06:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so5935396plq.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vt37nqdxlvUB79ggM15T2/FTTWBxfQWNhWkq11PROKQ=;
        b=oZY5h4tGiVYinWyRxT4+1A4A+uF6w2KMaCBv+yFqFaeRS84d+1dj/uLlcm5HJK2QEh
         F62VzSUcL6oZJzCV2Y2W6uU7mRSwWEP0tS4q+1FJxeETehd3qC3uzciM4atAmRGBTjay
         aRO6oeswN8RJxrGce2AOsB6C3EBsYfOMFCQuYG3R9scC7sRrRy3xa9+DbS/vazfBRfkC
         bTA7yaeIHkO17h8P/INMiYBXWkXoxWr0ijlXBRvMNtzO0VqJTnqhH3ZbmgaACeD6iTc4
         PuNwrQJ0qmIUB6Q9MwO9fHDdc/PWbyyGrMqtOloXnoeDJ5Xq0+Bp8vgVFOyAvRuYm7Cn
         FG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vt37nqdxlvUB79ggM15T2/FTTWBxfQWNhWkq11PROKQ=;
        b=QoQy4ZraLiPA1jmRIGgnfNSRG8Yi+Ca4Sjjq3VmjN5zB8lepSDaumtcIIesNrW87CY
         7WBgI4M44gooHKvfGK2JmwTfJL6AA67JdhYoGPrwtquUfkP9cpDgSAJNgtHvQOTepAtw
         ipsu0x3gT7tsmPxMRc57hrYsl704G+h0KspPTm0nHlqKoLOiWZ5ybEiSl3FTeq1uSJPY
         dDWKknNmGGUaay1BsYPZqRKEk0Tb6THxK3exnlTEP0wPiNZQs20DBwrApjQwFAin0RQz
         DBXK4b7Oez+Bv0BIChVGOursWA5d9QTa3LcDDJTx85+y35pRtc9R+QTC1FVl65JaSUE/
         9m1g==
X-Gm-Message-State: APjAAAVDBviWKAMYcw6KmjcvBh5k3jHJDvKLWshNCh1rpxK4c1A97soa
        tWq8xVbxVWm+pSuiUhh+nZ1eI691
X-Google-Smtp-Source: APXvYqy4cPE5PR9Hq/DSIi+6zKOL0c30nNvj1cvkRhBjHOi+pePjkOCD21SRo6BUuxGBnPb8jTlJgQ==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr120042307plb.3.1558868790574;
        Sun, 26 May 2019 04:06:30 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id z7sm9343311pfr.23.2019.05.26.04.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 04:06:30 -0700 (PDT)
Date:   Sun, 26 May 2019 16:36:25 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix nvif/device.h is included more than once
Message-ID: <20190526110625.GA3143@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicate inclusion of nvif/device.h

Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 35ff0ca..cfebb14 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -127,7 +127,6 @@ nouveau_cli(struct drm_file *fpriv)
 }
 
 #include <nvif/object.h>
-#include <nvif/device.h>
 
 struct nouveau_drm {
 	struct nouveau_cli master;
-- 
2.7.4

