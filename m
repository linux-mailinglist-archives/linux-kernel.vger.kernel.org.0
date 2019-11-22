Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51F5106E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfKVLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:10:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53944 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfKVLJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:09:58 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6p2-0005FN-0P; Fri, 22 Nov 2019 19:09:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6p1-0002ji-Sb; Fri, 22 Nov 2019 19:09:55 +0800
Date:   Fri, 22 Nov 2019 19:09:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: essiv: remove redundant null pointer check
 before kfree
Message-ID: <20191122110955.eyfiapa7dhd3oa4m@gondor.apana.org.au>
References: <1573887060-100725-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573887060-100725-1-git-send-email-chenwandun@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 02:51:00PM +0800, Chen Wandun wrote:
> kfree has taken null pointer check into account. so it is safe to
> remove the unnecessary check.
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  crypto/essiv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
