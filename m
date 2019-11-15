Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1688FD5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 07:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOGJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 01:09:09 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58092 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOGJJ (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:09:09 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUmb-0004sE-0W; Fri, 15 Nov 2019 14:08:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUmX-000693-CF; Fri, 15 Nov 2019 14:08:33 +0800
Date:   Fri, 15 Nov 2019 14:08:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, Stephen Boyd <swboyd@chromium.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: Don't freeze in add_hwgenerator_randomness() if
 stopping kthread
Message-ID: <20191115060833.xze5kkq64pxci2la@gondor.apana.org.au>
References: <20191110135543.3476097-1-mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110135543.3476097-1-mail@maciej.szmigiero.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 02:55:42PM +0100, Maciej S. Szmigiero wrote:
> Since commit 59b569480dc8
> ("random: Use wait_event_freezable() in add_hwgenerator_randomness()")
> there is a race in add_hwgenerator_randomness() between freezing and
> stopping the calling kthread.
> 
> This commit changed wait_event_interruptible() call with
> kthread_freezable_should_stop() as a condition into wait_event_freezable()
> with just kthread_should_stop() as a condition to fix a warning that
> kthread_freezable_should_stop() might sleep inside the wait.
> 
> wait_event_freezable() ultimately calls __refrigerator() with its
> check_kthr_stop argument set to false, which causes it to keep the kthread
> frozen even if somebody calls kthread_stop() on it.
> 
> Calling wait_event_freezable() with kthread_should_stop() as a condition
> is racy because it doesn't take into account the situation where this
> condition becomes true on a kthread marked for freezing only after this
> condition has already been checked.
> 
> Calling freezing() should avoid the issue that the commit 59b569480dc8 has
> fixed, as it is only a checking function, it doesn't actually do the
> freezing.
> 
> add_hwgenerator_randomness() has two post-boot users: in khwrng the
> kthread will be frozen anyway by call to kthread_freezable_should_stop()
> in its main loop, while its second user (ath9k-hwrng) is not freezable at
> all.
> 
> This change allows a VM with virtio-rng loaded to write s2disk image
> successfully.
> 
> Fixes: 59b569480dc8 ("random: Use wait_event_freezable() in add_hwgenerator_randomness()")
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/char/random.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
