Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74114CCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfFTLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 07:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfFTLdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:33:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72ED2082C;
        Thu, 20 Jun 2019 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561030390;
        bh=iEIU3iBNotat6D5yj7F2SKd8Q0SHAYqUttB3s3mKcpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+gNw00T7uKO8O9jJLcKMyTNmgrPKx663f0xKKbw9enP5h7i3ute5HiMQbaFTdQSg
         eXdVgt7XFAFffapzWo+/rJHsfZ+qLMgaM9XNs20L/AhyUCV3iC1YsgbjD1vo9tKE7s
         LHO8ElTouzdf768k5EhFj5U3PXEgmBHKBASo/JmI=
Date:   Thu, 20 Jun 2019 13:33:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de
Subject: Re: [PATCH 1/1] drivers/staging/rtl8129u: adjust block comments
Message-ID: <20190620113308.GA16195@kroah.com>
References: <20190620094534.5658-1-muellerch-privat@web.de>
 <20190620094534.5658-2-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620094534.5658-2-muellerch-privat@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:45:34AM +0200, Christian Müller wrote:
> As stated in coding-styles.rst multiline comments should be structured in a way,
> that the actual comment starts on the second line of the commented portion. E.g:
> 
> /*
>  * Multiline comments
>  * should look like
>  * this.
>  */
> 
> The comments in this file were of a format, that looked like this:
> 
> /* Multiline comments previous
>  * to this patch
>  * looked like this.
>  */
> 
> There is an exception to files in /net and drivers/net,
> where multiline comments are preferred to look like the second example above,
> but since this file resides in a different directory,
> this patch changes the style to match the preferred style.

Ah.  Hm.  Turns out this is a networking driver, and some day, the goal
would be for it to live under drivers/net/  If it were to move there,
then these comments would be in the correct format already.

So this patch isn't needed, sorry.

greg k-h
