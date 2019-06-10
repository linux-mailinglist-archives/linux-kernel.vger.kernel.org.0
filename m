Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE863ACEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 04:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfFJCXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 22:23:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46333 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfFJCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:23:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so8901475qtn.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zBkMGLED9l3FmX17OsaydHaK4tKEhb0w4jXMZi0ccg=;
        b=Zj8WbwXAV390RUM8igQnwN61lwTTn/QbFvp7GcZyBuJTSfCO9v8ItH0DUz5AJwZKsL
         yjsuCAo5jnkIuAgHavR0/2yY+KjqQFuhtBlgScpFJIGNHxNuOfFQzvysVmLkKjN8l8kc
         E2U0AJGuEI/Hh15D86vvyGuVN5avU22QMBAZzMnkvdX/ft3/mmqouRkdh6z8j6W+zYJX
         T0EWFI1oel+e2/ez/t+bhwWIR4bTVslecnKGaJ4/XMKs7na+Rr0QGCfBh0RPG+Jdew7J
         uzi52nr3Fcmn66ktZ4fin9On0w8vICKx6gtvErIui78HM40zjdNKhIGHKArloFA9MWld
         AT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zBkMGLED9l3FmX17OsaydHaK4tKEhb0w4jXMZi0ccg=;
        b=dWJKAorwOLUkU/Sjz9xb7UHiIweIfKE2rRYjvd+0NIqoWzwilmMw2pHktDVisLzkrA
         /FDgZe+BYBBtqKISET1ngKEYQUx91Toe8sSV+3CdN9V6asuwU5Qv/TpMEkVgarGoqXlk
         6nr47z6hI+/fFf8XfaXX14bi9rmJ9Yw6UejsCXZelbf0EPwx8FDZN58++KE14NN2gdJ7
         Kpc9Fl8ifEVEjn1XrYIsFBf5SMzFdZ0YRFGV3EI5nq7Z5l0gipzdu+CGu8J298rtj8Ba
         tY1myP7xoLuh78zELT1k+j2PQop2yJpHfdadgIja8tnUCgFGu4XIPaqQJObBo0cmY6gs
         gPnw==
X-Gm-Message-State: APjAAAXnartV7jiEegrwjvcsG9av6Te5C3sAmCaaNb7X/FPGx4l/EHwD
        tJx7YIz2AgLNogHW+RX2oxaTPRGXEKYRWjTAjnO+FEkG940=
X-Google-Smtp-Source: APXvYqzBnLgtfH/jTIbc9mlUXwmH0geVF9fRd/xlU6Yr9cEj5fr+msC3D6w//Icba3eeagHGlzEfVC5sFpKCinCZowk=
X-Received: by 2002:a0c:a8d1:: with SMTP id h17mr24478187qvc.117.1560133409793;
 Sun, 09 Jun 2019 19:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559855690.6132.50.camel@lca.pw> <CAHttsrYCD1xvL6hf6dXZ_6rB2pEra0HDZ+m5n8EMQr3+5AShnQ@mail.gmail.com>
 <1559916886.6132.52.camel@lca.pw>
In-Reply-To: <1559916886.6132.52.camel@lca.pw>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Mon, 10 Jun 2019 10:23:18 +0800
Message-ID: <CAHttsrZN09-_GXujv2H5gAORLHcO2onrotFND5GrDXRGRtFpJQ@mail.gmail.com>
Subject: Re: "locking/lockdep: Consolidate lock usage bit initialization" is buggy
To:     Qian Cai <cai@lca.pw>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the further validation.

On Fri, 7 Jun 2019 at 22:14, Qian Cai <cai@lca.pw> wrote:
> Reverted the commit on the top of linux-next fixed the issue.
>
> With the commit (triggering the warning
> DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)),
>
> # cat /proc/lockdep_stats
> lock-classes:                         1110 [max: 8192]
> stack-trace entries:                     0 [max: 524288]
> combined max dependencies:               1
> uncategorized locks:                     0
> unused locks:                         1110
> max locking depth:                      14
> debug_locks:                             0
>
> Without the commit (no warning),
>
> # cat /proc/lockdep_stats
> lock-classes:                         1110 [max: 8192]
> stack-trace entries:                  9932 [max: 524288]
> combined max dependencies:               1
> uncategorized locks:                  1113
> unused locks:                            0
> max locking depth:                      14
> debug_locks:                             1

Then it is obviously we are talking on different things; then it is
obviously a configuration problem. Fix will be posted soon.

Sorry the bug.

Thanks,
Yuyang
