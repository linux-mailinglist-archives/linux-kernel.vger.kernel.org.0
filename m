Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6783315967D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 18:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgBKRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 12:47:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40658 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgBKRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so13526827wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0VAV2uAZn7cwf80RoSqvTXJTOGM5LDaGHKNSoNSGHk=;
        b=QbpBWdwYnoWn8aPZgHyKzn+JoeOVAW1n6DG5fzvmx6mK8CHu9eCILwvxBg6NBGJJuA
         d2B+KVtyYZWeH/pfbTDW3SyN5oE5YxrFt8hSPITYFciFg8mvz1zVCjHb5+hc8HX653zK
         411typsd9Iw2yaMmXdMoUhdBGJfJlr4dDNAHf1ntJO4ncSiyXK7t3Xzj5FIt3ho6ykRK
         wM3iX3nDhF4PYDhxcL1fFNGKifqtu7MWAuTALLPMGZO0YUmSR4hW6YAmp4gN8g2NrzgA
         6oYvxc9hPaEBtL8CnE/C+CbfbAp/uM16GHLyl52ENJ3wePSA3d8G+hxOB2z16iqjFKmD
         66Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0VAV2uAZn7cwf80RoSqvTXJTOGM5LDaGHKNSoNSGHk=;
        b=tDcg1nkKI3FBLQPhGM3YkjZ+4qDcBRhIOxeU4lUU14DyKl+mjoVi0FlJlr/bZAa+il
         ijEULUO4GlvhoUBbvUMdcBXwgn3sO5gqSG8uU+WFXo/X70k4TQN1cqSEPpxcI9L5mKAs
         fF5hsuQBhr4XuIxNCpt28pJ11mFRwE7YydftLMBppXSSdCDaLXvQPnHE2ozi0ODJAqdP
         NyAoUF2bAZy0tiPTK8VVkedal6mq/MTxlXWZrtQWrDye0kw/aW5DtPhUYX3nWXazl54Z
         pHEW3v85iQWPpQUijXuJZNTtgRudtKGHLhi12MRm+ubrJlIL6P+6dWQfTgU46Q11ltOH
         yeCA==
X-Gm-Message-State: APjAAAXHWuE1xu/qvgEhP7BVmKxogXgr0Z9YIVodog8EPU2Irt36+mxY
        7y2gMyAcTwh8gm3nxe8XEd8AGGZRvM1FxvgBld38jw==
X-Google-Smtp-Source: APXvYqxTiLAPBWBNjRiDwwF9xb8l42ZHllnWyO8r959e7mF1P+DYyJAKnd4NjVEsEhnkhq37FyrMm+yEO5iwmmCmPy0=
X-Received: by 2002:a05:6000:108e:: with SMTP id y14mr9883732wrw.338.1581443230266;
 Tue, 11 Feb 2020 09:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com> <CACT4Y+Y=Qj6coWpY107Dj+TsUJK1nruWAC=QMZBDC5snNZRTOw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y=Qj6coWpY107Dj+TsUJK1nruWAC=QMZBDC5snNZRTOw@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 11 Feb 2020 09:46:59 -0800
Message-ID: <CAKFsvUL=maBVZ7v_N6W1skZRkYm4GacRGn-ohbf-o84p598XNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I started reviewing this, but I am spotting things that I already
> commented on, like shadow start and about shadow size const. Please
> either address them, or answer why they are not addressed, or add some
> kind of TODOs so that I don't write the same comment again.

I'm sorry; They must have gotten lost in all the emails. I'll go
through them all again.
-- 
Patricia Alfonso
