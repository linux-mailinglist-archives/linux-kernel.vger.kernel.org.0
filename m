Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DEA86132
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfHHLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 07:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHLz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:55:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE75921874;
        Thu,  8 Aug 2019 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565265358;
        bh=DSDFumAChuko83ZMojcrTL89RmjY+E6uL9obeAU7zCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVd2ZiaIf8AhF6R///cyKDe311FLAG7VrSH5UqsFnighSJFP88+QuiDBXUo/gqwmU
         WlXP7lVGaHwO2Lnd9CJ5DBWKs9XnS07Jkka55lHEB5X15uHP1zCCUGI2w3kD74fuoP
         TMzBOl3/GM2mMi7cbKgkVuZ8GPQ6BI3vatDP7ahM=
Date:   Thu, 8 Aug 2019 13:55:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, mst@redhat.com, arnd@arndb.de,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio_console: free unused buffers with port
 delete
Message-ID: <20190808115555.GA2015@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
 <20190808113606.19504-2-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808113606.19504-2-pagupta@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 05:06:05PM +0530, Pankaj Gupta wrote:
>   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
>   deferred detaching of unused buffer to virtio device unplug time.
> 
>   This causes unplug/replug of single port in virtio device with an
>   error "Error allocating inbufs\n". As we don't free the unused buffers
>   attached with the port. Re-plug the same port tries to allocate new
>   buffers in virtqueue and results in this error if queue is full.
> 
>   This patch removes the unused buffers in vq's when we unplug the port.
>   This is the best we can do as we cannot call device_reset because virtio
>   device is still active.

Why is this indented?

> 
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")

Fixes: b3258ff1d608 ("virtio: Decrement avail idx on buffer detach")

is the correct format to use.

And given that this is from 2.6.39 (and 2.6.38.5), shouldn't it also be
backported for the stable kernels?

thanks,

greg k-h
