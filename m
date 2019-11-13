Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67F0FA042
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 02:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfKMBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 20:36:15 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45028 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMBgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:36:15 -0500
Received: by mail-yb1-f195.google.com with SMTP id g38so306536ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUSLxwPQi55Mc5QtKsqunj1QHZwBuATEFp6b0WuD06k=;
        b=RZmDnx+DAH7YZCsgW5bC22U1rj9v7pff/+Sx8Ho2rNj2OYcx3TRTHEiGU4MePAS7sh
         DwoM+gRWt2PYna81gX0i7vHQdSmPLFnG4DUO9jWWgZrGLzs0/Z/cUkTZLFz7g2lFjxXF
         k+0XcSzvyr3BEYHO7I1r8MaqrYk3Fd7UkiviEEZcvxY1xAuIx9xbhBbWLQUPE9H87gbD
         tMSKGPAIm5/1fZhZzeLGk/kqIszvxM15QsM0eSORaNAooj9qifi+X0/sdoNRcYdxr/Dk
         4WZlDVJsJutYcV4oDN1Y8eYj8kVk9ETQtFUzU5Bo9WKu0FcC0B3ScWg0f+DqQhj0uzv3
         hZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gUSLxwPQi55Mc5QtKsqunj1QHZwBuATEFp6b0WuD06k=;
        b=ViN8WRiB9sdYepwLpxsvu/olllF3HtBhQ/uClTmS6gIcX4/VMlEEVynR2U0ejjk2zr
         wCPigmuI2Z5HQQx4Z23XZb//jwzFAIuDKJfeorsqF09r1FCK8ndo3KEk2WD9NeBWlHwI
         NT3BnZa8L0WRhmUtA4o2nmb8wahAAkQKnSF+5OqU51yv6AGxjcMUdzFXy5ytPmi7/X60
         km4p1Nouhm8VydMzdxhwqH5bRRxi2AAVc6TWJZUblBySvzWZ6jAB4fPr348KYduUl2FZ
         /cc/K3XOKJVzqWakowkgs724EGrnXt9+4Ho7a1JQbemK5l8LxVe1mSlpKesV5ommWauR
         EkLw==
X-Gm-Message-State: APjAAAX19FS+7p2gn7uXl7hCNRxC2gTGpEW4aXMSP8S2LmZgXpHZcXXU
        p3QQVyvfxG/Y5T3cEHMW5hiiDQoX8la4zg==
X-Google-Smtp-Source: APXvYqznKCmNPOS6z82TtN6gaWYZ+8oaGFcvvo5l7o50LYvKDWXdBgi8fFNO4S60TSRD5KpQv3vAGA==
X-Received: by 2002:a25:e04f:: with SMTP id x76mr812661ybg.114.1573608974579;
        Tue, 12 Nov 2019 17:36:14 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id f66sm521500ywf.110.2019.11.12.17.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:36:14 -0800 (PST)
Date:   Tue, 12 Nov 2019 20:36:12 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v2 2/4] staging: rtl8723bs: Fix unbalanced braces
Message-ID: <ff5bb9f30fd27f68a9b8977094d56c844ba307df.1573605920.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes unbalanced braces around else statements. It also
removes an empty else block.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
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

