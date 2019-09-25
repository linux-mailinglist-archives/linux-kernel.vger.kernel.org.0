Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56296BE468
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408452AbfIYSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 14:13:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36072 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407511AbfIYSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:13:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so6680690ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRbAjoylre9NlfBO8BTIZTcAtpx4/BimOoVlxjcab3A=;
        b=RgsNfsczHYhjvCLBROtPtLM/H6+B+uvZ0JZAmKUTL8vx5b+5Msq9BuI/ssv3TZeicD
         ZroPWSJXfD63y6d4x0mq/4x/A34lOMaYIBNZCaVCrazpWITBqw+LjtY7dX6fRMKxbco1
         5Q4v89fff+oZ1ZC0vffbhrIPOES+t8XyK7sRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRbAjoylre9NlfBO8BTIZTcAtpx4/BimOoVlxjcab3A=;
        b=aZEjDttnuxPvswAgHEE4TBD5Q1/sdUqTZBzeTwOdKpyv1PNi0OhTgjga4g2geCEmMP
         S2r0f47XlF5HYuTFRVNMwyC0n7pNxIVL7ZjfwvGxjTpgkhyY5nBOM9CUyh+ERQr9zfiJ
         29izKQHsI69wishDgAUoi5wsI7RTcEGGb23J3JIEMat7OpYDOCHDtxI1VGjhlkVD6jYN
         1IiQS4RjyBGT64jIEGS4UGXCBqxmhzCUJUI2jvfw1Ik2INySWHapEthUvQOiYhLJ9bho
         6hu6eNkJKspKm8OQ4jxbPv/Jy+4vR6irKc3DP1blWhtcn57mUSKJV8AYeOYRdA/8vqMJ
         f+Dg==
X-Gm-Message-State: APjAAAU5kHi/b0LDUAFSCZCe0RvLHttzLRam6CKL0KJWs33L3zQJz5Oq
        zSmCByzQEYYPMiX2MS4EwTVZafkmy3o=
X-Google-Smtp-Source: APXvYqxtHfniLkQwuINaBSY2ZkgveFF0ekxlOnh2z3IohivDjfxMiVyCYhK0vBbQTTTiXycVi8RpOw==
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr7245276lji.86.1569435216614;
        Wed, 25 Sep 2019 11:13:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b7sm1286819lfp.23.2019.09.25.11.13.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m13so6647515ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr7476687lji.52.1569435214002;
 Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin> <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
 <20190925180412.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20190925180412.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 11:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
Message-ID: <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> IMO it's better to lift reading the first word out of the loop, like this:
>   ...
> Do you see any problems with that variant?

That looks fine to me too.

It's a bit harder for humans to read because of how it reads the word
from user space one iteration early, but from a code generation
standpoint it probably is better.

So slightly subtler source code, and imho harder to read, but it looks
correct to me.

             Linus
