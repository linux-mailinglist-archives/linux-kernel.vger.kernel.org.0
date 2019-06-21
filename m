Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9EC4EAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfFUOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:33:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47349 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:33:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fbb2b2f2
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=JdFjDpWURSBZbukHVny7DQomcUE=; b=pXgoJU
        X8Fmza6TvZAiXD4UBpuepAMuAyYwd35BiF2sRJ5poPOXePjje7pAnSBhJRS/JS0a
        PsRy7gzj221uHvze36J1mQbflQpptlsUX1jBt6cYBJ0fWl+Zx1CUqTLfov8x4TCM
        aLLbdQuJdrULgrDTzsK9RcVM5PL1MceFMULSpI3lPQZD6EtcMBiQv2Hh+PnzgJ6g
        nWe3TeSLie4iRo9uR7Cu5Ke7dLAMVNsTheMEKpfWxIUo1jB32GbNY0A4lX69910K
        DA/uWMZNAy68KP+g/e2BdbTZkKm96SnbtfQHGvRhyVeSJgCyeB9QhajARkwsrYDk
        rz4Mswj3Gk+V+aaQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d261d533 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 13:59:54 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id i8so6467349oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:33:18 -0700 (PDT)
X-Gm-Message-State: APjAAAWJOwtDSnUgJs98FrpMsW5v7EcaIAGVaMIH+bNhRwXN1FOpOZ5h
        nIYmdcAwsM7qq1T7ffOQsMxu9k+pM7MYHJEjpoE=
X-Google-Smtp-Source: APXvYqxyDmm4F0Ba2qGZ98yZ0qFZUEyiVkZ4LaeN2w2xVw6JJFLgLaxN5TC9LI+h9X+EKXXCccN/55WfZJsxuuiAquo=
X-Received: by 2002:a9d:73c4:: with SMTP id m4mr10456987otk.369.1561127598338;
 Fri, 21 Jun 2019 07:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <CAK8P3a14=isYJFZYZ5BGGPQY0eLCA7zswHTt=F7Yd4kN-8EtrA@mail.gmail.com>
In-Reply-To: <CAK8P3a14=isYJFZYZ5BGGPQY0eLCA7zswHTt=F7Yd4kN-8EtrA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Jun 2019 16:33:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9pikBz6oNdCFePEERquaQC5njez5=SBL+Cq43mn-aFy4A@mail.gmail.com>
Message-ID: <CAHmME9pikBz6oNdCFePEERquaQC5njez5=SBL+Cq43mn-aFy4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: add missing non-_ns functions for fast accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Typo: you have the same function names listed twice here,
> one of them should be ktime_get_mono_fast() instead of
> ktime_get_mono_fast_ns().

Nice catch. Vim twitches gone crazy.

> Also, we might want to rename ktime_get_boot_fast_ns()
> to ktime_get_boottime_fast_ns in the process. It seems there
> is only a single caller.

And tai -> clocktai on the others. I can send a followup patch to
unify all those after this set.
