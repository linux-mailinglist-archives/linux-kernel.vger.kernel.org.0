Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4919985C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgCaOZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:25:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45485 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbgCaOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:25:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so10398215pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFezxGPsyLpYhR0ox7KaSCSsmOf9Nv4P7a8TQy3AEWA=;
        b=kui63y9FrsIxlmLnNNmwJXRNc4d5KtuCI1cHY11sSFYq2KfwtdcIa936YyorHFthi2
         u51IRjzHkfjRWkdg1nOlfPmBiFRpfWsRggkVi8wPGm7uCexv7iA+C+qluXeiGIDUXryq
         k1YhMeoXHScS5YyYxvg51WLdW+V/wYDY0fkl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFezxGPsyLpYhR0ox7KaSCSsmOf9Nv4P7a8TQy3AEWA=;
        b=nmrHlSA6nEzsyq93yDhewVFkPofAJquWxTwPUJnOMh3Uxocf2VKeEJHMXu5anIRlFm
         rUt79+lInxY6F9bvyPGd/AIcrSmBUad4Vwd6zfqyJEe0Mm5vDbukpBfkCzKuz0CY0Qeu
         RhoEM+ADnZyFLNiA1Mq5ZraX5NZIFfBHVJUanKIeSCD5GHcU/jvXqY5Dkrz9wpK3Lv9Y
         jUbcNOylSVp4dwhmpoTVZ2Wb6KuwRgLUM9xP+5AFThrRP0nkmp15tprODc7OXfUiOzVx
         HfZQ0nvjzW14fKmUQN8Et/2xwxTzktCIJtAxjXHKCIh3If/kCYjfcGQ1mGzEoKgn2cZn
         vsng==
X-Gm-Message-State: ANhLgQ2hN/yLSMKfs54LoKZ6SNnUYj4JgDUmL7dmPffrHWQdgOg6CA0Q
        ftmNuIWA/5hxkw8giAdwpmXJrA==
X-Google-Smtp-Source: ADFU+vtkTDKkSRJvhWJLA7hYxbwYlTJ0X4a7SDipA3reIPvc6zMuV2c0VM5b15ltd1k0YTjdeBT8eQ==
X-Received: by 2002:a62:8f0c:: with SMTP id n12mr18284422pfd.226.1585664721989;
        Tue, 31 Mar 2020 07:25:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v42sm11945357pgn.6.2020.03.31.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:25:21 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:27:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202003301122.354B722@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-4-keescook@chromium.org>
 <20200330112536.GD1309@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330112536.GD1309@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:25:36PM +0100, Mark Rutland wrote:
> On Tue, Mar 24, 2020 at 01:32:29PM -0700, Kees Cook wrote:
> > +/*
> > + * Do not use this anywhere else in the kernel. This is used here because
> > + * it provides an arch-agnostic way to grow the stack with correct
> > + * alignment. Also, since this use is being explicitly masked to a max of
> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> > + * "VLAs" in Documentation/process/deprecated.rst
> > + */
> > +void *__builtin_alloca(size_t size);
> > +
> > +#define add_random_kstack_offset() do {					\
> > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > +				&randomize_kstack_offset)) {		\
> > +		u32 offset = this_cpu_read(kstack_offset);		\
> > +		char *ptr = __builtin_alloca(offset & 0x3FF);		\
> > +		asm volatile("" : "=m"(*ptr));				\
> 
> Is this asm() a homebrew OPTIMIZER_HIDE_VAR(*ptr)? If the asm
> constraints generate metter code, could we add those as alternative
> constraints in OPTIMIZER_HIDE_VAR() ?

Er, no, sorry, not the same. I disassembled the wrong binary. :)

With     asm volatile("" : "=m"(*ptr))

ffffffff810038bc:       48 8d 44 24 0f          lea    0xf(%rsp),%rax
ffffffff810038c1:       48 83 e0 f0             and    $0xfffffffffffffff0,%rax


With   __asm__ ("" : "=r" (var) : "0" (var))

ffffffff810038bc:       48 8d 54 24 0f          lea    0xf(%rsp),%rdx
ffffffff810038c1:       48 83 e2 f0             and    $0xfffffffffffffff0,%rdx
ffffffff810038c5:       0f b6 02                movzbl (%rdx),%eax
ffffffff810038c8:       88 02                   mov    %al,(%rdx)


It looks like OPTIMIZER_HIDE_VAR() is basically just:

	var = var;

In the former case, we avoid the write and retain the allocation. So I
think don't think OPTIMIZER_HIDE_VAR() should be used here, nor should
OPTIMIZER_HIDE_VAR() be changed to remove the "0" (var) bit.

-- 
Kees Cook
