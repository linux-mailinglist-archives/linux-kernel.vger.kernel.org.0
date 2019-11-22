Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF88107B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 00:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKVX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 18:27:29 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54840 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVX13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:27:29 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iYIKe-0003lu-9S; Sat, 23 Nov 2019 07:27:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iYIKa-0003bP-1t; Sat, 23 Nov 2019 07:27:16 +0800
Date:   Sat, 23 Nov 2019 07:27:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: picoxcell: add missed tasklet_kill
Message-ID: <20191122232716.6o7pgwbsbtkvtymo@gondor.apana.org.au>
References: <20191115023116.7070-1-hslester96@gmail.com>
 <20191122085512.m75tjfa3valqfgyv@gondor.apana.org.au>
 <218e9053-42c7-098e-ecda-e0306361cc23@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218e9053-42c7-098e-ecda-e0306361cc23@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 05:36:35PM +0100, Marc Gonzalez wrote:
>
> > However, the IRQ handler is registered through devm which makes it
> > hard to kill the tasklet after unregistering it.  We should probably
> > convert it to a normal request_irq so we can control how it's
> > unregistered.
> 
> Or inversely, registering the tasklet_kill() through devm, so that it
> is called *after* the ISR unregistration.

Good Point.  Chuhong, could you please try this approach to see
if it gives us better code?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
