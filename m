Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17FF3225
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfKGPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 10:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfKGPJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:09:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F10C21D6C;
        Thu,  7 Nov 2019 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139358;
        bh=/h8t53roPI/rD/uP7zadW263zkJUzQG8YPGxa8rn2JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anqJp2lFyBxbvu8u/SzWDi+z7rQPRJQwmfoN3ZvB1yBHZlHf/veVg86iN31mSKYuB
         1GmDwTCnA4w1Kmh2z/lX0ctooio9LzAt5PXLqDIsS5HfAuDzEf0pw/hyIRYKhOqqBX
         fkYSi6kOVliw/u1hUYNM7KgrrhU1cWIwT9vjKbKE=
Date:   Thu, 7 Nov 2019 16:09:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Valery Ivanov <ivalery111@gmail.com>, rspringer@google.com,
        toddpoynor@google.com, benchan@chromium.org,
        Simon Que <sque@chromium.org>,
        John Joseph <jnjoseph@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: gasket_ioctl: Remove unnecessary
 line-breaks in funtion signature
Message-ID: <20191107150916.GB154681@kroah.com>
References: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
 <e3ee9e75d7c25e2d25b74fd1d4709f8dacb79efc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ee9e75d7c25e2d25b74fd1d4709f8dacb79efc.camel@perches.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 11:12:09AM -0800, Joe Perches wrote:
> On Wed, 2019-11-06 at 18:08 +0000, Valery Ivanov wrote:
> > 	This patch fix the function signature for trace_gasket_ioctl_page_table_data
> > 	to avoid the checkpatch.pl warning:
> > 
> > 		CHECK: Lines should not end with a '('
> > 
> > Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
> 
> All of this stuff is no-op and could just as easily be removed
> completely as GASKET_KERNEL_TRACE_SUPPORT is not #defined anywhere.
> 
> Is the actual trace #include file supposed to be available somewhere?
> 
> #ifdef GASKET_KERNEL_TRACE_SUPPORT
> #define CREATE_TRACE_POINTS
> #include <trace/events/gasket_ioctl.h>
> #else
> #define trace_gasket_ioctl_entry(x, ...)
> #define trace_gasket_ioctl_exit(x)
> #define trace_gasket_ioctl_integer_data(x)
> #define trace_gasket_ioctl_eventfd_data(x, ...)
> #define trace_gasket_ioctl_page_table_data(x, ...)
> #define trace_gasket_ioctl_config_coherent_allocator(x, ...)
> #endif
> 
> trace file not found...

I'm thinking the whole gasket driver should be deleted as there has not
been any effort done to fix it up and get it out of staging.  I'll give
it until 5.5 before I drop it...

thanks,

greg k-h
