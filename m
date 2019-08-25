Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE07A08A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfH1Rga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 13:36:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46753 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfH1Rg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so82876pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hV/pCYqzahAlVmQhj4vllaPyolkogafd9L1Tz3zl8gE=;
        b=cakfZ9rzzvgOXHN5tqW79itJAU9INSYghI/taA2o6Pk1fScvhu/l/Q2JbUAvwgjmlY
         d010F4eG/hAE7lN2nJm0EeTRyO2CKpl9BKnLgcB68yxJL+7g6agNRfqpSm1GCJbkjXP8
         7/KkF603jYPyMhu0lt2mQNl2sqC1ZFV3lHe5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hV/pCYqzahAlVmQhj4vllaPyolkogafd9L1Tz3zl8gE=;
        b=MDPluiuYDSHnWseeWkxZltmY8VyLt/NhUlA8tEYMk0K+DdP/vSmwfRFCeJvJXF03LR
         nNm3m5cI9QYbXKGX/oHJ5lN6eX+R5BEKdyGnntOZ+LhvgcI4A+4xi57rMzcaTxNsJ8B1
         kPmKj2QGVuB9BXJK1rNEhIN+64IYB0AQ0IpqyFYq9ZPzawd3Ee10TqSbfI6e5KB3zitC
         ECe+Hg27q6WpnvovUJT1IqprRjx9iO8eR1LcRl2226484lhczw0Af/zTvDDNPmkExBKI
         OmKS4Sf77YJlEP2OXseC+enpNj3vkpL0KFgS/jlP56+oAENxBSB8w8ocr/uMNOVXOi8U
         O8Cw==
X-Gm-Message-State: APjAAAU3vnzndskU7/pK9bNdysWN1D+v9RvKM/JvBHxDTjKROKr/HK6z
        raEuEJ0W2oI5/DtrxWWuv3t19g==
X-Google-Smtp-Source: APXvYqy60PpmqtsU1KPAQexGXqntmtXL8FLGbG3Z+1AAxVXf6D9kHPAZ4kMU3ARbiKgQM8DgyWT+8Q==
X-Received: by 2002:a63:f13:: with SMTP id e19mr4496190pgl.132.1567013788275;
        Wed, 28 Aug 2019 10:36:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm3456466pfb.150.2019.08.28.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:24 -0700 (PDT)
Date:   Sun, 25 Aug 2019 16:18:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uaccess: Disallow > INT_MAX copy sizes
Message-ID: <201908251612.F9902D7A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we've done with VFS, string operations, etc, reject usercopy sizes
larger than INT_MAX, which would be nice to have for catching bugs
related to size calculation overflows[1].

This adds 10 bytes to x86_64 defconfig text and 1980 bytes to the data
section:

   text    data     bss     dec     hex filename
19691167        5134320 1646664 26472151        193eed7 vmlinux.before
19691177        5136300 1646664 26474141        193f69d vmlinux.after

[1] https://marc.info/?l=linux-s390&m=156631939010493&w=2

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 659a4400517b..e93e249a4e9b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -147,6 +147,8 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
 			__bad_copy_to();
 		return false;
 	}
+	if (WARN_ON_ONCE(bytes > INT_MAX))
+		return false;
 	check_object_size(addr, bytes, is_source);
 	return true;
 }
-- 
2.17.1


-- 
Kees Cook
