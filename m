Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0038313D576
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 08:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgAPH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 02:57:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48340 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:57:34 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1is01s-00BVg7-C7; Thu, 16 Jan 2020 08:57:24 +0100
Message-ID: <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        aryabinin@virtuozzo.com, dvyukov@google.com,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Date:   Thu, 16 Jan 2020 08:57:22 +0100
In-Reply-To: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com> (sfid-20200115_235651_948442_0F0A0073)
References: <20200115182816.33892-1-trishalfonso@google.com>
         <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
         <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
         (sfid-20200115_235651_948442_0F0A0073)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This seems like a good idea. I'll keep the #ifdef around
> KASAN_SHADOW_SIZE, but add "select HAVE_ARCH_KASAN if X86_64" as well.
> This will make extending it later easier.

Yeah, that makes a lot of sense.

I think once somebody (Anton? Richard?) start applying patches again,
they will pick up my revert for CONFIG_CONSTRUCTORS:

https://patchwork.ozlabs.org/patch/1204275/

(See there for why I had to revert it)

If I remember correctly, KASAN depends on CONSTRUCTORS, so that revert
will then break your patch here?

And if I remember from looking at KASAN, some of the constructors there
depended on initializing after the KASAN data structures were set up (or
at least allocated)? It may be that you solved that by allocating the
shadow so very early though.

In any case, I think you should pick up that revert of
CONFIG_CONSTRUCTORS and see what you have to do to make it still work,
if that's possible.

If not, then ... tricky, not sure what to do. Maybe then we could
somehow hook in and have our own constructor that's called even before
the compiler-emitted ASAN constructors, to allocate the necessary data
structures.

johannes

