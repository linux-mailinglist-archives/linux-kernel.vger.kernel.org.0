Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA6AAC20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfIETlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:41:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35105 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbfIETlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:41:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so3042921lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJUpH7JNx+QyGcA5IT2Vw2BI9I3pIMcGsARhre7L0Do=;
        b=sEIc4JfDFF3MpmoMR03SEZouh/1kTTPUc4UyqOugO5qBOSaSE8DM8OR/0Y4yWi1nGQ
         NVxNuK91fh6/3PHMu2iUEYkkWfi6jgh/JFD6Xmuhs5eXMxpkZTaYKTjyrUZVEjd5Kmhe
         nsaJASmWVXFydNrnSzeR89KDYCFDRkbcl8qPdVSbFnoAwPXAhqTlKOShZdftnwIS/V/w
         b436wIFhasS0dmhe/+BRgrQ4N4ZZfH0HfIJtp4TULfhNnZYn+jLYtOUSwH5pPyfYlD5E
         caGf5+tjyfG1qz9pBj2Iun4AO1fouVmDH9Twgd+0wpO4uyg3QWMs9Szu32u1kjAs6TRh
         h9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJUpH7JNx+QyGcA5IT2Vw2BI9I3pIMcGsARhre7L0Do=;
        b=qBawHEw+BQYAKKdFlTjHOxGVME//C284OiU3fDxje7IyTbFGYc6rzcldENTXW2QBS1
         rHtE50B9nDM4kIQWkxiKa3x0DgkSwfZk/7w0NB50iNslSk0c9J2pvzmij6Tabuop5k8a
         +xDsh4tugsEbXaDePnl5qlB2lQzx/HmbbUBVppSwxoHQMGfD76mpBdK0dCu5LQy+0B5m
         KLMyuWgXHUBgZlBPYrx1uMl0kIjZiPjDowEaINCF0/0RhJC2tel5R0zC5Z3h4DQIstJO
         c1EpMoiqNxlfRsogcNwIMGSJjcGh1e+0kDxsJAwBAgjgtFcJx9Sox5kWXPHUxw1Vc6HI
         8Ewg==
X-Gm-Message-State: APjAAAU3Bim6pX/XavmeULiMwAulzSyWYMSFrdKIgtewj8x3Qjo1Csem
        7VJoGi0bHG7c0G/hw70WRzUgQhQjj+xEofv8Ico=
X-Google-Smtp-Source: APXvYqxTK3M1IDN+QWg0j8gzSf61J+m+XGtAyumHkHKdMaPDnb5CBBtaLOoqyfX7h0ZS5RxVSevr7Li+teKfKis2XjQ=
X-Received: by 2002:ac2:52b8:: with SMTP id r24mr3784339lfm.131.1567712461849;
 Thu, 05 Sep 2019 12:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
In-Reply-To: <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 21:40:50 +0200
Message-ID: <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Sep 5, 2019 at 6:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Macro stringification isn't entirely obvious, and an unquoted string
> could become corrupted if the stringification ends up not happening
> immediately.

Nick, Linus: shouldn't we just simply go for no stringifying at all,
i.e. changing it to:

    #define __section(S)   __attribute__((__section__(S)))

That way we can handle both easy things like:

    __section("foo")

as well as the mentioned:

    __section(".initcall" level ".init")

that we couldn't do before.

Both GCC and Clang give the same result and it is also easier to
reason about it.

Cheers,
Miguel
