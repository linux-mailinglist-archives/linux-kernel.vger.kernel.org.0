Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE0199DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 20:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCaSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 14:09:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:09:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so23041802ljm.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpcU1t/tj2H7Six2K2HSWdYqKvP0QvKRCjffYNTRF6M=;
        b=IRuW3sJFV3v7Crj6ckeoeLi2iD+L6VjNn2QCDu0AHs1i3B7V11GyDgS9G3ngpEMw2Q
         e4Md+z08evDJ8udltxRtLMFbB6SDLIBfmZmjjYiMoWO79xxqfZ25S/b1kKeBbJFnXwWq
         +0U1DVmA12kGN4Jw1Y6xf2g8iHaQTYNEVnhbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpcU1t/tj2H7Six2K2HSWdYqKvP0QvKRCjffYNTRF6M=;
        b=pMFwS2rkCFlIhQGv2Vg0OsqAlPeXYLmnpT3jB7tx0uzyUpFyMWFt8ksULUIKXdHokK
         UmeKyJrg62BtQkZCzy2cyF3bNfV9cNbbBXx0zHfR6GLMsG63JazD6B1/hxcQ1oYHz8kN
         EFC0U9kacWTZPjQfiNnuOyr7ZrnYTiNlCYTUSmUqjU35nhkq3kG274x0yOPOKNhvz7Wd
         WP/ycEFYgMDt4lEPGrnRMSg58AIFPS8XRYApZkIxdSqRKtJfLMD/yh8WhUEfaxC7R7HN
         rwsv2Lz1gjMgMq7P7j/gptO9Ebb1f5Z2ndKW0oQNMRLzD+n2adcWAbZUA7IAdiVnSzXb
         NvqQ==
X-Gm-Message-State: AGi0PuZ1536s4Ih0yzn3MpMW96I5o9sjwZTIr0Y3LSCNBG6mRdSNOKJQ
        jWrwgQvlm71PxOdo+tuKy+sdCITdvUs=
X-Google-Smtp-Source: APiQypLSGy2ohdIEZlB/PtyDVpBCJYGRvrw0L4OPrml7s9krdm8us/zY+Yna+Kbhe3CuEzWN18982A==
X-Received: by 2002:a2e:a40d:: with SMTP id p13mr194659ljn.264.1585678194872;
        Tue, 31 Mar 2020 11:09:54 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u25sm5164524lfo.71.2020.03.31.11.09.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 11:09:53 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s13so6953258lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:09:53 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr6453610lfo.125.1585678192984;
 Tue, 31 Mar 2020 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com>
In-Reply-To: <20200331080111.GA20569@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 11:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
Message-ID: <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 1:01 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> This topic tree contains more commits than usual:
>
>  - most of it are uaccess cleanups/reorganization by Al

Lovely. This now makes my local boot-test tree be much closer to my
upstream tree, since I've had my clang asm-goto stuff in my boot tree
(and it had that series from Al).

Thanks.

                  Linus
