Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC690108C31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKYKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:10 -0500
Received: from ozlabs.org ([203.11.71.1]:38755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfKYKrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:07 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d43gCcz9sRD; Mon, 25 Nov 2019 21:47:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 77693a5fb57be4606a6024ec8e3076f9499b906b
In-Reply-To: <f4984c615f90caa3277775a68849afeea846850d.1568295907.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] powerpc/fixmap: Use __fix_to_virt() instead of fix_to_virt()
Message-Id: <47M3d43gCcz9sRD@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:04 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:49:42 UTC, Christophe Leroy wrote:
> Modify back __set_fixmap() to using __fix_to_virt() instead
> of fix_to_virt() otherwise the following happens because it
> seems GCC doesn't see idx as a builtin const.
> 
>   CC      mm/early_ioremap.o
> In file included from ./include/linux/kernel.h:11:0,
>                  from mm/early_ioremap.c:11:
> In function ‘fix_to_virt’,
>     inlined from ‘__set_fixmap’ at ./arch/powerpc/include/asm/fixmap.h:87:2,
>     inlined from ‘__early_ioremap’ at mm/early_ioremap.c:156:4:
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_32’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> ./include/linux/compiler.h:331:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^
> ./include/linux/compiler.h:350:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^
> ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^
> ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
>   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
>   ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 4cfac2f9c7f1 ("powerpc/mm: Simplify __set_fixmap()")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/77693a5fb57be4606a6024ec8e3076f9499b906b

cheers
