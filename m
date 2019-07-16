Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3B6A885
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfGPMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:15:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbfGPMPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:15:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nzrL2TGxz9sDB;
        Tue, 16 Jul 2019 22:15:46 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
In-Reply-To: <20190715072959.GB20882@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au> <20190715072959.GB20882@gate.crashing.org>
Date:   Tue, 16 Jul 2019 22:15:47 +1000
Message-ID: <87pnma89ak.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jul 15, 2019 at 05:05:34PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > Yes, that is why I used the environment variable, all binutils work
>> > with that.  There was no --target option in GNU ar before 2.22.
>> 
>> Yeah, we're not very good at testing with really old binutils, so I
>> guess we broke that.
>> 
>> I'm inclined to merge this, it doesn't seem to break anything, and it
>> fixes using --target on old binutils that don't have it.
>
> But we don't set the target any other way either.  I don't think this
> will work with a 32-bit toolchain (default target 32 bit) and a 64-bit
> kernel, or the other way around.

I think it does, but maybe I'm misunderstanding.

My test setup is:

  ~/linux$ export PATH=/home/toolchains/ppc/gcc-8-branch/powerpc-linux/bin/:$PATH
  ~/linux$ echo "int test(void) { return 2; }" > test.c
  ~/linux$ powerpc-linux-gcc -c test.c 
  ~/linux$ file test.o 
  test.o: ELF 32-bit MSB relocatable, PowerPC or cisco 4500, version 1 (SYSV), not stripped
  ~/linux$ make CROSS_COMPILE=powerpc-linux- -s ppc64le_defconfig
  ~/linux$ make CROSS_COMPILE=powerpc-linux- -s -j 320
  ~/linux$ echo $?
  0

And it's definitely calling ar with no flags, eg:

  rm -f init/built-in.a; powerpc-linux-ar rcSTPD init/built-in.a init/main.o init/version.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o init/do_mounts_md.o init/initramfs.o init/init_task.o

So presumably at some point ar learnt to cope with objects that don't
match its default? (how do I ask it what its default is?)

> Then again, does that work at *all* nowadays?  Do we even consider that
> important, *should* it work?

Yes and yes. There were a lot of bugs in the kernel makefiles after we
added LE support which prevented a biarch/biendian compiler from working.
But now it does work and we want it to keep working because it means you
can have a single compiler for building 32-bit, 64-bit BE & 64-bit LE.

cheers
