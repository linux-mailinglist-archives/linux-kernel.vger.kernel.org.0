Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918163308D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfFCNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFCNFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:05:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E7C27F5E;
        Mon,  3 Jun 2019 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567115;
        bh=hvxRq+vA9NJlN13fkQsg4UkvRkk5tlRIY54i7UP0W08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7REBrsAD78ynBHQ/dAPvj7q58oyGl8zRMPnwBFkThTZX7TVNNJRHOv5JVjgFdzaZ
         gHUEot/83QUyDDCxVeDHP3T98ENuNCQx5dz9Yxl9ecz6Ffrwz79ko1OkNq3OiZ3azZ
         hdB4ltHX4jF4s6BD68IjmUZ2DrKZggSDFU0ywiqU=
Date:   Mon, 3 Jun 2019 15:05:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de
Subject: Re: [PATCH 3/3] drivers/staging/rtl8192u: Fix of checkpatch-errors
Message-ID: <20190603130513.GB30732@kroah.com>
References: <20190603122104.2564-1-muellerch-privat@web.de>
 <20190603122104.2564-4-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603122104.2564-4-muellerch-privat@web.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:21:04PM +0200, Christian M�ller wrote:
> Fix issues that lead to multiple checkpatch warnings and errors, most of
> them regarding formatting of code and comments.
> Comments that contain only commented out code are removed as well.
> 
> Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
> Signed-off-by: Christian M�ller <muellerch-privat@web.de>


- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
