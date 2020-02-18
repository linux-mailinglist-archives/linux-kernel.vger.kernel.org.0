Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF708162A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBRQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:07:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36484 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:07:38 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so1193524pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6IJPCaTEcBb2m8XkY4aRmJfNArzRhDFzGrCWNLyN7Ic=;
        b=nNQYMPFNJpNoZxtqF2phDv1wjXg0AOZ/bl4BaeHLoULkitFcLFvO3rs4v3tmN7E108
         tDWdJm31m3moyA169gHYrLc/puw5pYrowXS7G6CHHU23HSnEuG4+oX57a7ItNS9dBthQ
         FH63MQBYEqz4zkoxEXkPInytkpJrdBCRH6oERlUbX3RvNVqi+F8nI39WXY1X2aJjPcJK
         o0qLDJNkEtjRUJD3cwrd2M6y0rzsIRMkuBPaWdfRLaWiPyJgky/uEhnouXIPZWJsihld
         F1Gim6pg0v5ed3RKxw86kVFL0I9AHP/84LExdk5/9NVFpulFphpKCcEYKx8Z+lp7wxpS
         0wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6IJPCaTEcBb2m8XkY4aRmJfNArzRhDFzGrCWNLyN7Ic=;
        b=C4xhYWVMwZ3Clz7igP3aSRyKWFwT899wNjF4JPbEeFCr+Nv1AGlGX724FaTo6sNRUE
         RMEijJYvVDDLWecPSj7LXoV7SeqjVeS4U5PyRx96v69DZ8CUyFFrii9SW78Bkm17TPvX
         VPYEzBz7fSOJPfzY+RmGc4UXbhUlGEYECgU2htTGP5rreLSlWYbZnI3vXeXKc7c6mA4G
         V4pnvl5qSOhQt1eBXwitLlC/ygdNLSGc8SnS+6N3VK1KA/WHJM2ihY8X5rfpVXqB/8Cl
         T09Xe4XmpjeX7AXNQXeodsnByZ6yEHU/Lo6LzclJTokZpjvs25U2k9vWCofvM86+fNQl
         eWcg==
X-Gm-Message-State: APjAAAUkruV9uvUMPfA2iHVHV7VbjH/+rzgDtpKs2HL6Q78lP7/7D9VP
        m3jvp8rhFrIZNyjNshF99KSQjQ==
X-Google-Smtp-Source: APXvYqy8JRIuOTKUkj1s0uIaQjKYrPfy6Q91GTwrh/k+Pt+nzWjZ0HbG7DxYrRNO5RCTUzT9wAwWBw==
X-Received: by 2002:a17:902:b583:: with SMTP id a3mr21124343pls.180.1582042056382;
        Tue, 18 Feb 2020 08:07:36 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id g9sm4773300pfm.150.2020.02.18.08.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 08:07:35 -0800 (PST)
Date:   Tue, 18 Feb 2020 21:37:28 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-camera: call function instead of macro
Message-ID: <20200218160727.GA17010@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning of 'macro argument reuse' in bcm2835-camera.h
by removing the macro and calling the function, written in macro in
bcm2835-camera.h, directly in bcm2835-camera.c

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 .../bcm2835-camera/bcm2835-camera.c           | 28 +++++++++++++++----
 .../bcm2835-camera/bcm2835-camera.h           | 10 -------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 1ef31a984741..19b3ba80d0e7 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -919,9 +919,17 @@ static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 	else
 		f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
 	f->fmt.pix.priv = 0;
-
-	v4l2_dump_pix_format(1, bcm2835_v4l2_debug, &dev->v4l2_dev, &f->fmt.pix,
-			     __func__);
+	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
+		 "%s: w %u h %u field %u pfmt 0x%x bpl %u sz_img %u colorspace 0x%x priv %u\n",
+		  __func__,
+		 (&f->fmt.pix)->width,
+		 (&f->fmt.pix)->height,
+		 (&f->fmt.pix)->field,
+		 (&f->fmt.pix)->pixelformat,
+		 (&f->fmt.pix)->bytesperline,
+		 (&f->fmt.pix)->sizeimage,
+		 (&f->fmt.pix)->colorspace,
+		 (&f->fmt.pix)->priv);
 	return 0;
 }
 
@@ -995,9 +1003,17 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "Now %dx%d format %08X\n",
 		f->fmt.pix.width, f->fmt.pix.height, f->fmt.pix.pixelformat);
-
-	v4l2_dump_pix_format(1, bcm2835_v4l2_debug, &dev->v4l2_dev, &f->fmt.pix,
-			     __func__);
+	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
+		 "%s: w %u h %u field %u pfmt 0x%x bpl %u sz_img %u colorspace 0x%x priv %u\n",
+		 __func__,
+		 (&f->fmt.pix)->width,
+		 (&f->fmt.pix)->height,
+		 (&f->fmt.pix)->field,
+		 (&f->fmt.pix)->pixelformat,
+		 (&f->fmt.pix)->bytesperline,
+		 (&f->fmt.pix)->sizeimage,
+		 (&f->fmt.pix)->colorspace,
+		 (&f->fmt.pix)->priv);
 	return 0;
 }
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
index b5fce38de038..2e3e1954e3ce 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
@@ -121,16 +121,6 @@ int set_framerate_params(struct bm2835_mmal_dev *dev);
 
 /* Debug helpers */
 
-#define v4l2_dump_pix_format(level, debug, dev, pix_fmt, desc)	\
-{	\
-	v4l2_dbg(level, debug, dev,	\
-"%s: w %u h %u field %u pfmt 0x%x bpl %u sz_img %u colorspace 0x%x priv %u\n", \
-		desc,	\
-		(pix_fmt)->width, (pix_fmt)->height, (pix_fmt)->field,	\
-		(pix_fmt)->pixelformat, (pix_fmt)->bytesperline,	\
-		(pix_fmt)->sizeimage, (pix_fmt)->colorspace, (pix_fmt)->priv); \
-}
-
 #define v4l2_dump_win_format(level, debug, dev, win_fmt, desc)	\
 {	\
 	v4l2_dbg(level, debug, dev,	\
-- 
2.17.1

