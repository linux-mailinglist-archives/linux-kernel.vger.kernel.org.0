Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B3118BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLJPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:04:57 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35333 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLJPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:04:56 -0500
Received: by mail-yw1-f67.google.com with SMTP id i190so7396690ywc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4p02kg6PQgUAxsLiq+h/2nhVm9uCC+HtafrymcdyAs=;
        b=oxEoiB3fALraSZfRXamPHXCm06Mz7IquqV6ft8yeKIH7ICYr6hxbK6Mc1Sm7pAUFyP
         4qkZHEWlGrGBA95NfxuqOwT8s1K3/hHF7obL11LCSPC9iU1V90oSmEplAekKuVoXKa+L
         FhnH9yIcf4LJkP0x+GFfrkshDXPFOD44hfvQsBh9KZ8t+wh7ToYfMR2Jsvad5l1IueAr
         QeoPuoEK3Hu7d5xbwt//MJTHcKL0SY9RR+QiAOQ8jnGQHlYe8W2xTYmoGJps0uDFbzDA
         OVZ2Xbk3NKuJ3jl5AN8q2ARDmYxcifdglpRpoQdoy2o3ZsbEc4bp13C/9n06uDzf6Rq5
         qqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4p02kg6PQgUAxsLiq+h/2nhVm9uCC+HtafrymcdyAs=;
        b=Z/gXkU77RStzxlRhEUb1/4CWwy27bOS1K5imdjNmO09vbpmWp9FKfUUOHq9JMllUu4
         rmiC+3aee7MrVpLyOEb13/GLLFcU9zBowkVPbcmDvDQRJQ9cNAZJtj2nbbFCnxFtLmLC
         L8A+P116bwx3SITX8DkHRKdTmFWXTC4R+B70gwQEPGmilCWu8dxXldVBgV0xf0NSwHqB
         Kw+WWOf1ShLBv66po4P+fSqLfgHVNQu9J/JwNeTuNwAiLTgKMGW03oaRBlg2PqkKQEh0
         My6jkeNUBEqpLgTpjC3xgfqcpdcyR3XVQBqkrI3SNZmtnp9XkzZJvAFNIOEfsM+CBMSs
         1hmg==
X-Gm-Message-State: APjAAAVRRVauTegIpY/EdWR1U7Mg0CByRRHL/Do3uQOtGtnXikOxBiRD
        L2T16kv5AHOhFmM5WpgJ+YndAGUEfmhieeVI3nWAMQ==
X-Google-Smtp-Source: APXvYqyN2FVaQ2x2qixGmbbzQqSf+Jx9Sy9uU7Vj94WqOdWlaVju/EzKyhrxyJXQNwuNHRhtMmQstjt8+oPE2JjqTjk=
X-Received: by 2002:a81:114f:: with SMTP id 76mr24360176ywr.174.1575990295223;
 Tue, 10 Dec 2019 07:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20191030184844.84219-1-edumazet@google.com> <CAMuHMdVK=dUxhJh1pjLe4bGn3V=FHJ_90oga0USRBw-wSqd8Pw@mail.gmail.com>
In-Reply-To: <CAMuHMdVK=dUxhJh1pjLe4bGn3V=FHJ_90oga0USRBw-wSqd8Pw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 10 Dec 2019 07:04:43 -0800
Message-ID: <CANn89iK5oLcLm2bL=Q5+oTrKrd1q_QkEQpAQSfyjDSSeM22Dfw@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: increase HASH_SIZE
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 6:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> JFTR, this increases dma_entry_hash size by 327680 bytes, and pushes
> a few more boards beyond their bootloader-imposed kernel size limits.
>
> Disabling CONFIG_DMA_API_DEBUG fixes that.
> Of course the real fix is to fix the bootloaders...
>

Hi Geert

Maybe we can make the hash size arch-dependent, or better dynamically
allocate this memory ?
