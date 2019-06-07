Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D851B39406
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfFGSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:11:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42727 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfFGSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:11:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so2290878lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AvJFyeYPhoZ4OqCr1dphehPV0ub1oVxmCWbJKgWsTI=;
        b=d315/RM0DaMH44my3nNzmVmEhTs+nmHZuuQf+pKqz9YU+VjDMhvTt+Yvh514Ss3VZ3
         osVtbUYyVCFBmdkSg2kW5jq84b2tec/7sH0g88lborkaDjwnEQCiquJ2Gjh042t4qJRK
         O0Z2hoSc9g3XgDPMu2hQ/afW7OGSyKvzIuScc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AvJFyeYPhoZ4OqCr1dphehPV0ub1oVxmCWbJKgWsTI=;
        b=IweXGZxTUxHm9CnQFvgyIpXsdclsQxRHGDCo4Sduyb/Woq3DVqOdh5iRj0DNWyUYM+
         I3FAhRCFGLFXJ3WWs6arSqTYiqXa6phCJ9KKrbGbhdAA4Zu2z3Kxr0vng6PNfQcxLfqA
         RL5xzvnyGoHqtiFuSTIkHNd80diHwgIRaCkpRM0p+qIVmXqUbObe7v4FzIIodwW1/DXR
         pnmVcmRBhBa1CO2ro203h/bTdBJJqeAZTYS4qfdhl3u1QKR1WFQNrmzxZROroRZQYYb/
         hl9aPuEP3zw64PvoPgSxAIMD/rKX1DtKmQb+sWytZEAL4GEvGnXa88Jd+RrdSkJy1JGi
         3cbQ==
X-Gm-Message-State: APjAAAXduAUM6W5sApCLp9KdecB97UOzwme+l6Oce+c0pwF9LNx4ft+r
        qrMSBZH+37x6hShdky9zf3RGO2typaA=
X-Google-Smtp-Source: APXvYqx8cVOQ79CyCGTqUqxFRdO2FIWJu6DIMl0oabzw4xWwkD/qEvutCoIr3T53DYXhJlPUP4aSGg==
X-Received: by 2002:ac2:597c:: with SMTP id h28mr3605570lfp.90.1559931069458;
        Fri, 07 Jun 2019 11:11:09 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b4sm527602lfp.33.2019.06.07.11.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:11:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y198so2319734lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:11:09 -0700 (PDT)
X-Received: by 2002:a19:2d41:: with SMTP id t1mr27328138lft.79.1559930729175;
 Fri, 07 Jun 2019 11:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <20190606140852.GB13440@redhat.com>
In-Reply-To: <20190606140852.GB13440@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:05:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTWSra20otC3tEGrpHJL3xhUFFe0+-7bZjUpibjwKjzg@mail.gmail.com>
Message-ID: <CAHk-=wjTWSra20otC3tEGrpHJL3xhUFFe0+-7bZjUpibjwKjzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] select: change do_poll() to return -ERESTARTNOHAND
 rather than -EINTR
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 7:09 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> do_poll() returns -EINTR if interrupted and after that all its callers
> have to translate it into -ERESTARTNOHAND. Change do_poll() to return
> -ERESTARTNOHAND and update (simplify) the callers.

Ack.

The *right* return value will actually be then chosen by
poll_select_copy_remaining(), which will turn ERESTARTNOHAND to EINTR
when it can't update the timeout.

Except for the cases that use restart_block and do that instead and
don't have the whole timeout restart issue as a result.

              Linus
