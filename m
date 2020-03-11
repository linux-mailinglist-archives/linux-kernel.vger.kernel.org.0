Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF5181FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgCKRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:41:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39305 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCKRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:41:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so2468547lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCN3ckDZYTgKsnmWN3MWB/SQ8UiGeh+NLtW3p106h1c=;
        b=YSCkVqVocKNnlqDlgiECoEadYMt16n+8MdHbaK6Gz4V/6O09UsUL+qmuweL0ZNYT2i
         Sr+AidQV9hb4/BL4It5d/F0SRAJZtYfVSGXINNlDJSfUWwK0NTXRvpGwgZRmxC5/f8Gy
         rsjNb5cScHJ2Hv2E8KQjB7u3AijuPnYd/xZas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCN3ckDZYTgKsnmWN3MWB/SQ8UiGeh+NLtW3p106h1c=;
        b=cmS7MhIuexeB7VNmqMHeOy0cphWdQN0ETZyM29hpuukpI8qSXznbg0YCrK+JK2WVOw
         OsJYmewOxx3mJmzfgnr8PfzIr0koPuct58dIHxHouOo33ZrWht+aFKA/YQaHjda5jQsI
         5JEJ9nmg27T1yZsac8PpJ7Mb9ykGIL8EfWTRq4GFAlmqX7VeOkrnlqGzGUfMzEx5wpTO
         bjtY3McFahpICw/KH4/GOEzOO/lURYVXascMU1VW90lUtfi6ucU/phmikH9aJZXTHeLe
         HozyL68YVCgr5Ve9cnmQKo0RkKyGaUAzD8UW94LAnuUtszMpSt0xSr/5jnrPsazk5L1H
         jYdQ==
X-Gm-Message-State: ANhLgQ2ddqWArp2JvjuPzk4+o2Tk6ed7CCIgnT9rDR2rDch57hVzjFUj
        PJpIPyr/IZ/2DuQLd5grxQdonQGJZl0=
X-Google-Smtp-Source: ADFU+vuDpeWxXTsbVkBhSHld6Gg5hgerbrEVTh001y4cMA3pUdroimkWvQdo73d67fCeLpgsVNTCDA==
X-Received: by 2002:a19:915b:: with SMTP id y27mr2810946lfj.127.1583948498299;
        Wed, 11 Mar 2020 10:41:38 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m24sm30947298ljb.81.2020.03.11.10.41.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:41:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id w1so3322964ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:41:37 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr2584551ljd.209.1583948497068;
 Wed, 11 Mar 2020 10:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200311162735.GA152176@google.com> <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
 <20200311173513.GA261045@google.com>
In-Reply-To: <20200311173513.GA261045@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:41:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
Message-ID: <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:35 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> I actually merged the last three patches which were introduced yesterday.
>
> Others were merged over a week ago.

No, three were done just before you sent the pull request, and then
seven others were done yesterday.

Yes, the rest were a week ago.

But basically, by rc6, I want to get the warm and fuzzies that the
code has been tested, seen review, and isn't some last-minute
addition.

               Linus
