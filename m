Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2508616EBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgBYQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:43:03 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:38948 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbgBYQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:03 -0500
Received: by mail-qv1-f45.google.com with SMTP id y8so5972848qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xWi/9e1OaiwFM4i35gtevHs9CA+8xzjQ1Zdw1He22t8=;
        b=p5ax+pu68L4yDa8Rb02Wz5ZMUM2UTdFw1zCwZW+4sZA/dJSp3tqZMgy0h8epmTOoEC
         cj3LqkER9z9qGy7mu3Uxk+u6CGMlj12DmZYCLw9JnBiwxvyTYhlO0vbDoZW8EhV18Z0b
         ALkYvuVf2GAXNeba5xzOUo51Sd1yPITs3LuLZqUqY0iSOVUE0/66qPPGnJXQVRszwyiU
         bi9O4QCGoh0zGfBPYu/ABLMObZNPaXOjLLMs8bdH8m3JwLquvgcGpJaRzse4JSV7L4AQ
         nt8QVqqtARCOvo2x/ypHxBEqViJxSI/O79q5Il7WnZ3oRFr8RJA1CbIleUEn3rdz/Uss
         0ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWi/9e1OaiwFM4i35gtevHs9CA+8xzjQ1Zdw1He22t8=;
        b=aStwn7ZAYXvHjMnjviBcMERB9ZX+XuelFXsSD/F937bnVwOhxqGaGtbukKC+KewywW
         x9ZfFvrtvwFNb17fz15lg30UDvXXjYFTFY8u8knuAbGOINU0asWakJsPWa+JytESPxpV
         whgVugjzzlRByxv4jsd+LzkS6IiLvixhhJzHmaepP1dezOZKdxteAaHkVSCZQheo8ADa
         YTkflY+9R2KQepT3UK87xeR0tsWvipUgISECJdO1+xtBbRXA12WR6EhUS9vQ3ILdJCxT
         ak8m2Qj6V/gvwdlmmAH7urt0Z/YpL16x/qL1zRqyne/4BeebuGJbyssMLcKvYqqDcKZr
         P2Ew==
X-Gm-Message-State: APjAAAVJVx3HMXXRfyLAiKtIAAKOdbtSzNdBH/o3tBUO8ba1k4J7uqtv
        nQudGuNkCAnEaErOYnSSmuk=
X-Google-Smtp-Source: APXvYqxmf+K3H61L8TKyXebN9Q3zDwIAmfwx8vfyEY8S8VnzhGBcctovfA0tIGQlJRpB6Hilf0S3hQ==
X-Received: by 2002:ad4:496f:: with SMTP id p15mr48863886qvy.191.1582648981318;
        Tue, 25 Feb 2020 08:43:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n5sm2391799qkk.121.2020.02.25.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:43:01 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Feb 2020 11:42:59 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>
Subject: Re: --orphan-handling=warn
Message-ID: <20200225164259.GA1029742@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002242122.AA4D1B8@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
> On Sat, Feb 22, 2020 at 03:20:39PM -0800, Nick Desaulniers wrote:
> > Kees is working on a series to just be explicit about what sections
> > are ordered where, and what's discarded, which should better handle
> > incompatibilities between linkers in regards to orphan section
> > placement and "what does `*` mean."  Kees, that series can't come soon
> 
> So, with my series[1] applied, ld.bfd builds clean. With ld.lld, I get a
> TON of warnings, such as:
> 
> (.bss.rel.ro) is being placed in '.bss.rel.ro'
> (.iplt) is being placed in '.iplt'
> (.plt) is being placed in '.plt'
> (.rela.altinstr_aux) is being placed in '.rela.altinstr_aux'
> (.rela.altinstr_replacement) is being placed in
> '.rela.altinstr_replacement'
> (.rela.altinstructions) is being placed in '.rela.altinstructions'
> (.rela.apicdrivers) is being placed in '.rela.apicdrivers'
> (.rela__bug_table) is being placed in '.rela__bug_table'
> (.rela.con_initcall.init) is being placed in '.rela.init.data'
> (.rela.cpuidle.text) is being placed in '.rela.text'
> (.rela.data..cacheline_aligned) is being placed in '.rela.data'
> (.rela.data) is being placed in '.rela.data'
> (.rela.data..percpu) is being placed in '.rela.data..percpu'
> (.rela.data..percpu..page_aligned) is being placed in '.rela.data..percpu'
> ...
> 
> But as you can see in the /DISCARD/, these (and all the others), should
> be getting caught:
> 
>         /DISCARD/ : {
>                 *(.eh_frame)
> +               *(.rela.*) *(.rela_*)
> +               *(.rel.*) *(.rel_*)
> +               *(.got) *(.got.*)
> +               *(.igot.*) *(.iplt)
>         }
> 
> I don't understand what's happening here. I haven't minimized this case
> nor opened an lld bug yet.
> 

At least for the relocation sections, they cannot actually be discarded
because we build vmlinux with --emit-relocs (at least for x86).

However, attempting to collect them via for eg
	.rela.all : { *(.rela.*) }
while using --emit-relocs works for neither ld.bfd nor ld.lld, just like
discarding doesn't work. The original .rela.<section_name> sections are
always output. ld.bfd doesn't warn, but ld.lld warns that these are all
orphan sections. I think these warnings would have to be suppressed to
make --orphan-handling=warn useful with --emit-relocs.

It seems like lld needs even .symtab, .strtab and .shstrtab (and
.symtab_shndx -- not sure what this is as it doesn't actually appear in
output) to be explicitly in the linker script to avoid warning about
them. Maybe these should be suppressed as well?

For .plt I think you just forgot to discard it. I didn't actually get a
warning for iplt, and the one for plt goes away if you do add it to
discards.

Not sure why there's a .bss.rel.ro section in the first place -- surely
the bss can't have any relocations? But that can be removed via discard
as well at least.
