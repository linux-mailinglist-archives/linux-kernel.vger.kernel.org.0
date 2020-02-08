Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB591567E3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 22:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBHVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 16:54:16 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45899 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBHVyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:54:15 -0500
Received: by mail-lj1-f173.google.com with SMTP id f25so2949632ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPRUC0erzur+fCv10BXW9++FTy8YMFKB88RgyaNIfpk=;
        b=Zw4MTrebv51YooV7DzIouvDHfMw1ldmX1mbYpJOoYfvcWD9qaaWekoVo/MycILOHrb
         nm56S5ioO+x13LhtYZJpdHslRT3+k2nG46wr/MqKt9GnWBONZ77O2q3R0p+y1N7RYDGU
         AJWr1Z1sx7HpXPF8q0KzUFBiu1Vo9hG/xQX3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPRUC0erzur+fCv10BXW9++FTy8YMFKB88RgyaNIfpk=;
        b=WfFQ2wKTitCbYa4XgOYEzXI7LY29I5fA/iCVD4O6V2cGZMNFiv2J2+nWsDM1gntX2e
         N384jcBYt3oJ33sRRGwTp3vPBIngpusBVDTnybT3TiqMcewdNq1KQHqTtVZJ/2rrV8Xe
         Fe/5U4ZBEM2pd2UoOKxtGMWGN3Vq8I7c/FonVtyTXI5jTn/Zmp3mc9udEt+oLt+jPcuQ
         vdhywpBZzZOXGhylgbP+IRsFPiNeen/Ck/D53zK8ZP23NnUtoDs80Rowb4pIqExJUn9D
         oYTh4y5Yxc38u50Y8hzopWxVZuxmsvJedcNTImf0Vkm8Yf7Dmgd3Q06xPPfpBOwFXISQ
         SKmg==
X-Gm-Message-State: APjAAAXhB43UISVSG1GQbRDkV8WR7hdzZs7BAINn52s6Ex0u/f7BZgFn
        cN5sNFp8uMsHg1IYJZ/hmwHFHo4SgZE=
X-Google-Smtp-Source: APXvYqznyGz0lBPtqYt5eaCjQ21BYOm1E7j2mN2n9m5VGm7d8xbr9WPIocmx2STvM0tOo//b/ui1SQ==
X-Received: by 2002:a2e:b5b4:: with SMTP id f20mr3679522ljn.112.1581198851780;
        Sat, 08 Feb 2020 13:54:11 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a22sm3656623ljp.96.2020.02.08.13.54.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:54:11 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id f24so1635537lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:54:10 -0800 (PST)
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr2680418lfl.125.1581198850384;
 Sat, 08 Feb 2020 13:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20200208083604.GA86051@localhost> <CAHk-=whWe0tY3aDraTk_Wesj8PMH+=U=W3VTE2aJCHNE+u+WTw@mail.gmail.com>
In-Reply-To: <CAHk-=whWe0tY3aDraTk_Wesj8PMH+=U=W3VTE2aJCHNE+u+WTw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Feb 2020 13:53:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk4Mm-s0zG4CMmudjGU-fytmrhS=VCGx+RBr_rJ0ORbQ@mail.gmail.com>
Message-ID: <CAHk-=wjk4Mm-s0zG4CMmudjGU-fytmrhS=VCGx+RBr_rJ0ORbQ@mail.gmail.com>
Subject: Re: Applying pipe fix this merge window?
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 10:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sure, I'll apply it and see if anybody hollers.

Btw, can you verify that commit 0ddad21d3e99 ("pipe: use exclusive
waits when reading or writing") matches what you've been testing.

I did put a "tested-by" for you in it, but I had a few different
versions of that patch because of other changes in fs/pipe.c and
because I did it while doing the other changes, so maybe I should have
double-checked with you first.

                Linus
