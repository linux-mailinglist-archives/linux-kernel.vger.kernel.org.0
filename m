Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A4ACF21
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfIHNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 09:55:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41484 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfIHNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:55:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so8445995lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sF4vWdoCClkvUWmjG7SmHm1u0cF208Pq+GV3iOlmbEI=;
        b=NH6YvOJSA9BJfe/rK/M7Q6vmL9hZIe9PTLc+Y+OMDga80Q/mee05priLhuNAkAUkSz
         DrsUwg4SDM1aGyMx82DnFOxjPj1ss713Rbztz7ExMqNR7ylXtnymBcAUftlrMvEKo6Dm
         mMJnh5q7MKqwES2oTvbszAwrHAu+mQdRnh345RvbVsujxWUPSpi4cJFQ21nd/8yHZyGM
         HNDCM6uTyCNUp83BFOh0nnUbapnrvbjZecH9/yLUh9nmswm0Di10QUR17VxsM1Wg+5Y3
         05QA/4KgLlLkQ/GWvrbM1hoZ6oRLBOwxXGieCxhavj/+t0Yzr8FzBCB/nVGWN4YDHxGq
         0sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sF4vWdoCClkvUWmjG7SmHm1u0cF208Pq+GV3iOlmbEI=;
        b=lQ7xVlZIt9uNFaZ5pzxe7ssFpeA+GtBQcbhlf4ts0Fkm88vaUXStcSeLFYdeJZ2YpU
         minvDud3E6SXLvyozXw/r/nDaEQ2XrD9QznDaxJ23YpDkjlsUFZSZdx43rlaxBlYKIMn
         ddoXpTswT3xlPT2dgyWuDPNHqinMQT4dcHrU4ZLrbAd3Bwrx/W1PCWHVTxSe3F36xhrP
         1I4MV/q7UB+0FOd4TiLAu16d8WgQ1e6fRFufgRF9T4fMoewSPwTi3miS3hGbdFJQHXyH
         xNNRpjUZs8TXNCD4mYydd+FIaMguR7CQBQ4R6spWQx/YCIFSrHXcI+sJt1x82LsG04I2
         aFnA==
X-Gm-Message-State: APjAAAXdiccctJ9UUFaoJGm7Zq1/X8Vgi1tuMV2XJtZQeW88Fs+Q6DbX
        1bcP8vd2qfP+e8sMZQkkvBHyUMm/I7aYdfhjrig=
X-Google-Smtp-Source: APXvYqweWXLeq4LzhqyDNqliYFHtyK9Rz1+KwlfjzswVUbkk6p/lViBjVMzcjWYmwtJjzoQcn1znEGBtnYAE1wlsJvo=
X-Received: by 2002:a19:428f:: with SMTP id p137mr13288714lfa.149.1567950945057;
 Sun, 08 Sep 2019 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
 <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
 <20190906225606.GF9749@gate.crashing.org> <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
 <20190907001411.GG9749@gate.crashing.org> <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
 <20190907131127.GH9749@gate.crashing.org>
In-Reply-To: <20190907131127.GH9749@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Sep 2019 15:55:33 +0200
Message-ID: <CANiq72=qXM=jEULGsWup+AtUTMTd_T-LHLY8iNna5y+zN3E6UA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 3:11 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> I wouldn't.  Please stop using that straw man.  I'm not saying version
> checks are good, or useful for most things.  I am saying they are not.
>
> Predefined compiler symbols to do version checking (of a feature) is
> just a lesser instance of the same problem though.  (And it causes its
> own more or less obvious problems as well).

That is fair enough, but what are you suggesting we use, then?

Because "testing to do X to know if you can do X" cannot work with
source code alone and implies each project has to redo this work in
its build system for each compiler, plus each project ends up with
different names for these macros. The C++20 approach of having
standardized macros for major features is way better (whether we have
one macro per feature or a __has_feature(X) macro). Note this does not
mean we need to take this to the extreme and have a feature-test macro
for *every* feature, bugfix or behavior change as a macro.

Cheers,
Miguel
