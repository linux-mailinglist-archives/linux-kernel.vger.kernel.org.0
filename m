Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8650A96D05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfHTXRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 19:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfHTXRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:17:18 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE2A2332B;
        Tue, 20 Aug 2019 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566343037;
        bh=CYqLG2yyf3Oj+6GRNfljZ+NgviW0JS9UplmVKcdHjsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0ZfYQdgEVeypPJTzOt4tR+HmgBp5JQIDtYRiei/V1OT7dmDOs1Gyr3Mc+ossWemj
         +ts1/vOwb23Uu50f6OZuJb7XjLujQVVHYu7EG7OufRSnI7fuWd37Y6me5x/CHBf/5D
         45GDShPdbirkzGd3a6VCJwFnD4T2+61TvgAf1nEE=
Date:   Tue, 20 Aug 2019 16:17:10 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8192u: fix OPEN_BRACE errors in ieee80211
Message-ID: <20190820231710.GA27451@kroah.com>
References: <20190820231156.30031-1-stephen@brennan.io>
 <20190820231156.30031-2-stephen@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820231156.30031-2-stephen@brennan.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:11:54PM -0700, Stephen Brennan wrote:
> Signed-off-by: Stephen Brennan <stephen@brennan.io>
> ---

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
