Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85F195C16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0RNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:13:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:39589 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0RNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:13:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02RHCc49019619;
        Fri, 27 Mar 2020 12:12:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 02RHCZQx019618;
        Fri, 27 Mar 2020 12:12:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 27 Mar 2020 12:12:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH]     x86: Alias memset to __builtin_memset.
Message-ID: <20200327171235.GI22482@gate.crashing.org>
References: <20200323114207.222412-1-courbet@google.com> <20200326123841.134068-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326123841.134068-1-courbet@google.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 26, 2020 at 01:38:39PM +0100, Clement Courbet wrote:
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -12,7 +12,9 @@
> 
>  #define JMP_BUF_LEN    23
> -extern long setjmp(long *);
> -extern void longjmp(long *, long);
> +typedef long * jmp_buf;
> +
> +extern int setjmp(jmp_buf);
> +extern void longjmp(jmp_buf, int);
> 
> I'm happy to send a patch for this, and get rid of more -ffreestanding.
> Opinions ?

Pedantically, jmp_buf should be an array type.  But, this will probably
work fine, and it certainly is better than what we had before.

You could do
  typedef long jmp_buf[JMP_BUF_LEN];
perhaps?

Thanks,


Segher
