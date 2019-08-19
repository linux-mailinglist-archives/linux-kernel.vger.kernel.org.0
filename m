Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D4950A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfHSWVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSWVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:21:02 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578F622DA7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 22:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566253261;
        bh=KR93Nh2pEVTQXskRCcRNJG5EoMuJxb1LL9zdGmo9ev8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XGcvD/0M9vzUeS5avfGpqrqHbAXOoM7uu9ljKoE0xyKGAOK/T4rwZQ5k6bSHpqVZy
         OkuCiCQD0/WV82YQMrJnVLzUeStX/PHvdFGOvUencl1Htvm5Rq7zuoaJoyxWxg9qvu
         808gminbEYHjFq2fq8o9F4ZuzVJo6fczFFK2iaQo=
Received: by mail-wr1-f49.google.com with SMTP id k2so10290578wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:21:01 -0700 (PDT)
X-Gm-Message-State: APjAAAW8PJhidoyu3KRANNhp/8O5aFp84uIbtLG6HtWnHEDVTV8Sqtgz
        a+GV2G/5KIPJirPFFBpHabFCzJRVHRRYbsiQtrIRdw==
X-Google-Smtp-Source: APXvYqwNtW0rY5/4IORCA0JWGQVEmCNW0QeuAxonklMdoFEakLEyQfmhwomVLQ6OZ71NQtenvXcQl0iYBVssDum9uwg=
X-Received: by 2002:adf:eec5:: with SMTP id a5mr29877043wrp.352.1566253259728;
 Mon, 19 Aug 2019 15:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190815001636.12235-1-dja@axtens.net> <20190815001636.12235-2-dja@axtens.net>
 <15c6110a-9e6e-495c-122e-acbde6e698d9@c-s.fr> <20190816170813.GA7417@lakrids.cambridge.arm.com>
 <87imqtu7pc.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87imqtu7pc.fsf@dja-thinkpad.axtens.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Aug 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CALCETrXnvofB_2KciRL6gZBemtjwTVg4-EKSJx-nz-BULF5aMg@mail.gmail.com>
Message-ID: <CALCETrXnvofB_2KciRL6gZBemtjwTVg4-EKSJx-nz-BULF5aMg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Aug 18, 2019, at 8:58 PM, Daniel Axtens <dja@axtens.net> wrote:
>

>>> Each page of shadow memory represent 8 pages of real memory. Could we use
>>> page_ref to count how many pieces of a shadow page are used so that we can
>>> free it when the ref count decreases to 0.
>
> I'm not sure how much of a difference it will make, but I'll have a look.
>

There are a grand total of eight possible pages that could require a
given shadow page. I would suggest that, instead of reference
counting, you just check all eight pages.

Or, better yet, look at the actual vm_area_struct and are where prev
and next point. That should tell you exactly which range can be freed.
