Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B9A9E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfIEJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 05:28:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45004 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfIEJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:28:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id u14so1660437ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pd2UPdvvD+h9euSH/b2Ha6i1J1cxWWmD8DxQgZdlMow=;
        b=Vfqvh8VB+TQCr/1YAAh44tR0CTOoHwLGtsFVHlH5469opXykcUm4yQoii3AHfUtcMO
         7KE9sdAXgWDrJg65gILD23+hUkm8AqoRtjTlTgiz8aw/1ni5z0aI/5f8CHn25HG/C23N
         msR2psKpN77/WoO/4RD5cdMuV4Bs0MHiN+NrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pd2UPdvvD+h9euSH/b2Ha6i1J1cxWWmD8DxQgZdlMow=;
        b=MrSogpwK3YGd9tzq6LTGlMK9XWGATmk+4SpWiy+z9nYrM9dxXewQU2Zk3q62rUdLf2
         cwDt85B/oCRD7lGgtWllIj7x2U6RkQQlBizPMw86iAdKADPIDLFaJMUkunPiQKb9yo6N
         +NVnYcqZsXW+6QrwqzCwGn9KbtbVdkdq5OkMQssyLfXXsGVMJRWsZUydKAjud/gQ09UE
         +k1z/cTmMp4xGIvN/JR+DQhhOyupJC6qcrn+pSLuMqZsev1nUWNIsNRyS3H6cETFH3ze
         TfCe/EM5SiTYhZV0h1bbdbhFze9gjNltB8IUqVx1Q/8B6sfSU0dL7e4ifniLIwYn9tsq
         eJqg==
X-Gm-Message-State: APjAAAX0Omh/usCoZvok1osNArXDA30hY+Ldj5KXZkd9mdOcdZGjLuHo
        Sp0sw10YjrAL0ZFlDdykdQYDMw==
X-Google-Smtp-Source: APXvYqx/z14ur2ox4B55jBpMZwFWwALPiBFomhx0uNpuKNrvsgKUOnh1BLWsBCocl2vzNU0/VtqfrA==
X-Received: by 2002:a2e:8651:: with SMTP id i17mr1414517ljj.136.1567675731031;
        Thu, 05 Sep 2019 02:28:51 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p8sm274392ljn.93.2019.09.05.02.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 02:28:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] lib/zstd/mem.h: replace __inline by inline
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-3-linux@rasmusvillemoes.dk>
 <CAKwvOdnZE7pCTykwjX_DDh0wKcUAVKA8eSYXSUFWG2e3swFEJQ@mail.gmail.com>
 <CANiq72kQb7VYBnfho_joF3p_-vi24WgYETE19EO3Ou6T5ixLew@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f6ab2429-eb08-b723-221a-9b2ad62bc284@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 11:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANiq72kQb7VYBnfho_joF3p_-vi24WgYETE19EO3Ou6T5ixLew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 02.07, Miguel Ojeda wrote:
> On Thu, Sep 5, 2019 at 2:00 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> While you're here, would you mind replacing `__attribute__((unused))`
>> with `__unused`?  I would consider "naked attributes" (haven't been
>> feature tested in include/linux/compiler_attributes.h and are verbose)
>> to be an antipattern.
> 
> +1 We should aim to avoid them entirely where possible.
> 
> We have __always_unused and __maybe_unused, please choose whatever
> fits best (both map to "unused", we don't have __unused).

Well, I agree in principle, but was trying to keep this minimal. FTR, if
anything, I think the __attribute__((unused)) should simply be removed
since it's implied by our (re)definition of inline/__inline/__inline__.

Rasmus


