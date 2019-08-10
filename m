Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C756E88EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfHJWvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 18:51:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHJWvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 18:51:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 465cm81cblz9sN1;
        Sun, 11 Aug 2019 08:51:19 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     segher@kernel.crashing.org, arnd@arndb.de,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-4 tag
In-Reply-To: <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
References: <87imr5s522.fsf@concordia.ellerman.id.au> <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
Date:   Sun, 11 Aug 2019 08:51:19 +1000
Message-ID: <87ftm8skgo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ expanded Cc ]

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sat, Aug 10, 2019 at 3:11 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Just one fix, a revert of a commit that was meant to be a minor improvement to
>> some inline asm, but ended up having no real benefit with GCC and broke booting
>> 32-bit machines when using Clang.
>
> Pulled, but whenever there are possible subtle compiler issues I get
> nervous, and wonder if the problem was reported to the clang guys?

Yes, sorry I should have included more context. It was actually the
Clang Linux folks who noticed it and reported it to us:
  https://github.com/ClangBuiltLinux/linux/issues/593

There's an LLVM bug filed:
  https://bugs.llvm.org/show_bug.cgi?id=42762

And I think there's now agreement that the Clang behaviour is not
correct, Nick actually sent a revert as well but I already had one
queued:
  https://patchwork.ozlabs.org/patch/1144980/

Arnd identified some work arounds, which we may end up using, but for
this cycle we thought it was preferable to just revert this change as it
didn't actually change code generation with GCC anyway.

cheers
