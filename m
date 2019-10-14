Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A72D6B33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfJNVZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 17:25:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33592 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfJNVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:25:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so18064349ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=UE3cFj1eeaEg+c6oSlBkkGkBUi7iBIX1FCElgCSWH3V3Q5VLWYARw4curmMKBKFQVJ
         LogzpmkVabWdQEig0e9+eynXQymGCkTRKi6xqzw4GbRDvggJEN/hLzYYWcu7HvaJXf0j
         0rJFr2M8O2PGWZSoazQq5daJlnIWfpV/3jVQv4iyuq3JqVvMlZEuJkKTZz5T3TU24b9n
         afqhUArYr7MCj7LLWUFkmKR8CTaKeepZ7shKb8Z71rvG3Dob7vAXoKeUYGu414thkb9f
         SDYxDjrTLJPu8xEHmQ5glwBsME9AFWHckLxSKL4OuBztN5ePy0V99evU7HoSbnJ5a3TV
         az7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=sINjfbVGfQqOS5PBQfhGBSJhbTiK1SrRFufwxlV3eW2GoE+pXD5ilaUhFothBJp/AI
         O6ZyV98F8n3VE2LFGdU/LrQou9G0dbw+ypHSq8tDCVT+PXZjmt0wwYANNiH8g2tw2LwX
         unszsVcV1ez5SWrI/sDywZdFw/C2CTu22soQcuF3y1uc6GKuLB+f9Wc+oFZakNhdj3vV
         TxFKHSyVv3ltjQKbyP7cAIhhaiuYF+V0Iw5XMYTMaAuvAf3daAJ26OslddIaYLTp8Ew1
         az7+VzXMthTJTKRfm6oItSUfBMZTTLsCB+5UqrDUz5SmphwvOxUxBh/OXIFn10Q8Qc+J
         LXzw==
X-Gm-Message-State: APjAAAW45kZz4JIRIa7b5qxhKwUSa6nsCqj1+/JulRQticz6KGjgEQut
        bIi7lSMhnepQvGpdCtXu1hY=
X-Google-Smtp-Source: APXvYqwb/FwNAARo6WlmergKMs6EALRCoKHxGf0b0I+UrDEz02wKF9Rcd90SPMhv9xw5zLIwDXmyZw==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr13217193ljg.202.1571088339195;
        Mon, 14 Oct 2019 14:25:39 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id m15sm4429434ljh.50.2019.10.14.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 14:25:38 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 1/3] xtensa: fix {get,put}_user() for 64bit values
Date:   Mon, 14 Oct 2019 14:25:11 -0700
Message-Id: <20191014212513.17661-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014212513.17661-1-jcmvbkbc@gmail.com>
References: <20191014212513.17661-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

First of all, on short copies __copy_{to,from}_user() return the amount
of bytes left uncopied, *not* -EFAULT.  get_user() and put_user() are
expected to return -EFAULT on failure.

Another problem is get_user(v32, (__u64 __user *)p); that should
fetch 64bit value and the assign it to v32, truncating it in process.
Current code, OTOH, reads 8 bytes of data and stores them at the
address of v32, stomping on the 4 bytes that follow v32 itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 6792928ba84a..f568c00392ec 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -100,7 +100,7 @@ do {									\
 	case 4: __put_user_asm(x, ptr, retval, 4, "s32i", __cb); break;	\
 	case 8: {							\
 		     __typeof__(*ptr) __v64 = x;			\
-		     retval = __copy_to_user(ptr, &__v64, 8);		\
+		     retval = __copy_to_user(ptr, &__v64, 8) ? -EFAULT : 0;	\
 		     break;						\
 	        }							\
 	default: __put_user_bad();					\
@@ -198,7 +198,16 @@ do {									\
 	case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
 	case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
 	case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
-	case 8: retval = __copy_from_user(&x, ptr, 8);    break;	\
+	case 8: {							\
+		u64 __x;						\
+		if (unlikely(__copy_from_user(&__x, ptr, 8))) {		\
+			retval = -EFAULT;				\
+			(x) = 0;					\
+		} else {						\
+			(x) = *(__force __typeof__((ptr)))&__x;		\
+		}							\
+		break;							\
+	}								\
 	default: (x) = __get_user_bad();				\
 	}								\
 } while (0)
-- 
2.20.1

