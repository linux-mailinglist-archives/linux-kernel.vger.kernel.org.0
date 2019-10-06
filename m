Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0237BCCD5F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJFAHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 20:07:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJFAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:07:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so10054413lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ0vvkhrhw2X6n/kDoFhkGHBcz5tnb8C5tNHlfE7BeU=;
        b=SfGlFFoyKKUI8igiv5lDWCKr3UL3AjRt/lV+7TxAWQ0zrg2aZKr9szbeAEDx1WvDSg
         ex5t+wvF42EA1RdR97sdtfv067dP5Ii5YCN7oQxiXQAjbhsLfNdk7I6Z2mu1txBKJTSr
         djuKiXJmWD/WaOcuEGu6i0/a+BJ1hMdC0yLII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ0vvkhrhw2X6n/kDoFhkGHBcz5tnb8C5tNHlfE7BeU=;
        b=EOIeDZH8H+IvO8CVSrdX6kQs5oWxqSe9Y9ACs68truWzoK5vHrOsJYe/r7EkZ+st/n
         43yDgGYnrDwRODc27+lSvbkemj2dnNsANVlvfMcxTK5x61FqcyLgfVZCpv2iGwzFxtso
         d1yCFm7U2lPzXj9NlaPJhSyA9bfDKbI1a9OUoQNMZR/NdOPfHDJaDMKB2sebA62KPS0I
         JqFmg1z9nQAiacGScyKF9pTXmpePdvz/w33ndGNmaWbBCI9uym8Zv1BSUV6EzJDly2D8
         t15TgtfULBVcfmWJpBkwL5iPskd0wij9WFb3YHRT6lXanzQvWuX2AbqI3ULA2YY4WNB0
         ApRg==
X-Gm-Message-State: APjAAAVWdHeBzznjYn9R4LQfmd2oUS2v4WUUbG89hsDufwdNavz0c7Oj
        04GexO5LIAUgIzV1U+b4L8/paJQlRJ4=
X-Google-Smtp-Source: APXvYqxqLqWtGFGXOcnFtGGO+UBpIrUwqT/mKJl18S0JiVvLmhXFlDaXbN2RJLeAYzFvd7yMFzWCiQ==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr13494324ljb.47.1570320418361;
        Sat, 05 Oct 2019 17:06:58 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q14sm2138801ljc.7.2019.10.05.17.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 17:06:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v24so10045122ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:06:57 -0700 (PDT)
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr14140095lju.26.1570320416860;
 Sat, 05 Oct 2019 17:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191005233227.GB25745@shell.armlinux.org.uk>
In-Reply-To: <20191005233227.GB25745@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Oct 2019 17:06:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS5uyVNR23sWFk6a1nOXO0wkLh3qttoKNmkGAcV1hOXw@mail.gmail.com>
Message-ID: <CAHk-=wjS5uyVNR23sWFk6a1nOXO0wkLh3qttoKNmkGAcV1hOXw@mail.gmail.com>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 4:32 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Under a 4.19 kernel (debian stable), I am surprised to find that some
> previously working i386 binaries no longer work, whereas others are
> fine.  ls, for example, dies with a SEGV, but bash is fine.

Hmm. Is this with some recent stable kernel update? Or has it been
going on for a while and you only noticed now for some reason?

If it's recent, I'd be inclined to blame bbdc6076d2e5 ("binfmt_elf:
move brk out of mmap when doing direct loader exec") which afaik made
it into 4.19.75 and might be in that debian-stable.

And if it's that, then I think that it should be fixed by 7be3cb019db1
("binfmt_elf: Do not move brk for INTERP-less ET_EXEC") which is in
the current queue.

Adding Kees to the cc, in case he goes "No, silly Linus, you're being
stupid", or can confirm that yeah, that was the behavior for the
problem case.

Kees, original report with more information at

   https://lore.kernel.org/lkml/20191005233227.GB25745@shell.armlinux.org.uk/

And if that isn't the case, maybe you can send over one of the broken
binaries in private email for testing?

                       Linus
