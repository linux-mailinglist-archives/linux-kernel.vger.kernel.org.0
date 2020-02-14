Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0812E15F804
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgBNUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 15:48:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbgBNUsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so12453709wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQaG6XnNE1ukMITaqxKDBRNvO+txpnsB9rpKWdE6tyA=;
        b=R2gfH66rLy/c7l4lV6E7iPng2NmRy1/Cko49qc9RwsAr0eg5uu/znhDnl5JV0VQMRT
         mwJ8hppTUrCZKIjlHdsJP0pPGsFZ9X9b8kH3PEi6gGqrHxjU8GbB1iSWbIZfqq9qszNA
         pBzSEn4SbWLL27AEEynn4PMo/mPQATGaVWZj/U2+t/3q5wLhCz3/8vmNbah4gcCavwLg
         MgA2QGqot4MhKTbsoZkYjSWqYUGsFmzI5WspfoYCp4Lc1zm7TZ+Ku+CdjQaQLX/zRJn+
         qCkirrRAA161XEWWSGczBqi5nPmAna2neDZX5VnynaPuiOw8Q602JcSxErlrbMgpkkSv
         hBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQaG6XnNE1ukMITaqxKDBRNvO+txpnsB9rpKWdE6tyA=;
        b=C5LEA5cFo6C5skweb16aZ/LDZ7FteVK18Up9TIxVKFPV4OKjZmwe879n8X3RMbJ0Fx
         MgEz31YCkdvUCvYmQtK2LJICYUEpK9sGlPzTHrenE/DrtSTtsebEvilUdZ523hskuF+p
         ENW6thrq9aMUIlnmdjcA++8bIg+wWE9huYTgNk/sdPXJPpqMsg75nkIWmZpXQXAgbvTa
         nrMHQNfYxASwzNjtE3BcA/hrfx0mdSS0ufKRWXExkXR9ZYjKGpMiUMHkxHYzKM0brLm2
         Uz1OMhlZqh6h0kCzhQv2SbF/DjM74xaDTLQ5nLYMTHYee70TGhJjQZALDPJz/zTzXaS3
         5LHQ==
X-Gm-Message-State: APjAAAUnWwsRyemhCQGkTjNhVYF3Pc+ua6+bPMmXUCwaBRxS3Y+/OhKx
        iFoZZC+P6XAemignFnB4I1VGJIOEheqL
X-Google-Smtp-Source: APXvYqxZUKjy9Sf+P9bJmjwsrq+0zbt2cneuQHsL7RljUONH5y+df3SjkwhJDgbJpx/WFq03dPxPTw==
X-Received: by 2002:adf:f302:: with SMTP id i2mr5811628wro.21.1581713328393;
        Fri, 14 Feb 2020 12:48:48 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:48 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 13/30] mm/zsmalloc: Add missing annotation for unpin_tag()
Date:   Fri, 14 Feb 2020 20:47:24 +0000
Message-Id: <20200214204741.94112-14-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at unpin_tag()()

warning: context imbalance in unpin_tag() - unexpected unlock

The root cause is the missing annotation at unpin_tag()
Add the missing __releases(bitlock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7bac76ae11b3..2aa2d524a343 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -896,7 +896,7 @@ static void pin_tag(unsigned long handle) __acquires(bitlock)
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
 
-static void unpin_tag(unsigned long handle)
+static void unpin_tag(unsigned long handle) __releases(bitlock)
 {
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
-- 
2.24.1

