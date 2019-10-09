Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECFD18AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfJITVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 15:21:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51958 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:21:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIHWD-000215-PY; Wed, 09 Oct 2019 19:21:05 +0000
Date:   Wed, 9 Oct 2019 20:21:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: fix {get,put}_user() for 64bit values
Message-ID: <20191009192105.GC26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, on short copies __copy_{to,from}_user() return the amount
of bytes left uncopied, *not* -EFAULT.  get_user() and put_user() are
expected to return -EFAULT on failure.

Another problem is get_user(v32, (__u64 __user *)p); that should
fetch 64bit value and the assign it to v32, truncating it in process.
Current code, OTOH, reads 8 bytes of data and stores them at the
address of v32, stomping on the 4 bytes that follow v32 itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
--
diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 6792928ba84a..155174ddb7ae 100644
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
@@ -198,7 +198,12 @@ do {									\
 	case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
 	case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
 	case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
-	case 8: retval = __copy_from_user(&x, ptr, 8);    break;	\
+	case 8: {							\
+		__u64 __x = 0;						\
+		retval = __copy_from_user(&__x, ptr, 8) ? -EFAULT : 0;	\
+		(x) = *(__force __typeof__(*(ptr)) *) &__x;		\
+		break;							\
+	}								\
 	default: (x) = __get_user_bad();				\
 	}								\
 } while (0)
