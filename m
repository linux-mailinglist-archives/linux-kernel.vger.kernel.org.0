Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD48750DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGYOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbfGYOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:21:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992B222C7B;
        Thu, 25 Jul 2019 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564064496;
        bh=pxReWaEST95lk565mK1Mw+8MWIZHmNlYX5ldtarOjvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYGCqmiYLdCxJiHwW+7Jfsk9vU8NlsVpS9UKp/yfqWBKGgvoTs4XDlDiNEa+ET/nf
         dE7/+pSOVqwaGTLLQ6xlBE5NwXcUL5cln+28UBayTyuMR9pJZ+4TtKqwbKN48XaFzo
         PmqVxDnNz5A2Wlw7scGSMA9tPLPK/PFUycvduEcs=
Date:   Thu, 25 Jul 2019 16:21:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/configs: Replace GPL boilerplate code with SPDX
 identifier
Message-ID: <20190725142133.GB15480@kroah.com>
References: <20190722092008.15403-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722092008.15403-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:20:08AM +0200, Thomas Huth wrote:
> The FSF does not reside in "675 Mass Ave, Cambridge" anymore...
> let's replace the old GPL boilerplate code with a proper SPDX
> identifier instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  kernel/configs.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

Thanks for this, I can take this through the spdx tree.

greg k-h
