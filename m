Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB19AA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfHWIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:34:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33071 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbfHWIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:34:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so3892508oto.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wI4jnej8AspWUXE13reusEb4wx5ZdHi/mO0D9XYtEg=;
        b=aeC3TxV0j2A92x3gKbNcF7bCggKdYhKlcyjxAhb5hfIRm+pYMjP86E3zP6iPTYa0CW
         V4FP5NjHd9HiRZopamKaKgTN9DoDP1olhMwISRwQM8srvpF0JbA28Xs/5rV6oXCqpMTX
         iTLRFwvLICz57Ol4za0Kp8tRS9HWt94Uo/ni8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wI4jnej8AspWUXE13reusEb4wx5ZdHi/mO0D9XYtEg=;
        b=BrZYi9ZPmpsW50yRQz8cix8Iw2Za5zN+L7T/StGQCJQwhGfi8jgAJIvDpw+dCJvwmJ
         SyVejRPlEJDBXvVgn2I6AafHwkZT5LLSTpWge++3Arisb6nF3wSlNqefb7Z9suNr+S/8
         5GTPFH9s/H/TG62UH6XnO/NujhV80Ofhv2QXL27gmA/OgCDfVXlWq4xRiom8pl3+Ly9W
         ydxWkwirehOInBluE65/s13bg9WYbZNu8vboEH4RqQra89xZgnAcc9qKq8eMkbAhNVAv
         UPyvmFIbHv2D9u5kNdNHvh77qpz+PKKQMXtdb/jmz2Fz0MOjuTS4l5NiX8NW8yD2rMIJ
         fLgg==
X-Gm-Message-State: APjAAAXxvaIwQpiEogcqcsff4M9hIo9Z1xcXgJyPYNyoKnW67aY+nlY0
        Hd9JbvMBeJ5OXuO3zksXlH/E8GqK4ocPSKr62Zk6Rg==
X-Google-Smtp-Source: APXvYqySGMSx76GQciFyarc45Uaxat2fi1EkKKRAKJHDAgSYk4ycOdQtf+zAg8LRPPEFSKLE0nTWT6z30G/6Y2FEpF0=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr3113253otj.303.1566549253448;
 Fri, 23 Aug 2019 01:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch> <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
In-Reply-To: <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Aug 2019 10:34:01 +0200
Message-ID: <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 1:14 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 20 Aug 2019 22:24:40 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > Hi Peter,
> >
> > Iirc you've been involved at least somewhat in discussing this. -mm folks
> > are a bit undecided whether these new non_block semantics are a good idea.
> > Michal Hocko still is in support, but Andrew Morton and Jason Gunthorpe
> > are less enthusiastic. Jason said he's ok with merging the hmm side of
> > this if scheduler folks ack. If not, then I'll respin with the
> > preempt_disable/enable instead like in v1.
>
> I became mollified once Michel explained the rationale.  I think it's
> OK.  It's very specific to the oom reaper and hopefully won't be used
> more widely(?).

Yeah, no plans for that from me. And I hope the comment above them now
explains why they exist, so people think twice before using it in
random places.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
