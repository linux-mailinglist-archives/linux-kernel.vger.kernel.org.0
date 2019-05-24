Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D144F29D93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfEXRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:55:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40305 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfEXRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:55:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id q62so9408375ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWCvHObwGGnl514eTOvG7mJaLj5V9zOWmMT/E7dnKsI=;
        b=Xwwsep4i0rpnf/7n+tJI8yjEc4uvnaw0dE4fZg5+q0sel/9wEFRkSbkKeHEXrp0c1p
         /0J6eYdZEo18DnQ/FPowbYaq1vGtjsdjCoKHAh1UEhm+1QG7uJyKwv/6lx5r9/r+9eR0
         RNMGcl0xovTWCSnYPsW6FdaSU8wuabdEoyQ54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWCvHObwGGnl514eTOvG7mJaLj5V9zOWmMT/E7dnKsI=;
        b=OXpAmI2HDP9SOChyfgVfqvhAvqGijMufeRE5M4SV7BAMQ4i/esL8/VPTMAHFpYP2ng
         zFbTYAoGQiyTbroUSQhyj78/IWOUZbzhZaC+GsFc0TusAdm00I7CSReRKKaOfNW/iSda
         jLbgVrrfrIYI2OzGKegTzqZ6Gv8jTVyCYQExiAI65jQIH19CeUrOoRYPGBhXzoy1mrKl
         exUxFd6pgHCInHbS+YaGv7Qfrh4RvBvea59eyaXh6SwGufvZOwemHrRI9kywdzUCM4hn
         0FZmC76jTqW5rre060N4gvAPJT4T2QF9D9WwCvOOwrViMLN8gHRmK6WeZwR6S4J0lM6u
         21dQ==
X-Gm-Message-State: APjAAAXqk+V6PNfB66CpKNM+s/yNw6pkqpu6SM3CZXz5e7yDF0apRERa
        0xAh0CQJrSAveAhzEM9gn9IRZ/MuNAs=
X-Google-Smtp-Source: APXvYqx5gHKv6pXp1Y03Hl7l0896yRr53f7NBY5/UORDkGW2GpDjvcHqyEUCJJrkM+aidejRGPTJcg==
X-Received: by 2002:a2e:404:: with SMTP id 4mr766994lje.203.1558720529145;
        Fri, 24 May 2019 10:55:29 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h15sm738761lfc.21.2019.05.24.10.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:55:28 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m15so9369920ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:55:28 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr39853365lja.44.1558720527949;
 Fri, 24 May 2019 10:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com> <bc58c62d67f60678c980539fb3259683ea8bd21d.camel@perches.com>
In-Reply-To: <bc58c62d67f60678c980539fb3259683ea8bd21d.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 10:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnZ5T8ri+ghVFE0xK2kdBVyhtUoiKtaM7+zQRgZWNMHA@mail.gmail.com>
Message-ID: <CAHk-=wgnZ5T8ri+ghVFE0xK2kdBVyhtUoiKtaM7+zQRgZWNMHA@mail.gmail.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:41 AM Joe Perches <joe@perches.com> wrote:
>
> That could also help eliminate unnecessary pr_<foo> output
> from object code.

Indeed. The small-config people might like it (if they haven't already
given up..)

              Linus
