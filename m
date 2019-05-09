Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E5194FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEIV6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 17:58:24 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35303 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfEIV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:58:24 -0400
Received: by mail-ua1-f66.google.com with SMTP id g16so1397189uad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FXPIq1hegck4+LUfvPI3e12GgUDRXQleew5eHpUJZ4=;
        b=GWU18C7YaAP+YZQi3muCAvs0KMaXaiY3pUYWpt1UWv65qwcRPAYuQhtt69DqUxV4f7
         iITK0m73QzNWHzEWWQTtFcEvXgMsGCKqzSf++mwGmIpww1ehMyP+vzRjgC9S6IRVORaW
         A27qAJi5bmbkLBWUdmMflVPq+oxdZCA0YqEcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FXPIq1hegck4+LUfvPI3e12GgUDRXQleew5eHpUJZ4=;
        b=seD9Qn4GPVhiAZoObdKrpq/6N5f/781hedOHATgvoLN/RCJiKXB6KbY4nyG8h5+k2F
         le7yGTJM0bF69HR+TjrPtYrvsJGVnuj0EFLyaCU43Wv45BE6PZuOzQ+WgyRR7sAYvFgd
         P0sScxzfb29Kp8GXGqM91k70nPMsTrZuK7NNY5+4+UAvL5ttpaYRXi4V17E8kMIdKuAC
         T6QGPUqSv+jFoD4z/BQmXVP4QaznUNJQJiXVdlX8UHxpnL8nElKm8MpEXt4v6d5Oy8b9
         eYpsC6LFSSYZshnKvNXMIwmRVKelWEyKvoJjiPciDi28cLi0G7dIL8DHKshDUatpWSoH
         LsBg==
X-Gm-Message-State: APjAAAURP7zZ5473jyGP8I15zq/WImP18WsURDSuY12mm0g5pFdlX09c
        +HX1r1f64XmfKwX0+GIWMLcrcMoSoIg=
X-Google-Smtp-Source: APXvYqxoyESeZAerZkvTzsDRmbf1BAPgTehLZG5GhrjMLq2kwfEtePuK9viRIZ6DWkWTCsRmM6x8dw==
X-Received: by 2002:ab0:720a:: with SMTP id u10mr229651uao.22.1557439102362;
        Thu, 09 May 2019 14:58:22 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id p44sm1776795uae.7.2019.05.09.14.58.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:58:21 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id w13so2420838vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:58:21 -0700 (PDT)
X-Received: by 2002:a67:de07:: with SMTP id q7mr3837804vsk.66.1557439100581;
 Thu, 09 May 2019 14:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
 <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
 <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com>
 <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com> <CAJMQK-hJUG855+TqX=droOjUfb-MKnU0n0FYtr_SW2KByKAW1w@mail.gmail.com>
In-Reply-To: <CAJMQK-hJUG855+TqX=droOjUfb-MKnU0n0FYtr_SW2KByKAW1w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 9 May 2019 14:58:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+S3tQ3DFtmTJT_O1rNx4ofZWvaFpPrES9peHRhMqRGjg@mail.gmail.com>
Message-ID: <CAGXu5j+S3tQ3DFtmTJT_O1rNx4ofZWvaFpPrES9peHRhMqRGjg@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 1:00 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> This early added entropy is also going to be used for stack canary. At
> the time it's created there's not be much entropy (before
> boot_init_stack_canary(), there's only add_latent_entropy() and
> command_line).
> On arm64, there is a single canary for all tasks. If RNG is weak or
> the seed can be read, it might be easier to figure out the canary.

With newer compilers[1] there will be a per-task canary on arm64[2],
which will improve this situation, but many architectures lack a
per-task canary, unfortunately. I've also recently rearranged the RNG
initialization[3] which should also help with better entropy mixing.
But each of these are kind of band-aids against not having sufficient
initial entropy, which leaves the canary potentially exposed.

-Kees

[1] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=359c1bf35e3109d2f3882980b47a5eae46123259
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a1213fa7432778b71a1c0166bf56660a3aab030
[3] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git/commit/?h=dev&id=d55535232c3dbde9a523a9d10d68670f5fe5dec3

-- 
Kees Cook
