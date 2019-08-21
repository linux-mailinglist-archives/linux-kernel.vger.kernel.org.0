Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B59798611
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfHUUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfHUUzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:55:33 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC4E22CF7;
        Wed, 21 Aug 2019 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566420932;
        bh=3N06S7d+IJH7fPcRuLFfhOA0WbN6iEVHSUEKzhUzAFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Op0ZTlKcQ72uPdMScK1pmE2ol9RArOow9WNasYr/64DCACbauO36mqWDk3iXoHlAp
         o2KArwFsS+X1aoDsVU5Dh3+T0ztd+dbqfJOPuN6Q6wQ03QK4YTgyvNawohH8pDEe7I
         JNVuPjfYpIi+AKrbyigMwNEKXcxJQbjK3xpgb5Lc=
Date:   Wed, 21 Aug 2019 13:55:31 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jerry Chuang <jerry-chuang@realtek.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: Added Realtek rtl8192u driver to staging - static analysis
 report.
Message-ID: <20190821205531.GC17415@kroah.com>
References: <cb1222a8-4c67-8fac-f1d9-755e97699caa@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1222a8-4c67-8fac-f1d9-755e97699caa@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 07:18:39PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis of linux-next picked up an issue with the following commit:
> 
> commit 8fc8598e61f6f384f3eaf1d9b09500c12af47b37
> Author: Jerry Chuang <jerry-chuang@realtek.com>
> Date:   Tue Nov 3 07:17:11 2009 -0200
> 
>     Staging: Added Realtek rtl8192u driver to staging
> 
> In drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c we have:
> 
> CID 48331 (#1 of 1): Unused value (UNUSED_VALUE) assigned_pointer
> 
> Assigning value from ieee->crypt[ieee->tx_keyidx] to crypt here, but
> that stored value is not used.
> 
> 746        crypt = ieee->crypt[ieee->tx_keyidx];
> 747        if (encrypt)
> 748                beacon_buf->capability |=
> cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
> 
> Pointer crypt is being assigned but is never used afterwards.  Now
> either this is a redundant assignment and can be removed OR maybe crypt
> should be checked and there is a typo, e.g.:
> 
> 	crypt = ieee->crypt[ieee->tx_keyidx];
> 	if (crypt)
> 		...
> 
> Either way, it's not clear to me and I think the code needs cleaning up.
> Any ideas?

10+ year old code, yeah!!!

Just guess, who knows, no one seems to care :(

greg k-h
