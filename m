Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D397016851
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEGQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:46:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfEGQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:46:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so14948124ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SaL00iV1UNCyLI8qSrWSgzywNwyxR2ABU4F6/Mpj/U=;
        b=sLgqz+8svFVJmInlU2NbYaBgK2Ey1bgZIzqFKNG0JA/5OyJk9eEFhuyDRfJDszjWlS
         F8ow0umJbkd4e9k0aYeb2+755cafzxshd7aEW79MeUiz+SxQ8RganQcARZk9ynPVRKZR
         e7GB2NwjLqTU4/nFZrtEURZtVpEj9EKmXi9kLyhF9xP2PQquT9Hl8naPjreNZ+XbsNe+
         08M8gsI21EOCC5qPgWrDxMb+MtXL4JZulTbteqGu4uG229VP4TTN0Igqngb80YYgGy9d
         visSw/BBSsAYG9brRGCUaBptxuDjpPMplLJgVcyd4+H/YGCkx34exTLZhluw5kDTKvv+
         Yg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SaL00iV1UNCyLI8qSrWSgzywNwyxR2ABU4F6/Mpj/U=;
        b=H9qDrPM2VOrSh/JI60D+0mNjb3Euttd7Y8IEyOn5hZEK+LCoppG6R6IymG0qMhON+I
         rnAhetEPGy9e0m8ZlWUM+wDgG89Wtn4J871oj64/r7/vInGi9sBFP1CuZSVrO3inQrUY
         abj1DWM9aQ4WLvx7D4IHE0+6nyTkBTDutNmJWhZfRKWGfCzt5UmGYTyRWxrGAhtAXalt
         PZH4Iki2yInnHY/+mqJUaWiUuq9d2+tzV0dyhlvLojGqme/0bvhd4hCv+UsLwIi9k75T
         3ok/936NOzYAFvCcxjqtRVwDzlzoY0J6YsM5bA3qKRSrCjMUSERQqRY2ZfDCdiFnYt1D
         3gBw==
X-Gm-Message-State: APjAAAXxyIIAQBjlFlQCKluemktjuESug5ABYNMthsSD5J2Y8ySkJAtp
        /s6ltYnvUK6R3SyYEdXPnciX7yTowcrD3yVtGtg=
X-Google-Smtp-Source: APXvYqxfTK0z2SDdzOJd/69D8yC9FUzlfkY52RfEl/daX8tPGy7hCHERgk4xHwuJ9fnOkuHuJj8uQ6aATsFhFuSoLpw=
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr16320744lja.99.1557247558995;
 Tue, 07 May 2019 09:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190422162652.15483-1-kasong@redhat.com> <20190423113501.GN11158@hirez.programming.kicks-ass.net>
 <CACPcB9f8JuALCw1i-V2N01GuTQRfjrCya6esOTM8dGwvf+oT7w@mail.gmail.com> <20190424125212.GN12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190424125212.GN12232@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 7 May 2019 09:45:47 -0700
Message-ID: <CAADnVQJLLCQJoV8Qg+0D4_-mE8hLmrEYz91Jy0kT2Qgkb1evtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 08:42:40AM -0400, Kairui Song wrote:
>
> > Sure, the updated comments looks much better. Will the maintainer
> > squash the comment update or should I send a V5?
>
> I've squashed it, I've just not gotten around to stuffing it a git tree
> yet. Should happen 'soon'.

Was it applied and on the way to Linus yet ?
