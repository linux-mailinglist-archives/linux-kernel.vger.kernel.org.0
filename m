Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DCAAA9E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfIERWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:22:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37119 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbfIERWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:22:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so3344496lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmlyESraaU291QJUIsvfH7FyXZWDE8ub8JEIcxQG6sE=;
        b=eGZQuxs3EB4CKkRcVzaZkG91ZTsthu/3MCVcUAmI19FZDHyPEOG/eMEjOa8IU9oMKM
         DId//Vm4d5y/ai/hVwmOo3zUhrnEE0ufsvGcEZnKqGrqqiIHMpCuHu0lcWna7aTLEbez
         WrsriTiHVIUjQpHi25iBaTgzUOdcaZL3QNQhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmlyESraaU291QJUIsvfH7FyXZWDE8ub8JEIcxQG6sE=;
        b=OznF55SvfH76eXDMAF28NyuO+syPDFYFvgza5hMHinw6D/prnZV9MIzIJuGM5JRBnf
         DIMphnF8jAV/VPIbymTdydj81KtU4nhsS8qXNHgg3C5cD1ZgVUWuk33mfQHpbfswwNuD
         xa9WFUbst3WpdMkMOquy62+aLM5UA2SFnZqszj8YVv5T/pPsW/LpbzANoA382HtWtFNZ
         nrWeNpgx2sg1NXvaZgbE4b6yB8s87/9ZiP5ZufecJIwPLTIMfVqFswhk3pKw+cgfOZpO
         I4cFVFgmGqO6hILNPxoENdjSuuGxz3piE954poVu6TV+kh/VrC96fr/WNZokER7pMWE7
         LdaA==
X-Gm-Message-State: APjAAAWKq0+DMQKIBaBym2vni9nKQv9GaD4mUuB2quq7/8kPiJ/mZmHy
        nYoMvMO/il4Q4eoA+vYp8oatupYFCNE=
X-Google-Smtp-Source: APXvYqxv4R7OQCWciR0kcU2A5k6Q4WDhAfrcXXpB4ybokDT9nUJiQ0+NH0RVXMOTPKo1tO/aTK8vQQ==
X-Received: by 2002:a2e:974c:: with SMTP id f12mr2922029ljj.15.1567704169666;
        Thu, 05 Sep 2019 10:22:49 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f8sm484583ljm.44.2019.09.05.10.22.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:22:48 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id r134so2665533lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:22:48 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr3219447lfp.134.1567704168405;
 Thu, 05 Sep 2019 10:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CAKwvOdm3CbZ1Uad4b8+9HU8qDgTwSFw2oqjcAvFkR8jaQQN-5g@mail.gmail.com>
In-Reply-To: <CAKwvOdm3CbZ1Uad4b8+9HU8qDgTwSFw2oqjcAvFkR8jaQQN-5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 10:22:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBsC0bWrCy++Gzimwwfx2+3kSaac9_PbBWmH9hrWdC8g@mail.gmail.com>
Message-ID: <CAHk-=wjBsC0bWrCy++Gzimwwfx2+3kSaac9_PbBWmH9hrWdC8g@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:18 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Please consider picking up just:
> https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755
> That lone patch is the one that fixes the particularly observed Oops.
> The rest are just cleanup; if I made that change in the more important
> patch, why not clean up the rest of the instances in the kernel?

"Why not just clean up the rest" is how bugs happen.

If it's not a fix, and it's not marked for stable (or a regression
from the merge window) it shouldn't go in this late in the rc period.

Send me _fixes_. Don't send me stuff that is "fixes plus random
cleanups that were noticed at the same time".

                     Linus
