Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568F0D1E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 03:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbfJJB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 21:58:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56468 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfJJB4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:56:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iINgU-0002UG-Tq; Thu, 10 Oct 2019 01:56:06 +0000
Date:   Thu, 10 Oct 2019 02:56:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xtensa: fix {get,put}_user() for 64bit values
Message-ID: <20191010015606.GD26530@ZenIV.linux.org.uk>
References: <20191009192105.GC26530@ZenIV.linux.org.uk>
 <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 06:38:12PM -0700, Max Filippov wrote:

> There's also the following code in the callers of this macro, e.g. in
> __get_user_nocheck:
> 
>         long __gu_err, __gu_val;                                \
>         __get_user_size(__gu_val, (ptr), (size), __gu_err);     \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;             \
> 
> the last line is important for sizes 1..4, because it takes care of
> sign extension of the value loaded by the assembly.
> At the same time the first line doesn't make sense for the size 8
> as it will result in value truncation.

Right you are...

> +       long __gu_err;                                          \
> +       __typeof__(*(ptr) + 0) __gu_val;                        \

What would __u64 __gu_val; end up with for smaller sizes?  I don't have
xtensa cross-toolchain at the moment, so I can't check it easily;
what does =r constraint generate in such case?

Another thing is, you want to zero it on failure, to avoid an uninitialized
value ending up someplace interesting....

> @@ -198,7 +200,7 @@ do {
>                          \
>         case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
>         case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
>         case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
> -       case 8: retval = __copy_from_user(&x, ptr, 8);    break;        \
> +       case 8: retval = __copy_from_user(&x, ptr, 8) ? -EFAULT : 0;
>  break;  \
>         default: (x) = __get_user_bad();                                \
>         }                                                               \
>  } while (0)
> 
> Here __typeof__(*(ptr) + 0) makes enough room for all cases
> in the __get_user_size and the "+0" part takes care of pointers
> to const data.
