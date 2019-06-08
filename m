Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93793A091
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFHPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 11:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfFHPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 11:55:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85252206BB;
        Sat,  8 Jun 2019 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560009327;
        bh=nh6TdIhR5A7AsbyvajbHEcCEd+tJlehSFbCYV0YCs+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvBVATR4R46czxUuX+2jZf3IGqL7gYwHqRfRGcZ6CB0xvN85wYVxvNoaEbeOZQKVx
         k7pSDFqDP5C8GFlToBYGSpE3UbPs+/Ic9klzQHxZ0KLLnwxjRr8k3ByO+DFNI5R9fD
         98NJ3GFNYdfqowQUufPz3wHCJNhhaPkT4KswRtF0=
Date:   Sat, 8 Jun 2019 17:55:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soonwoo Hong <qpseh2m7@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix coding style
Message-ID: <20190608155524.GD7974@kroah.com>
References: <20190608134728.4655-1-qpseh2m7@gmail.com>
 <20190608155446.GC7974@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608155446.GC7974@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 05:54:46PM +0200, Greg KH wrote:
> On Sat, Jun 08, 2019 at 10:47:28PM +0900, Soonwoo Hong wrote:
> > Add a space before colon in ternary operator
> > 
> > Singed-off-by: Soonwoo Hong <qpseh2m7@gmail.com>
> > ---
> >  block/blk-mq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> $ ./scripts/get_maintainer.pl --file block/blk-mq.c
> Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
> linux-block@vger.kernel.org (open list:BLOCK LAYER)
> linux-kernel@vger.kernel.org (open list)
> 

Also, doing coding style cleanups outside of drivers/staging/ is a tough
thing to do, please don't make it harder on yourself...

good luck!

greg k-h
