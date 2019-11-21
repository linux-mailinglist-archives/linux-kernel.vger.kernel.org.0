Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65798105785
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKUQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 11:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfKUQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:53:40 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695D020658;
        Thu, 21 Nov 2019 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574355220;
        bh=tiskj4Iiwo7XYj1HnnEFdsnbTEE7Qj1OSyBblDXYNfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiahZSH1KQvGQb3DvX1nOft6/wv/LG9SKgsWRLCztddQDHBNFmUOSrhgWZ2MVmqJ4
         4V9ZwLUQVCxRsNkL5zAVejSbzlgqPwl9huYwFteE6EhHaAZLRCPLFm7xY6U6YnfWuh
         H6VjqkPO2QiQI8Od5TRKFtGNx5DqeoQUDJB+jU34=
Date:   Thu, 21 Nov 2019 16:53:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux@armlinux.org.uk, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, vincent.whitchurch@axis.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rabinv@axis.com,
        Richard.Earnshaw@arm.com
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191121165334.GB4905@willie-the-truck>
References: <20191113104945.GC25900@willie-the-truck>
 <20191114132848.55atqtjshjmi2udl@gondor.apana.org.au>
 <20191120191839.GF4799@willie-the-truck>
 <20191121012533.3h6akm4oczswj7zr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121012533.3h6akm4oczswj7zr@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:25:33AM +0800, Herbert Xu wrote:
> On Wed, Nov 20, 2019 at 07:18:40PM +0000, Will Deacon wrote:
> >
> > > The Alpha barrier matters for pointers, how could it make a
> > > difference for individual bits?
> > 
> > I guess you could use the result of test_bit to index into an array or
> > something?
> 
> Can Alpha Assembly even do this without using a branch?

Don't see why not: you can add the base address to the scaled result
of test_bit and use that as the address register into a load instruction.

Will
