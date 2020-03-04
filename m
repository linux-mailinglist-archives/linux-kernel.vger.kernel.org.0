Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5A1797BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgCDSVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 13:21:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42473 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbgCDSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:21:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id f5so1359833pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xF2I7tf+DwxpQhNciBVkWhhaWOLjPvYzGL3E90sj2so=;
        b=EtH+RNLzhqY+QqYdV6X7ap6Xu3EpSaat18+ckZb/mOfySU0ooqa/9cKD/lI/wgqztb
         ZK2Ma6j1qv5DcakHHIlnNCH8JvP6u0Ga6Lxhnp2OX/arBJTY2+8pgH3SNyBm7i2VIJ2k
         nN0QThNn3RyhAFc+q1sXxzjkc/ZdjOgh2+oOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xF2I7tf+DwxpQhNciBVkWhhaWOLjPvYzGL3E90sj2so=;
        b=uDu4MwZIy1ZQga8/7PS1cnkMrLSxALQyry1Jq8YZ1Ca7yLeOop2JWEq5RHlncYavg5
         kNDd5X4gsXwIIOvrGdxyQiyyjw8q6v31WoTTpMrhIYRaMLJEN3QDfmLC7Dn/hIvRrfjf
         jqeiAfRZMYijz7N6iD0JcquKrs5yXPExIQPuwIzBfw4UotFnBBebllynestQk5+/QcBK
         JikfGLiAauSeAP0+QYc22vseJuBtMnCMDdMqIZVsNhBqhibHfYBqvMAR1PbeFYIZFF4o
         qB7W4rYupoMV9zcXCjW4iExI2VKM1FGZgNZ2dKJTLpnhYkAlYk4VHdubgg0/ZmoslqZR
         A20Q==
X-Gm-Message-State: ANhLgQ0WTYTkE1l6JJJizVl1hcjRJ/E139iqy7OSbSlpSKLJlPOYW2R1
        l119VEoLTu47rLqknFBWRuOvSQ==
X-Google-Smtp-Source: ADFU+vuGalFADUNS2CsAir9E+YeLAVnzSZsmifwLoGDru8DbnpAUozLyZDUnqEqdqAQL4AUGpiCQNw==
X-Received: by 2002:a63:ed14:: with SMTP id d20mr3606078pgi.267.1583346110401;
        Wed, 04 Mar 2020 10:21:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m59sm3603815pjb.41.2020.03.04.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:21:49 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:21:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <202003041019.C6386B2F7@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
 <20200304092136.GI2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304092136.GI2596@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:21:36AM +0100, Peter Zijlstra wrote:
> But at what cost; it does unspeakable ugly to the asm. And didn't a
> kernel compiled with the extended PIE range produce a measurably slower
> kernel due to all the ugly?

Was that true? I thought the final results were a wash and that earlier
benchmarks weren't accurate for some reason? I can't find the thread
now. Thomas, do you have numbers on that?

BTW, I totally agree that fgkaslr is the way to go in the future. I
am mostly arguing for this under the assumption that it doesn't
have meaningful performance impact and that it gains the kernel some
flexibility in the kinds of things it can do in the future. If the former
is not true, then I'd agree, the benefit needs to be more clear.

-- 
Kees Cook
