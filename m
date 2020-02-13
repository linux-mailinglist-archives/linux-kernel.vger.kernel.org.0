Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5715CE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMWz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 17:55:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43946 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:55:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so3811884pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbaDWghw4kwOwM3o4hCkHjBsTkcKhGYXr0+o9iH4FG0=;
        b=AoIpz9KOGj1IaY1uLmMmSESgP9UTTb0zAO/ztru2ySX1/BE27H2mqX60jeLEzme4Ga
         p+V9ihatwlswfFroiuHEQ7shIYED3YdXI972YsToYRXHqU7x4BFAo2XD/qfyjntUCQUy
         wcvhCfKXOZFaRrl5s3MJqmhdMNSKWyIHv430Rb9E7SfOlzlmleoRoPwKziXUSQ4Ka4EG
         24oK0sLbSq6+ysX1ff53o2c1GGoAmtzf94qwheBeN5kW56PearZJXKRhnfbpfUEFNrQN
         On+Gy3D1BnnGdCLvtkEVHndOV3rzEei+YUfBveMaGhal3vaTs8ton659e3FxCTEA+13u
         Qpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbaDWghw4kwOwM3o4hCkHjBsTkcKhGYXr0+o9iH4FG0=;
        b=gOVk+rWDpBxQCNa0mK8ZNzcB0Ste8PL2z1kh42Q6HttqTcqYxymBrsvod3KZA3u+QG
         S/W/oY4fDNrcgpNtDKLrX0Q+CO4Z6gDIh5Bh4iOaK4gui+ZRd0BNj+QzZogRNX9Hw8GR
         3x3DhLTPnZpefHne6rrdHVq84v/Bg0fm/Op+SfEfiFcYExLFyfpPutdCzaBzOI5m6X5o
         AC6bpsEpT919fD8LM3YrCGz2Hn9FOhjoa9RmJ6zXQ4DASEazliTaZlyy/fHwf2X4u61D
         XyvBTfUmYM3FwP5r7btY27hmNiFmqWzijgAE7w+cdX/9PlC21BLz0VgGrCjyzB1VsRQ5
         a10g==
X-Gm-Message-State: APjAAAWUWPKeDPq3lG67OiiVy8ixMngXEu00s5eMQcOeO6YURZ9BCSE2
        BrKGBU2XduhgVpoWjDzO+Qs27wNY1QHeHdnSFuMd10Gx
X-Google-Smtp-Source: APXvYqx8mXL1Qm7SbjvQmBcPbXB9Z3A/Q4fOQqA3O1VXlMYuP7TCjLO/6P2X4fdzYacgNNZy7qin3vZqJA5ltpR0r1w=
X-Received: by 2002:a63:64c5:: with SMTP id y188mr235966pgb.10.1581634558128;
 Thu, 13 Feb 2020 14:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213184708.205083-1-ndesaulniers@google.com> <20200213221758.i6pchz4gsiy2lsyc@treble>
In-Reply-To: <20200213221758.i6pchz4gsiy2lsyc@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Feb 2020 14:55:47 -0800
Message-ID: <CAKwvOdnsHMs0PV8uDAWktRDso--_AORNnDYdGHnp5+YYEm1kXw@mail.gmail.com>
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 2:18 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Feb 13, 2020 at 10:47:08AM -0800, Nick Desaulniers wrote:
> > Top of tree LLVM has optimizations related to
> > -fno-semantic-interposition to avoid emitting PLT relocations for
> > references to symbols located in the same translation unit, where it
> > will emit "local symbol" references.
> >
> > Clang builds fall back on GNU as for assembling, currently. It appears a
> > bug in GNU as introduced around 2.31 is keeping around local labels in
> > the symbol table, despite the documentation saying:
> >
> > "Local symbols are defined and used within the assembler, but they are
> > normally not saved in object files."
> >
> > When objtool searches for a symbol at a given offset, it's finding the
> > incorrectly kept .L<symbol>$local symbol that should have been discarded
> > by the assembler.
> >
> > A patch for GNU as has been authored.  For now, objtool should not treat
> > local symbols as the expected symbol for a given offset when iterating
> > the symbol table.
> >
> > commit 644592d32837 ("objtool: Fail the kernel build on fatal errors")
> > exposed this issue.
>
> Since I'm going to be dropping 644592d32837 ("objtool: Fail the kernel
> build on fatal errors") anyway, I wonder if this patch is still needed?
>
> At least the error will be downgraded to a warning.  And while the
> warning could be more user friendly, it still has value because it
> reveals a toolchain bug.

Sure thing.  I appreciate it, and I'm on board with helping debug or
fix any compiler bugs we might have in order to re-strengthen the
warning soon.
-- 
Thanks,
~Nick Desaulniers
