Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A713B98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfEDSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:38:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44153 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfEDSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id c6so2433156lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7Y8Lh5IYv4Bmahc7eyquq9j/qZDLFPPuPgyEde0MGE=;
        b=WgnS9VfjUEb6u5fEL8gfB0GELJaBgiuJixwcpkBXR+UqOo677EOvketHKcA4GSMoa9
         9n5URMgpPlBnXj1q+MbmrooJ1YPLbdXP31bJnJOS0+47XFPbQ0UrWCkxkXtw4tZoaDVm
         oga8pTllNjHlsb0hJR+tGz9/k7FG2zYz7ALyeJehp6F8tQfKPLLoHfWcdC9JIK7K7vmO
         snS+JVHOv8wRa3eJT/67OCBr0oPW6CQk6DmyGJB/nUyY29ee5nbYlJY6OasLiDxVZsxS
         ML1gkmqQ6R4ns68d8+h0ApNbhyRa7NGpJNgKoa/nwzBOYiulc0Ke/DzDisWXck5liqI+
         an1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7Y8Lh5IYv4Bmahc7eyquq9j/qZDLFPPuPgyEde0MGE=;
        b=G9Jy0ki4qcl+/DphjVhRrsvYtU0Z8lNptYFcBBp7xCuJovq0Hx50+GPN7JzRCgQT8g
         LqaGWREt9h8CeJ9jK6GrfcrGQGfkUMYfuGTUeOxuYtFxv4OLPdc1zLa8XNYRSNaguT6e
         mphgyK4b/YqQz0f1AaVf77rLJ84sDcmI+PDZY4PK7g7RXqVJy8Nt3W/hv+PenAFUVRNH
         KjFMKXnISL1JU/IeXu7IBi5afcSeqcmvranBZTBVlr8bD+Z5f3AD0ti1Z4+odHU5pUyF
         lovM/9drOG+N4puHwpPEIWur9kGmwVs5flHh5qeZ0aS3r5S0daWD8yQGz3ogvOPj7eDE
         4rGg==
X-Gm-Message-State: APjAAAXSlwG4O87DPGTMmwzGoS0F+iFtYtGrvbGMzAgJBaDHeZPbq28E
        PJAosCTxH6HVENhG58DKBwJ9tg==
X-Google-Smtp-Source: APXvYqxz+cQwncZIhxh+F3cPOSkTDYr/NyX0A6hOwX9QtdBI6QtHBXZzbQGiZ4AGTLHljZt+gqjbuw==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr2353719ljj.84.1556995119219;
        Sat, 04 May 2019 11:38:39 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:38 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 14/26] lightnvm: pblk: fix lock order in pblk_rb_tear_down_check
Date:   Sat,  4 May 2019 20:37:59 +0200
Message-Id: <20190504183811.18725-15-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

In pblk_rb_tear_down_check() the spinlock functions are not
called in proper order.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 03c241b340ea..35550148b5e8 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -799,8 +799,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
 	}
 
 out:
-	spin_unlock(&rb->w_lock);
 	spin_unlock_irq(&rb->s_lock);
+	spin_unlock(&rb->w_lock);
 
 	return ret;
 }
-- 
2.19.1

