Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2041918AD7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 08:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCSHs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 03:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSHs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:48:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA4E20722;
        Thu, 19 Mar 2020 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584604109;
        bh=DpO44T5jLSZKdnEhkl065vGcFlq3vORTR/bjAmB0qzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7I3czoT7LXJzenE68cfpJA+9lwbm8n0vpJEu647VjqTazfvK7mWmVuKmn+LEBtaZ
         zFW/IPkHtzbAl8nMFfMTc1KSQCV9sfnkpR0gkGVfWD3LHi4i2uFDlk4SUjn9HByvzi
         sZbbFlkH5Uhb2BfNNIHQASyyJA/A6uwvQYc0PKI8=
Date:   Thu, 19 Mar 2020 08:48:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiang Su <suqiang4@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] UIO: make maximum memory and port regions configurable
Message-ID: <20200319074826.GA3444175@kroah.com>
References: <20200319073923.51812-1-suqiang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319073923.51812-1-suqiang4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:39:23PM +0800, Qiang Su wrote:
> Now each uio device can only support 5 memory regions and
> 5 port regions. It may be far from enough for some big system.
> On the other hand, the hard-coded style is not flexible.
> So make these values configurable by menuconfig, thus users
> can easily expand them according to their actual situation.
> 
> Consider the marco is used as array index, so a range for
> the config is set in menuconfig. The range is set as 1 to 512.
> The default value is still set as 5 to keep consistent with
> current code.
> 
> Signed-off-by: Qiang Su <suqiang4@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Greg KH <gregkh@linuxfoundation.org>

What?  No, I did not review this, do not add a tag like that for a patch
that I have not explicitly given it for.

And how is the kbuild bot reporting problems that this patch fixes?
Where is that report?

Also, I want this to be dynamic, not static, please do that instead, no
one rebuilds their kernels for something like this.

thanks,

greg k-h
