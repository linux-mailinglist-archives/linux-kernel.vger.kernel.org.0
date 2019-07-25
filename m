Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588EB74FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389481AbfGYNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbfGYNix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:38:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791B92238C;
        Thu, 25 Jul 2019 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564061933;
        bh=jlsOsLLZzXiGnKWyHRln4ewYE4NqswfShzMVdsaJ5nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOxSG8MN51AA/XDSj9b/sEo4PEpqypukfdcgUkrd8+BG/egBOOQlspkazTPJLMnpu
         tqpdLl2QV1lDHi+uW19iEd80z5iMPSAEJnJs20zyqTiPFo6s6/s901fRwAoBV1Rh2P
         bBBFWV86uWwo0cJ7aLh4s2xTJ+XUtXQk7DHyyvkw=
Date:   Thu, 25 Jul 2019 15:38:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     junxiao.chang@intel.com
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lili.li@intel.com
Subject: Re: [PATCH] platform: release resource itself instead of resource
 tree
Message-ID: <20190725133850.GB11115@kroah.com>
References: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:24:18PM +0800, junxiao.chang@intel.com wrote:
> From: Junxiao Chang <junxiao.chang@intel.com>
> 
> When platform device is deleted or there is error in adding
> device, platform device resources should be released. Currently
> API release_resource is used to release platform device resources.
> However, this API releases not only platform resource itself but
> also its child resources. It might release resources which are
> still in use. Calling remove_resource only releases current
> resource itself, not resource tree, it moves its child resources
> to up level.

But shouldn't the parent device not get removed until all of the
children are removed?  What is causing this "inversion" to happen?

> 
> For example, platform device 1 and device 2 are registered, then only
> device 1 is unregistered in below code:
> 
>   ...
>   // Register platform test device 1, resource 0xfed1a000 ~ 0xfed1afff
>   pdev1 = platform_device_register_full(&pdevinfo1);
> 
>   // Register platform test device 2, resource 0xfed1a200 ~ 0xfed1a2ff
>   pdev2 = platform_device_register_full(&pdevinfo2);
> 
>   // Now platform device 2 resource should be device 1 resource's child
> 
>   // Unregister device 1 only
>   platform_device_unregister(pdev1);
>   ...

Don't do that.  :)

You created this mess of platform devices, so you need to keep track of
them.


> Platform device 2 resource will be released as well because its
> parent resource(device 1's resource) is released, this is not expected.
> If using API remove_resource, device 2 resource will not be released.
> 
> This change fixed an intel pmc platform device resource issue when
> intel pmc ipc kernel module is inserted/removed for twice.

Why not fix that kernel module instead?  It seems like that is the real
problem here, not a driver core issue.

thanks,

greg k-h
