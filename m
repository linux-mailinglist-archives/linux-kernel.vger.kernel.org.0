Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA754E7210
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfJ1Mri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 08:47:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37167 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfJ1Mrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:47:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so11191931lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43kMuxdcCYrw75OLEIGgvwzIRnKZbO0/qUIAHUs9fjA=;
        b=cSff5S6yI6dM9Egn5nfRqiok4k+70KNtQ3WNH3IFY088k4NXJ0NPflQG3OPr/taxkR
         xUEu/NkPtLE3zKEmQ7IjUCeeOc/9Hp5IaxSHYqvykCfrbI+eUodqR/b3+Jt0SEG2pKNN
         mNt1URIKmIq+awJoY+ucdy0NXoIrExTx+dTRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43kMuxdcCYrw75OLEIGgvwzIRnKZbO0/qUIAHUs9fjA=;
        b=Z7901D75mK9Bojy/HlErJppFyVvS6VgnyU4Ms3vHa2P78r5n2Ww0G39fdDU6EKpb5m
         r2dEhFe58xDe+VvHHYpPVX7/dcdfvjs1uRX/IjGk+RSk4keyhFoETA71lG/PseppQjUh
         6Q6Zps+xAJfvMb4+4CP6NWDF9P9lq2aJlsqZaa4z3+cxeMeyuHSdzEIC0eXY6AlTPYhF
         WUj6Is0Epe+mD8IBvdGpMadHKECCc4vl7PTjh7ic8fRRxMVbBBHra2gem4yuciZA9XbS
         lJF8R0Zm78Nk6+7RE+0NvfF8E+0cshVBFlzWle434hCO46Aq0FPJjEPEg8ynZo8rB1PA
         A29Q==
X-Gm-Message-State: APjAAAXeXAZXQD+kUAuRNW6w/WHdpiE7RuMayII1VOSG8IezbfJ3tAaf
        FI8Pyn1h6ZwPQRrnTAwH8NShMMDGPTBL1A==
X-Google-Smtp-Source: APXvYqyBoTl4Wqb3qqyB3Q2iSe+pOrgQbZOnMzxA2PtCdjuiZVmMAI/cIEkNrkxbnwUQEN/Itzk7eA==
X-Received: by 2002:a2e:547:: with SMTP id 68mr11796096ljf.150.1572266855011;
        Mon, 28 Oct 2019 05:47:35 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 77sm10092042lfj.41.2019.10.28.05.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:47:34 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s4so10302890ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:47:33 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr11792488ljp.133.1572266853717;
 Mon, 28 Oct 2019 05:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz> <20191028124222.ld6u3dhhujfqcn7w@box>
In-Reply-To: <20191028124222.ld6u3dhhujfqcn7w@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:47:16 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
Message-ID: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 1:42 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I've tried something of this sort back in 2013:
>
> http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com
>
> and I've got push back.
>
> Apparently, some filesystems may not have valid i_size before >readpage().
> Not sure if it's still the case...

Well, I agree that there might be some network filesystem that might
have inode sizes that are stale, but if that's the case then I don't
think your previous patch works either.

It too will avoid the readpage() if the read position is beyond i_size.

No?

               Linus
