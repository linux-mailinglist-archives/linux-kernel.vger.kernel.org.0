Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4810A60FA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGFJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 05:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfGFJ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:29:19 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE45220838;
        Sat,  6 Jul 2019 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562405358;
        bh=q0ChCYbw9BUDkWl5qTb6N9u6aCLW/OO4j39NqDScVdE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aamOu0XKXSBhtt1yKpU6r/ss1xC8nZzgJj4jyUslKR76f+Ra2rEh4O8h/yEl7rD6V
         ieQX+PHjtC9RbnIPPDP4hxoy0JuqaDIsgqW1m573K/ooKz9bzdHenhr65sRbFBEarR
         0fihP89c8qhaBtcYn0lQlkZAGBnLZYdvNAQNBj6U=
Date:   Sat, 6 Jul 2019 11:28:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Bhagyashri Dighole <digholebhagyashri@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: One function call less in
 speakup_win_enable()
Message-ID: <20190706092856.GA15480@kroah.com>
References: <11f79333-25c3-1ad9-4975-58c64821f3fe@web.de>
 <20190706090019.rivposzrqesodhso@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706090019.rivposzrqesodhso@function>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 11:00:19AM +0200, Samuel Thibault wrote:
> Markus Elfring, le sam. 06 juil. 2019 10:15:30 +0200, a ecrit:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 6 Jul 2019 10:03:56 +0200
> > 
> > Avoid an extra function call by using a ternary operator instead of
> > a conditional statement.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Sorry, but this author/bot is in my kill-file and I no longer accept
patches from them.

And I HATE ternary operators anyway, so it's not like I would take this
patch if it came from someone else :)

thanks,

greg k-h
