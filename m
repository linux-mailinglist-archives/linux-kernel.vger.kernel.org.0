Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB44F08B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfFUVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 17:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0AA2075E;
        Fri, 21 Jun 2019 21:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561153302;
        bh=yWASpSBNDRg/yVlWtmSHpm6YoAijQdVNE+xjVAjrLCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEdCq7plYBxjQMTXjtT59fEmK2MFy77ymJrmgyb8hNDM6W8w3uFDrUb1HdZPOSeGG
         7OHzL29KV9wXvXzkHA2DCY0DnNnTddRI2LUCHpHDMHgzeNWkGfD+TTQGVQxDoHd7Bm
         ww1MCESKDTk7EhQIuc/xFJhlSGkap22PUdFVzcWE=
Date:   Fri, 21 Jun 2019 23:41:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc:     edumazet@google.com, lkml <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: Steam is broken on new kernels
Message-ID: <20190621214139.GA31034@kroah.com>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 02:27:41PM -0700, Pierre-Loup A. Griffais wrote:
> This seems to have broken us:
> 
> https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.11
> 
> Here's some affected users:
> 
> https://github.com/ValveSoftware/steam-for-linux/issues/6326
> 
> https://www.reddit.com/r/linux_gaming/comments/c37lmh/psa_steam_does_not_connect_on_kernels_newer_than/
> 
> https://www.phoronix.com/scan.php?page=news_item&px=Steam-Networking-Kernel-Woes
> 
> I don't really understand that distributions that claim to be desktop
> products would have fast-tracked a server-oriented fix to all their users
> without testing one of the primary desktop usecases, but that's another
> thing to figure out later.
> 

What specific commit caused the breakage?
