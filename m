Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6FFF63A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 01:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKQA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 19:57:05 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57446 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfKQA5F (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Sat, 16 Nov 2019 19:57:05 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iW8rv-0003Qn-TL; Sun, 17 Nov 2019 08:56:47 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iW8rp-00046T-AW; Sun, 17 Nov 2019 08:56:41 +0800
Date:   Sun, 17 Nov 2019 08:56:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Stephen Boyd <swboyd@chromium.org>, Theodore Ts'o <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: Don't freeze in add_hwgenerator_randomness() if
 stopping kthread
Message-ID: <20191117005641.qgremf2lrj46qy4p@gondor.apana.org.au>
References: <20191110135543.3476097-1-mail@maciej.szmigiero.name>
 <5dcee409.1c69fb81.f5027.48ad@mx.google.com>
 <415922ac-3c87-081c-6fdf-73fc97d0f397@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415922ac-3c87-081c-6fdf-73fc97d0f397@maciej.szmigiero.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 12:01:20AM +0100, Maciej S. Szmigiero wrote:
>
> If a reader (user space) task is frozen then it is no longer waiting
> on this waitqueue - at least if I understand correctly how the freezer
> works for user space tasks, that is by interrupting waits via a fake
> signal.

At this point I'm just going to revert the whole thing and we can
sort it out in the next development cycle.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
