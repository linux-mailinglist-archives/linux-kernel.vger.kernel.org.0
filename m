Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32DC1D86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfI3I5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 04:57:42 -0400
Received: from ns.iliad.fr ([212.27.33.1]:36058 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbfI3I5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:57:42 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5FC0020289;
        Mon, 30 Sep 2019 10:57:40 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id A431320274;
        Mon, 30 Sep 2019 10:57:39 +0200 (CEST)
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07>
 <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a3a5e118-e6da-8d6d-5073-931653fa2808@free.fr>
Date:   Mon, 30 Sep 2019 10:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569818173.17361.19.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Sep 30 10:57:40 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2019 06:36, Walter Wu wrote:

>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip)
>  {
> +       if (long(size) < 0) {
> +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> +               return false;
> +       }
> +
>         return check_memory_region_inline(addr, size, write, ret_ip);
>  }

Is it expected that memcpy/memmove may sometimes (incorrectly) be passed
a negative value? (It would indeed turn up as a "large" size_t)

IMO, casting to long is suspicious.

There seem to be some two implicit assumptions.

1) size >= ULONG_MAX/2 is invalid input
2) casting a size >= ULONG_MAX/2 to long yields a negative value

1) seems reasonable because we can't copy more than half of memory to
the other half of memory. I suppose the constraint could be even tighter,
but it's not clear where to draw the line, especially when considering
32b vs 64b arches.

2) is implementation-defined, and gcc works "as expected" (clang too
probably) https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html

A comment might be warranted to explain the rationale.

Regards.
