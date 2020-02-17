Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66291619B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgBQSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:25:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33853 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgBQSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:25:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so9639054pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+y8jRH9et24PzZEzAuvtS6mrYS3E40060UY4DYXNlPU=;
        b=XdybOT4fn4GZR7RpSc1kSHox+vYiKKtchga8ALKVPxCgX40ZIME8RK3kjkFiNPSm38
         uveaXH2a1VHQ2Fz8wm3Du+ivcowo1Lpxla2Ucef+7rkrfw9WQw1MbzSbkIZ0bS0qkUHw
         hQg2oHMweOiuO/de7+09ohgPaxuSgSs8sarCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+y8jRH9et24PzZEzAuvtS6mrYS3E40060UY4DYXNlPU=;
        b=SIRjpIycQ/En/tu1XKJIkJhqi9T811UFfNhVjFjfE0pplaWq3k7NdnSjyKrlpRuyzL
         Uc99237SmqYrKV3mMHlEqOaYZWNkEsw7YiVJLPKBGDEGk6TBTKt6VmfwLvLUpwaogUCL
         Y4qKfyGiQ4K4FaRJi77r5xZh/qkpFDHJ+t2TNTkxWqtucAvDMQZdMuksem6nyy5GMbwF
         PofqW3FgGhVYNz0tzYHvUBSxUKsY2UkyKSrX2DuJCByosdeeYyhRi+4gu1lWLvd3/xxN
         8n9ZOh0VngPqrHGD3NfV0mZfssMD5bkIP9O0PsGbkdVezFPHc2dMWdAHEeE1bV6rxWmT
         1Ufw==
X-Gm-Message-State: APjAAAUszEsG3MWxMOTn9R22k8N6lLw+hFsT2yIvu1bzNk0axDi0pAeW
        gERbNXMWvtQdq0eNFtQ4v9WSmg==
X-Google-Smtp-Source: APXvYqxd822QciqhrEDCTSK81ganIzKlTj7DzPuTBQq+3keCMilmP9kHcrJPHvZRfEaD0zm+iJwfcw==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr372116pjb.49.1581963923632;
        Mon, 17 Feb 2020 10:25:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm1143089pfn.2.2020.02.17.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 10:25:22 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:25:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: Avoid function casting when calculating immediate
Message-ID: <202002171024.184D90B@keescook>
References: <202001291335.31F425A198@keescook>
 <92bcfdab-79df-c3f4-bae8-00116b39e015@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bcfdab-79df-c3f4-bae8-00116b39e015@iogearbox.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:51:46PM +0100, Daniel Borkmann wrote:
> On 1/29/20 10:36 PM, Kees Cook wrote:
> > In an effort to enable -Wcast-function-type in the top-level Makefile
> > to support Control Flow Integrity builds, rework the BPF instruction
> > immediate calculation macros to avoid mismatched function pointers. Since
> > these calculations are only ever between function address (these are
> > not function calls, just address calculations), they can be cast to u64
> > instead, where the result will be assigned to the s32 insn->imm.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/filter.h |  6 +++---
> >   kernel/bpf/hashtab.c   |  6 +++---
> >   kernel/bpf/verifier.c  | 21 +++++++--------------
> >   3 files changed, 13 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f349e2c0884c..b5beee7bf2ea 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -340,8 +340,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> >   /* Function call */
> > -#define BPF_CAST_CALL(x)					\
> > -		((u64 (*)(u64, u64, u64, u64, u64))(x))
> > +#define BPF_FUNC_IMM(FUNC)					\
> > +		((u64)(FUNC) - (u64)__bpf_call_base)
> 
> Looks good to me in general. My only concern is compilation on 32bit archs: I think
> the cast needs to be of '(u64)(unsigned long)' to avoid introducing new warnings a la
> 'cast from pointer to integer of different size'.

Oh, good point. I'll double-check the 32-bit builds. (I also have
another related change that I found several days later.) I'll get this
adjusted/tested and resend the patch.

Thanks!

-Kees

-- 
Kees Cook
