Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855538722E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbfHIGVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:21:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37522 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405603AbfHIGVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:21:10 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvyGr-0007Tk-EU; Fri, 09 Aug 2019 16:21:01 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvyGn-0002tT-S8; Fri, 09 Aug 2019 16:20:57 +1000
Date:   Fri, 9 Aug 2019 16:20:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: initialize pd->cpu with effective cpumask
Message-ID: <20190809062057.GR10392@gondor.apana.org.au>
References: <20190808160535.27219-1-daniel.m.jordan@oracle.com>
 <84c4dc26-856a-7641-db38-62fa62ce8034@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c4dc26-856a-7641-db38-62fa62ce8034@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:54:16PM -0400, Daniel Jordan wrote:
> On 8/8/19 12:05 PM, Daniel Jordan wrote:
> >Fixes: 726e431130f3 ("padata: Replace delayed timer with immediate workqueue in padata_reorder")
> 
> Should be
> 
> 	 6fc4dbcf0276 ("padata: Replace delayed timer with immediate workqueue in padata_reorder")

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
