Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13C596F65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 04:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHUCUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 22:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfHUCUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:20:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FE522DA7;
        Wed, 21 Aug 2019 02:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566354053;
        bh=dDoqvH7cPzQlNadZ1kurjVq8FKDUwOC07P/MNENXjcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERs0FPZ6ROQFeuR6nRwEIBq51RHhUufLJZdwWs5Avr0dFyy3EUWFq5NTKrCKNKQ88
         blWQ4OZqcLYjvUXxWnoGao/HrZEnAZl/p9TM1Gh8TLlb7rq/tdW291kjPslJ5q/C1s
         dLLblfKRd9F+OzlcWOwQfuSKk1tcJ0ssd/l3HUCo=
Date:   Tue, 20 Aug 2019 19:20:48 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Caitlyn <caitlynannefinn@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging/erofs/xattr.h: Fixed misaligned function
 arguments.
Message-ID: <20190821022048.GA26373@kroah.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-2-git-send-email-caitlynannefinn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566346700-28536-2-git-send-email-caitlynannefinn@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:18:19PM -0400, Caitlyn wrote:
> Indented some function arguments to fix checkpath warnings.
> 
> Signed-off-by: Caitlyn <caitlynannefinn@gmail.com>
> ---
>  drivers/staging/erofs/xattr.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
