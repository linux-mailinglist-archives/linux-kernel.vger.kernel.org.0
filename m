Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04BB3153
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfIOSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 14:20:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38687 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIOSUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:20:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so4913747lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrx+rbVytk1GGn4jWtFZwhssNYPhIpzI4TMimWuxSyw=;
        b=ccPfpqqjUeN2rABSaF7iKNlS/7FTAmmDKkLrqbpdKqkInR+KAi26lrmix3dztSANXn
         HgEdzA0vuh5P1FUpbHUCoMq8juCAeWVwbKNctjy7DfbAYKEKgN9WjNoYLGGwdQfnNa9S
         L32W7xJp1bRCTfvCUih2EL94dhUTaumC7G6855FJQ9OpLHbY8WDLqCrVLhgRDizuPbDS
         cNzf2PrVNuWJToKxvcqlMDlNBt6GYzmfBhYygH1LjeS1USv7WaFkFFAevwehWlm9fwWG
         0DnQRqqJXP5CFKFNmmvrk+HHYIC4jWgoPBYB2VP2QgEYiMctdPENaAy5IqHZr8NS/DRP
         ZyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrx+rbVytk1GGn4jWtFZwhssNYPhIpzI4TMimWuxSyw=;
        b=GCJgR7gULBDrpY8MJnlOgSY+FcJb5Ye0FhC60Dx3GRIRmRHRU49e4zV/3Scjs9AhdS
         lJfAkKJw88T3grbKmn6UiCymYaaREkjhSIczrk9p6wVO+OfpNelRPx9RVD45b6ivTf+F
         1I8pL5IiDYODrfdSkmH4qef4eksxVta8TnxK4PJ13AMtffLtNld6gGZm/MFCwDfo+Bfw
         SNP6oNVRtTNb29uh7DtO0MP1UedSM+N8p2eA9h602TLY7Ppibx8Z769a3urNEH1f+HfN
         t+6TnXQtIpZxqeAdgVclqPBeMpD77x6xq66VXOcRpxiMSUBnn9cweo7WzmhiGpz4Umyu
         CHyw==
X-Gm-Message-State: APjAAAV9SFHXIzuJS+nODTWD6KZbEKnyaBNJ4AAowlgLEIDqlRfuRj8N
        j/KEia0s/yS7IrwZCB1J3uKIH/DKv8r+D0QoGJ8=
X-Google-Smtp-Source: APXvYqzAgczLDnQgzt9L/ZOmPZbxTpd6MFJREYg5+pWZF4LPYPU/arY67PJx4iTpqOOvDico7SAmsbn4ROhckEZQIsE=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr35788618lfr.133.1568571630406;
 Sun, 15 Sep 2019 11:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk> <CANiq72n_KxKGwrN4onWotocTuZjVSAqENF_5Pk9t1-pk7NDrgQ@mail.gmail.com>
 <d47740cc-a373-91a9-df33-d2def69a370d@rasmusvillemoes.dk> <20190913152117.GA458892@kroah.com>
In-Reply-To: <20190913152117.GA458892@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Sep 2019 20:20:19 +0200
Message-ID: <CANiq72mxqugDLLYJ10VfBr75rt_p8kPDbDx9pDb2WOiqqpgtGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] make use of gcc 9's "asm inline()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 5:21 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Feel free to also take that patch through any tree, it's "obviously
> correct" :)

OK :) Picked all 6 in compiler-attributes:

    https://github.com/ojeda/linux/commits/compiler-attributes

I added Ingo's Acks and fixed a minor typo (has -> have) in the 3rd
patch commit message. It will be in tomorrow's -next.

Cheers,
Miguel
