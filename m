Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56D36BE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfGQOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 10:38:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:46008 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:38:37 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6HEcEwG003587;
        Wed, 17 Jul 2019 09:38:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6HEcCZK003586;
        Wed, 17 Jul 2019 09:38:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 17 Jul 2019 09:38:11 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-ID: <20190717143811.GL20882@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au> <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnma89ak.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:15:47PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> And it's definitely calling ar with no flags, eg:
> 
>   rm -f init/built-in.a; powerpc-linux-ar rcSTPD init/built-in.a init/main.o init/version.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o init/do_mounts_md.o init/initramfs.o init/init_task.o

This uses thin archives.  Those will work fine.

The failing case was empty files IIRC, stuff created from no inputs.

> So presumably at some point ar learnt to cope with objects that don't
> match its default? (how do I ask it what its default is?)

The first supported target in the --help list is the default, I think?

$ powerpc-linux-ar --help
 [...]
powerpc-linux-ar: supported targets: elf32-powerpc aixcoff-rs6000 elf32-powerpcle ppcboot elf64-powerpc elf64-powerpcle elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex

$ powerpc64-linux-ar --help
 [...]
powerpc64-linux-ar: supported targets: elf64-powerpc elf64-powerpcle elf32-powerpc elf32-powerpcle aixcoff-rs6000 aixcoff64-rs6000 aix5coff64-rs6000 elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex

$ powerpc64le-linux-ar --help
 [...]
powerpc64le-linux-ar: supported targets: elf64-powerpcle elf64-powerpc elf32-powerpcle elf32-powerpc aixcoff-rs6000 aixcoff64-rs6000 aix5coff64-rs6000 elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex

$ powerpcle-linux-ar --help
 [...]
powerpcle-linux-ar: supported targets: elf32-powerpcle aixcoff-rs6000 elf32-powerpc ppcboot elf64-powerpc elf64-powerpcle elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex

> > Then again, does that work at *all* nowadays?  Do we even consider that
> > important, *should* it work?
> 
> Yes and yes. There were a lot of bugs in the kernel makefiles after we
> added LE support which prevented a biarch/biendian compiler from working.
> But now it does work and we want it to keep working because it means you
> can have a single compiler for building 32-bit, 64-bit BE & 64-bit LE.

Good to hear :-)


Segher
