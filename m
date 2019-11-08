Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C75F4C10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKHMrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 07:47:10 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38583 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfKHMrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:47:06 -0500
Received: by mail-qv1-f67.google.com with SMTP id q19so2124007qvs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTqKyPLMoNlwQUs9dVtYz5L4wwqhRY74FJdzJmWrwA0=;
        b=UUups4bA+gcaJ1l+Nd6ZGTUX3rFaeLICUHtmkV/le2cS7mAAuhyfMyOLWpYmwXzDx7
         yM893cc1+Y1nEIcrLVmiQlr4y6NN8VG2ndwMC2iFr1l8qPZV2zVMkLHf8EWxJmdtA6FL
         f6fNaYc0Hccl26yWKoHsMAHcvQwQ6kkaYMv1GG54Qz1nYW/knE9oT2P772wT7mszKshd
         P17/iPg8qoTTklI6w8bAu2JOJEBfwwhb8SwZyMZntmG3sYwo6pvQZyE0sxgvW7KhlAS8
         7ere4RUdrsBgxo6FULOjvW7zaMvCFM/W4C+zkh4lqF4jMOMSzsbPAMqtsYKBLv77/JrQ
         jlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTqKyPLMoNlwQUs9dVtYz5L4wwqhRY74FJdzJmWrwA0=;
        b=MlvlQotfZqk176ASDR3pg3pifRAkEnuEyQEaBiWzKhabESGrXWLvzZOo7NBftF51oF
         VKgr/Y/6daJfI2kOSGQ8HjO4vs+J/vIciB11Eyak3EZV/QGLZoRWekYqfMFxXUm8AgIZ
         iH1GDu/0PskARZEkpK+gRpFtbwYRxlKD+mC/CQo2WE0BrvxI7BvCRQ3ff4JFS6zQMe7p
         DLoEpdNufJ13bchgXc71TpULNc0c6f9PbwE5+rbQFUd7xS3C/h0lhcS30/TPgAKxiGEX
         QiE0O7vAi2Ppw/1zncu30NlZZH7fZvtibYTgoUdWtGyx4apGlz2D0qDqo6uf4xdotjDh
         1ALA==
X-Gm-Message-State: APjAAAUuC2b86PvYlJ5pJ0+dqFDsfyycFc5xLVuM3+gGqKA/gYuGZ5Vw
        Z80BprXVFhr2dC82kAu7PtZFCihydj7tuDXBmRzGMw==
X-Google-Smtp-Source: APXvYqxCe/56vC6QLtn1Arg66NFTCzut/4d957zjBpTBXodKzOQkny/ob2ZlhDKsoW9vso6E7C4wsDttAbdBmYHmvCM=
X-Received: by 2002:a0c:c125:: with SMTP id f34mr8874671qvh.22.1573217225193;
 Fri, 08 Nov 2019 04:47:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f19676058ab7adc4@google.com> <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
 <20190611185206.GG3341036@devbig004.ftw2.facebook.com> <CACT4Y+ZNTh=t62oj_Y5XyQwjOJp3AWwWi8c-4DrX+jKNCVqzzg@mail.gmail.com>
 <20190723163126.GB23641@gmail.com> <20190724174129.GE213255@gmail.com> <20190724174315.GC569612@devbig004.ftw2.facebook.com>
In-Reply-To: <20190724174315.GC569612@devbig004.ftw2.facebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 Nov 2019 13:46:54 +0100
Message-ID: <CACT4Y+ZcELcq0+V5_6yzto2V_TjiH8cWMJRuuALAY-J8Y-3P6w@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
To:     Tejun Heo <tj@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:43 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Jul 24, 2019 at 10:41:29AM -0700, Eric Biggers wrote:
> > The real boot error "general protection fault in dma_direct_max_mapping_size" is
> > fixed in mainline now.  I believe that unblocks syzbot testing, since it doesn't
> > appear to have been blocked by "WARNING: workqueue cpumask: online intersect >
> > possible intersect" by itself.
> >
> > Anyway: Tejun and Michael, any other ideas for why "WARNING: workqueue cpumask:
> > online intersect > possible intersect" is still happening?
>
> That code hasn't changed in years.  It gotta be changes in cpumask
> initialization ordering or sth like that.  The easiest way to find the
> culprit would be bisecting.  I can't get to it right now.  Anyone
> interested?

syzkaller will now ignore this warning as it happens on every boot and
masks all other boot problems:
https://github.com/google/syzkaller/commit/31b7aac4626757ae0862971db78aaa1338541227
syzbot will never remind about this again:
#syz invalid
