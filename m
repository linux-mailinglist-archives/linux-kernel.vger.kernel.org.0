Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1427A4C8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfFTH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 03:58:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43552 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfFTH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:58:46 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hdrxx-00024O-0a; Thu, 20 Jun 2019 15:58:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hdrxu-00063K-2u; Thu, 20 Jun 2019 15:58:38 +0800
Date:   Thu, 20 Jun 2019 15:58:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     yamada.masahiro@socionext.com
Cc:     stfrench@microsoft.com, linux-cifs@vger.kernel.org,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cifs: Fix tracing build error with O=
Message-ID: <20190620075838.sthw4kjpp2gt6t6j@gondor.apana.org.au>
References: <20190620064023.cwvcj5g4rgnmkmmn@gondor.apana.org.au>
 <9c994536a297449d843947ba9be05998@SOC-EX01V.e01.socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c994536a297449d843947ba9be05998@SOC-EX01V.e01.socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:54:42AM +0000, yamada.masahiro@socionext.com wrote:
>
> I cannot reproduce the build error on the latest Linus tree.
> 
> 
> $ make O=build allmodconfig fs/cifs/
> 
> perfectly works for me.

I was trying to build just the fs/cifs directory with

	make O=build M=fs/cifs

But I see now that this can't possibly work as M= only supports
absolute paths.  As M= is supposed to replace SUBDIRS=, what are
we supposed to do to build just a directory?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
