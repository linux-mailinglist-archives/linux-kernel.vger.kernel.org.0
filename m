Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08784122401
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 06:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLQFn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 00:43:28 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:19542 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfLQFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:43:28 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xBH5h6wC022242
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:43:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xBH5h6wC022242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576561386;
        bh=qQlc5Ro8wDeQWPKm2SsGvTW8C4QA5rE2v5XCyCUWRBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=20lcx/6cwME+SfU5YkuVJe1qhH0wxI4ciHJ7xSWhLWhirlN2akRiZ7ItBat2HB7dQ
         R31/qyICcD3sjGhjhVY5j/fnkfZt0GPLgjKEe9QNGdYF8I2VIyxJWQdM2ARk+0Wsxv
         VM/uMWQhD0LaXlTPeg6dWe1SG7+1A7JMCdIkoW/j9IlxUmmICTS+GhUi7qanpdlZUD
         e/hdALtDeHX9EhHnu4rafUPpejoDeiJsjhN8CL6pKgYiTDwGrKiNiN2A4V8KoxU54W
         oBxpwXvz60LqOIwfK0v6SMrJgZo0eJO3snOFRJvXpbbZiAbescgJvkA4Jxd6g46YYh
         gmbE5xO8lnjBA==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id f8so5724200vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 21:43:06 -0800 (PST)
X-Gm-Message-State: APjAAAVAdWCihNbI/sPRi/svPFHSCzmKzlU3Z8x+BIDTmSLaT1gm6haE
        AFztS6nIc2MNlm4EnBvAIPkYkINxZJe4gtr5UHk=
X-Google-Smtp-Source: APXvYqxKY96fmFqHP8F1QWGJorBNkq4yOR+pUb3l4J4YQ3eh1yS+cicTeym5VbD1A6dGcFoFkgnY5aSnT1PS+ELH9wY=
X-Received: by 2002:a67:7ac4:: with SMTP id v187mr1773547vsc.181.1576561385534;
 Mon, 16 Dec 2019 21:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Dec 2019 14:42:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDO-q_v9M-F=azTgg+nazPCs9KdcgLcOxT_C+jW4fEUQ@mail.gmail.com>
Message-ID: <CAK7LNASDO-q_v9M-F=azTgg+nazPCs9KdcgLcOxT_C+jW4fEUQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 7:01 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>

Please do not use the subject prefix "kconfig:"
unless you are touching files in scripts/kconfig/.

Thanks.


> While syzkaller is finding many bugs, sometimes syzkaller examines
> stupid operations. But disabling operations using kernel config option
> is problematic because "kernel config option excludes whole module when
> there is still room for examining all but specific operation" and
> "the list of kernel config options becomes too complicated to maintain
> because such list changes over time". Thus, this patch introduces a
> kernel config option which allows disabling only specific operations.
> This kernel config option should be enabled only when building kernels
> for fuzz testing.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
-- 
Best Regards
Masahiro Yamada
