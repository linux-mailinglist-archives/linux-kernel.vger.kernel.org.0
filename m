Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7599EB86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfH0OvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 10:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfH0OvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E98633084499;
        Tue, 27 Aug 2019 14:51:04 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 580AA64020;
        Tue, 27 Aug 2019 14:51:04 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:51:02 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190827145102.p7lmkpytf3mngxbj@treble>
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 27 Aug 2019 14:51:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:30:06PM +0200, Arnd Bergmann wrote:
> I upgraded to the latest clang-9 snapshot from http://apt.llvm.org/ today.
> Many problems are fixed, but I still get tons of warnings like
> 
> arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool:
> mtrr_type_lookup_variable uses BP as a scratch register
> arch/x86/kernel/process.o: warning: objtool: get_tsc_mode()+0x21: call
> without frame pointer save/setup
> arch/x86/kernel/early_printk.o: warning: objtool: early_vga_write uses
> BP as a scratch register
> arch/x86/kernel/sysfb_simplefb.o: warning: objtool: parse_mode uses BP
> as a scratch register
> arch/x86/kernel/head64.o: warning: objtool: __startup_64 uses BP as a
> scratch register
> kernel/time/timeconv.o: warning: objtool: time64_to_tm uses BP as a
> scratch register
> kernel/trace/ring_buffer.o: warning: objtool:
> ring_buffer_discard_commit uses BP as a scratch register
> ...
> 
> I created a reduced test case:
> 
> $ cat crc32.i
> typedef unsigned u32;
> long a, c;
> u32 b, f;
> u32 *d, *e;
> void fn1() {
>   u32 *g = &f, *h = e, *i = d;
>   for (; a < c; a++)
>     b = i[b >> 8 & 255] ^ h[b] ^ g[5];
> }
> $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> crc32.o: warning: objtool: fn1 uses BP as a scratch register

I assume your config has CONFIG_UNWINDER_FRAME_POINTER=y, since objtool
is doing frame pointer checking.  Though I'm not sure about that, since
I don't see -fno-omit-frame-pointer on the reduced clang command line.
Do you still see this warning with -fno-omit-frame-pointer (assuming
clang has that option)?

-- 
Josh
