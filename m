Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57919B483
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbgDARHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 13:07:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41809 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDARHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:07:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so229728lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRrcqK5cfaNO7OpHqvvvRe3Ztegq+35dbp3U2NLv1c0=;
        b=G9FMkwedR3xk+FnQzgPlV2dbisol5n80kNiGY5ot7hx3A6H4kpC93ptTcVIYdDw16C
         kX1A3/EauPB/cc1mAo+0tIJH71iQ5jnG+59+9pInTUw4F+JLBhBqW+igtJzqgr5eY4/o
         15FFI6ROfbv8hGMmdpInKNl5WV+UZ2ozcWH8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRrcqK5cfaNO7OpHqvvvRe3Ztegq+35dbp3U2NLv1c0=;
        b=Wf825AtiUaDoKJAJ2eoETyoojx8UsQKlQZlzEoeAUtJq1mRTQDtRWHc8BU0hKvMvU5
         PGCHKjMUMuDAkG50KD/YYsfQo6PdAn57BZfHuVCAEa26R1WDlfAoIuei8HjMuGOgBLLE
         f6SZ4O11d7hvJZlAWVYtySzKELDinehWDrzzlVju/7V2gn9rDJOWUyBp1Xj1CUcIHGhV
         G5sEVt0k32FsgGEm9//COmQ8o+/JXaeztljQ/y1lhxWX3P5ao3YjOenmKMTV0lsiuQe2
         nMwx3PapFf5rM7qp0nKoHcWr6Vommh48llpzCwoUl6Gj7X2ftEZE8NtKG0MPWLKET2TR
         /3YA==
X-Gm-Message-State: AGi0Pubk76xOuIQJtcux8bukO/WJ0htBN3jOFNQMY7A+LNuBuGUhLhKQ
        Smu09PXW2Uy9H8z+BbVgeIhb/4dR07g=
X-Google-Smtp-Source: APiQypJjqthml/nKUqx78AurGTSEkYq24XxY9/mIKID/go9mXg5SxxR1x0aGtPiPjNs4OU/JelBL5g==
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr8807249lju.73.1585760825165;
        Wed, 01 Apr 2020 10:07:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id l7sm2136373lfg.79.2020.04.01.10.07.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 10:07:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r7so191706ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:07:03 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr12738802ljc.209.1585760823439;
 Wed, 01 Apr 2020 10:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200401161413.974936041@linuxfoundation.org>
In-Reply-To: <20200401161413.974936041@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 10:06:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVBvO1b5UzfcHm6y4KLHOp3huFfGMdW21F6g25oUePLw@mail.gmail.com>
Message-ID: <CAHk-=wiVBvO1b5UzfcHm6y4KLHOp3huFfGMdW21F6g25oUePLw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/10] 5.6.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:19 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.2 release.

Good. You made 5.6.1 so quickly that I didn't have time to react and
say that it makes little sense without the 802.11 fix, but you're
obviously making 5.6.2 quickly, so..

That was just horrible timing. David's email to say "holup" came in
literally _one_ minute after I had sent the 5.6 announcement: my
timestamps for that unfortunate thing is "3:51 PM" for my 5.6
announcement, and the email where David says "Meanwhile, we have a
wireless regression, and I'll get the fix for that to you by the end
of today" has a timestamp of "3:52 PM"

(Ok, so me actually tagging the tree and pushing it out happened about
half an hour earlier, so it's not like it was quite that close, but I
found the timing of the almost-crossed emails to be funny/sad).

                       Linus
