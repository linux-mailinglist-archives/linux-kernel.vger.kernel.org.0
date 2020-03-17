Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B47B189243
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 00:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCQXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 19:44:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43417 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgCQXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:44:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8so10318439plt.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehjo2dfhKDxoZ1Z+RY6tvGulJ8aD8GxzYz/+Nhr00Pw=;
        b=Kj2QofUvaHGoQBqYlct2ACyGM9mfQS/k0vw9WoVwlfpVZhDZBqU/O6bYjoDBwSSiph
         /aFIW7RiGubGaGNlcZsAetdGB7Lb21fygmkkqP4OH8KyauYEBdANjowKw9k3FMiPUK1s
         DCT81hSZc9XJ3r+CIeEamyvEVlHGUEatqYH6JBPj1oBayO4xyfuC5otXBa90vB1xOFrR
         jGf7lvWBZEaL5jJCHebM5hin1XHaMuqXF+eaUGZtIcTN+3mttkt90+l0OGLIkhwr3Uvl
         T7WVWMrfAPfrwl/NvRc+VuvTyQNaOkWGMWFQxVjk0mdvqOrppr4wled+aP+ch/hPaZ3B
         oLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehjo2dfhKDxoZ1Z+RY6tvGulJ8aD8GxzYz/+Nhr00Pw=;
        b=agCL5AHxpLBeoGI7eC1yHcWTCUHnzF+dh9rsvpog/w+8B/eHgDvktB/1UgHnXFZ3xg
         iGFU5grHBrolWQXdLz4THCpbRlL7EMCHY0Aj1znOD0UDZGrPyBh37X+uxVS+oq7oPWfj
         s0pNgKETaBVHwEAysaiOO0uhkPVxH1bFrIpQdjLAzOToRGK7EQAQ1YSZwUoD79s2uCxu
         W7FaUQF5thBd1LQpIkUJtaM3e4KSCAApNb4Jb/88M8cibQH6gmT0AL2PeJIFlnoxhboX
         K1ejqH1QzCBIuFfAXyyoeAGS8YbLegjXyA4ArpUP/QKhZJ4KDz6pKx4efqw8eJLFafWx
         uOvQ==
X-Gm-Message-State: ANhLgQ2DvAiJhElFeoiAyz/d2ahQiuXrNDTzc7OVBRdvVKV4XapXrT2T
        dA4GQl3L5uh6QyXIKvKlnADqL/KfQr4d9V1gOVSERA==
X-Google-Smtp-Source: ADFU+vulzZ9b/SxAYf3Mb+GtqHoNiGGHGVkLDCDSq009DOaDkBcH4B7OKIjwGUIAO2ekT07PaRu53id/5sqTqUptOCY=
X-Received: by 2002:a17:90b:8f:: with SMTP id bb15mr1553468pjb.186.1584488638684;
 Tue, 17 Mar 2020 16:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200317170910.983729109@infradead.org> <202003180747.qU4yJl06%lkp@intel.com>
In-Reply-To: <202003180747.qU4yJl06%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Mar 2020 16:43:47 -0700
Message-ID: <CAKwvOdmU57K8vRRZd0cfUve2WZXJT0ysEwi+zRTngD3VhLxm3A@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] objtool: Detect loading function pointers across noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, mbenes@suse.cz,
        brgerst@gmail.com, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just needs a `default:` case.  From personal experience, this warning
helps you track down every switch on an enum when you add a new
enumeration value.

Ignore the dtc-lexer failure, that's a separate known issue.

On Tue, Mar 17, 2020 at 4:40 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Peter,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on next-20200317]
> [cannot apply to tip/x86/core linux/master linus/master v5.6-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/objtool-vmlinux-o-and-noinstr-validation/20200318-035709
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3168392536d32920349af53bdd108e3b92b10f4f
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 11.0.0 (git://gitmirror/llvm_project 14a1b80e044aac1947c891525cf30521be0a79b7)
> reproduce:
>         # FIXME the reproduce steps for clang is not ready yet
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> check.c:2131:10: error: 12 enumeration values not handled in switch: 'INSN_JUMP_DYNAMIC', 'INSN_JUMP_DYNAMIC_CONDITIONAL', 'INSN_RETURN'... [-Werror,-Wswitch]
>            switch (insn->type) {
>                    ^
>    1 error generated.
>    mv: cannot stat 'tools/objtool/.check.o.tmp': No such file or directory
>    make[4]: *** [tools/build/Makefile.build:96: tools/objtool/check.o] Error 1
>    /usr/bin/ld: scripts/dtc/dtc-parser.tab.o:(.bss+0x10): multiple definition of `yylloc'; scripts/dtc/dtc-lexer.lex.o:(.bss+0x58): first defined here
>    clang-11: error: linker command failed with exit code 1 (use -v to see invocation)
>    make[2]: *** [scripts/Makefile.host:116: scripts/dtc/dtc] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1261: scripts_dtc] Error 2
>    make[4]: Target '__build' not remade because of errors.
>    make[3]: *** [Makefile:46: tools/objtool/objtool-in.o] Error 2
>    make[3]: Target 'all' not remade because of errors.
>    make[2]: *** [Makefile:68: objtool] Error 2
>    make[1]: *** [Makefile:1787: tools/objtool] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:180: sub-make] Error 2
>    10 real  23 user  18 sys  399.16% cpu        make prepare
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202003180747.qU4yJl06%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
