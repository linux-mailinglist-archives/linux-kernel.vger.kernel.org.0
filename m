Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9615AA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfF2K0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 06:26:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42867 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2K0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:26:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so353399pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ufreqsCqUEbtwakQjfPG4/XQRKe+4sPPeMiA/RmTprM=;
        b=Dho7eNQ35SIyPNTS5qQQ9O587OsHxdkVAYouk63JcVIwNEL9lPwUKJExKokYaLWNX1
         DZIlbYQghqtSNwrxpE6B5pAfwL5WOST9YHz6/WlIcI/ShbF32WL0kQ8Yi1nXihz0uBk1
         z18GmAc9Fl0xS57Jk9kN0X8jBwtu/bI1k7U4+PZHh6DOlKVZC2Ga+3C93TNvlUe+c17E
         9DChqt+1QCSJwtCQjR1vL9KaxvywQHt5CTQuky1vE5BYfe2XsX/zl3UyaVkK05i4HLED
         Aw0Mh5XjZqZzITiksUK49sZ04c0m1JrF8WEE+8etK9Y8jjIojdOXfumlOlcE16p9T+wl
         5eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ufreqsCqUEbtwakQjfPG4/XQRKe+4sPPeMiA/RmTprM=;
        b=EWu2VIa6PomzPzaCXyzuw4B6qdVfHcP3rvEu/YqcI1yyx84WyIj6vqEbM4rDa/za8f
         Lk130gld0uw8fmiZTQohqIuhiMeaKhUMZhvlOdTTrt4WeypVuhKKfdEfRfQDGSAkApqQ
         wbmqQH/nWkwtILnR2mEYmah2FMrzN+eP4YS1eT3gTdi6G4YhhMx+QUVQFB3ADk65hd98
         sDXsxVXm7o0335Hdr943HKbm6yFbDrXFzpj5TQaPq06eOzeJd6KCnVkyZdgd9NioRwUf
         Sce2yaGuWLNWBUdiJANqZ6cA4IbDxPp8CEiSyp69XWTjkzYdoeDJYY2APEulfEOc3wvz
         soyA==
X-Gm-Message-State: APjAAAVIJvh3TD+2D6lR8BiKh6KWuJtXgCXGFvqOyfm7nJ62tcjBMpNx
        nb+r03+VZwEcETbSKZI7MZ4=
X-Google-Smtp-Source: APXvYqwBKGNKE3vZ+Zq3TlQ7LCTTVgLrGQhenDVitR7CKr7vXXkcOv+Od0d+XRptoBRec8S7tS0MVw==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr18934769pjb.42.1561803978031;
        Sat, 29 Jun 2019 03:26:18 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id x128sm13085346pfd.17.2019.06.29.03.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:26:17 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:56:14 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102614.GA15248@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index a733046..7883b26 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -221,7 +221,7 @@ void ODM_CfoTracking(void *pDM_VOID)
 		pCfoTrack->CFO_ave_pre = CFO_ave;
 
 		/* 4 1.4 Dynamic Xtal threshold */
-		if (pCfoTrack->bAdjust == false) {
+		if (!pCfoTrack->bAdjust) {
 			if (CFO_ave > CFO_TH_XTAL_HIGH || CFO_ave < (-CFO_TH_XTAL_HIGH))
 				pCfoTrack->bAdjust = true;
 		} else {
-- 
2.7.4

