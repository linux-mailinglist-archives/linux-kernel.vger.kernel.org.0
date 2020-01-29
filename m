Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB514D0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgA2SwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 13:52:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45213 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2SwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:52:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so232979pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8T8iaT/9dcdgkVWV4KcYEe5+1niEPL2//rL6DhuX7E=;
        b=FirLSuHerGCJSe7z5FOZqzRomPN+EttEFvo2q1BiyKiqhfbS9rzxQFJP2SrJ+lrc8s
         XALXNrRRNsUUjXZn1VmAqFV0AC0nJJvZwFLbZwuNmZBlDHRc6IrxEU8Btm2gcTtdXZ3i
         RVBdAsWIGpk/T5vFUx6YoFE1LHWgHtive6/8Sc7Z0M8B1TNiQaWMZ/19xee71kzQkWaN
         ddG3ECwmKuJeMqGU7S+DnrO3FZ7p+i6BqkWIUx3JgPGLrHYiDoCAFg7SLqdb+ewwQHPb
         qyZB+JXmEACcy2/M503SxGoJFYXqPheNiyy4TlWyeBGf9grl4toTCOhUTy9vdTivp4w9
         LoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8T8iaT/9dcdgkVWV4KcYEe5+1niEPL2//rL6DhuX7E=;
        b=X/wse9ORVz2lYJnAHlTRMNNDxDHqQPTByETVJufO7xNXxaIVvlXLj9qb1RQPwYVgdZ
         r8hq2gBbU2wjS5tfYpbShWLRu9rDZ4TnIuHJS2dPDVfdCttDr1WJ226PkW8QgRxQMHKu
         48Dvj20YJdFKmG56VPDzTp7Mf2GHr2yYebAXMIfA217n4vmJ/UeLdam71AZVk+UIDPxX
         uoSrcqyoyAfH7mdGMrPy7AwLgnbLddMCzOEjOUc3epvZGCSLjvt8wZTKdxJw7Hj1wqC+
         /crMeJUOEMSBEzsDmlEusM+BTDU0vy46cXovKnXzDQjtoVNy5IRsLFXcOQdPadKvdiLt
         tBUg==
X-Gm-Message-State: APjAAAVQHcLP4RdCHi9s4II7MX/cNJFR6xZ2ios6G6hrnjScTeYMbLFK
        vpXsOIhoURg3iNdTYNbGCOdnvj0knU0XnAWxCCg=
X-Google-Smtp-Source: APXvYqyPUQJrzS3e03pacFDz7wtZseXkq9L9K6nTK5EGpJrWAGje1oz9PzUIo678zw6OsALKVVUZAnt1/uiuV/RXw8M=
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr405466pgk.99.1580323943017;
 Wed, 29 Jan 2020 10:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20200129103941.304769381@infradead.org> <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200129115412.GN14914@hirez.programming.kicks-ass.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Thu, 30 Jan 2020 07:52:11 +1300
Message-ID: <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Jan 30, 2020 at 12:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 29, 2020 at 11:49:13AM +0100, John Paul Adrian Glaubitz wrote:
>
> > > [1] https://wiki.debian.org/M68k/QemuSystemM68k
>
> Now, if only debian would actually ship that :/
>
> AFAICT that emulates a q800 which is another 68040 and should thus not
> differ from ARAnyM.
>
> I'm fairly confident in the 040 bits, it's the 020/030 things that need
> coverage.

I'll take a look - unless this eats up way more kernel memory for page
tables, it should still boot on my Falcon.

Cheers,

  Michael
