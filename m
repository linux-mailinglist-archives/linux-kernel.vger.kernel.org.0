Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B9BB1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407443AbfIWJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 05:56:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40313 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405175AbfIWJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:56:51 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so31854302iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RVgREEtnY7K1Q4RqEFR226fjeu69yeEhgWmLQQ1HSI=;
        b=bXBOVmO9x51Zeb1vvbz+vROZa/zxo6m/j9+fhWU3iYEUhBW+tRhHBCj5EcvGdGHOE7
         RyRWRgMzzVGhIXUJJsFWM8XP4FhBptfPxGYmugcvOizueRaMiFAIvw1f16Oq/2HINvQ+
         rBbM7lH4yeRKpEWewjKe4BxjXyYENOZ7ca9VTaVVrb0ZlwSiI2LRf70LHe9AItCITmMn
         9h+1ZnjcYoDhUUpeBd5g61NY6tt+av9Mnb3/XFSP4ZxcBsPVZtJgTt95SEGMx/QtoHnI
         Bkb7iN7y0yjQjyY+n1rPBlhzCz+M2JFHl/TJDFdO0kt0qt0Y0RaXrLGvU42UVNY1f06C
         VWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RVgREEtnY7K1Q4RqEFR226fjeu69yeEhgWmLQQ1HSI=;
        b=qPc5lPn51Wh9soPz8k6fTKJ6v3iyCWHlrNsicj6c39LbbjvfifLrSlzbr0CqE8/vw7
         H+3PhXqsmX1jOiNeU+HZMDGUO++9BNOV2A4CToSZKAjvqeVD765alA6EF8qGw4dizluG
         zceD88XCH3BmJM6B4YKwnNXUG2mLGHbenhilzmSR2W43revdal/QMVsiC3Ob6DMswIKJ
         b8tOrwwLnahbEfCUSWGthWTw2TJJWlSAR4/o7qeND75RbhBBhKUJG6TTDbZkaoxduod1
         wKAz9XWosCfzkc+86zU0QVttQIyBehjIr+AouAsAENNJ2ZH5xSWrPXrLu6qButlzFZha
         7ehw==
X-Gm-Message-State: APjAAAViAzrjiJYqGhmzH3JcmFFXtugNTkIPL6q3fv9cWaHqpFfnIO/a
        qegrYOTgUlCcnLUDbKEtn+YrQ+QgTJd++Hjzsbk=
X-Google-Smtp-Source: APXvYqxGoKclm6T821IxCLJucK7Nvbhkem6415ZtQLZWjIFbauOnrrsRXTu/LboV91eUGR4OpybVkOpRXt7P3TBYmhU=
X-Received: by 2002:a5d:8b07:: with SMTP id k7mr28249575ion.20.1569232610529;
 Mon, 23 Sep 2019 02:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190922083342.GO13569@xsang-OptiPlex-9020> <20190922150328.6722-1-alexander.kapshuk@gmail.com>
 <20190923091934.GA15355@zn.tnic>
In-Reply-To: <20190923091934.GA15355@zn.tnic>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 23 Sep 2019 12:56:14 +0300
Message-ID: <CAJ1xhMVrbAYi2=2L1Tt5qdOWGPHgo_htMZTZQVjJyWNTda2z+w@mail.gmail.com>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:19 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Sep 22, 2019 at 06:03:28PM +0300, Alexander Kapshuk wrote:
> > This patch fixes the regexp warnings shown below:
> > GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> >
> > The ':' and '&' characters need not escaping when used in string constants
> > as part of regular expressions.
>
> How do you trigger this?
>
> I don't see it in my builds so it looks like environment thing. What
> flavor of awk is yours?
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

gawk 5.0.1-1 on Arch Linux.
