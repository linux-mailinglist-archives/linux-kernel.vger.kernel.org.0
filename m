Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129AE445B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392980AbfFMQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfFMFlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:41:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561782053B;
        Thu, 13 Jun 2019 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560404499;
        bh=8Xh4IPVPSoQJv7GWld73+9V0oaBZe8Mpmmz/mKLN+rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByZS4yI0t6Lw+NdGjH9a07AeUUIjvk1cJGDzyfIrJViTGTIERIRZJL73c1qIokMUC
         kT69jwfWNhHdI09f8E0yIK0aUZ+KzXE4TbSXQvD9JCQDWMDp6umh59lH1N+nTQhdeL
         M/gOrFkfIXjo0IPpGalbyOsvg9YOy3Os1OrJnBOY=
Date:   Thu, 13 Jun 2019 07:41:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix possible UAF when freeing buffer
Message-ID: <20190613054136.GA19717@kroah.com>
References: <20190612202927.54518-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612202927.54518-1-tkjos@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 01:29:27PM -0700, Todd Kjos wrote:
> There is a race between the binder driver cleaning
> up a completed transaction via binder_free_transaction()
> and a user calling binder_ioctl(BC_FREE_BUFFER) to
> release a buffer. It doesn't matter which is first but
> they need to be protected against running concurrently
> which can result in a UAF.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Does this also need to go to the stable kernels?

thanks,

greg k-h
