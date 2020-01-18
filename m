Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD51417D8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 15:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgAROEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 09:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:04:37 -0500
Received: from localhost (170.143.71.37.rev.sfr.net [37.71.143.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729D12469A;
        Sat, 18 Jan 2020 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579356276;
        bh=j7ydMgEUTCEjqU+FOSR+j3qVOVbU4JkdnVULYCKyRu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeaISrfzUsvEMexU8WkGQ56KXGVoLKwBZH7l/gKsLk6eF8sXekTBhcGivGlF4rGUt
         fuvC/NE7WlM0H/mj0J3JmQ0b7lHCXtsmQTYhr6M4T2vYxEQez1QyZB7JOGp/NPk5ZD
         XTW2MtVeVxLQ8yPl3JhQQXZwMMoQPXuAYw8qWWnc=
Date:   Sat, 18 Jan 2020 15:03:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.6-rc1
Message-ID: <20200118140348.GA50123@kroah.com>
References: <20200118065948.GX2818@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118065948.GX2818@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 12:29:48PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here are the updates for soundwire for v5.6-rc1. I have also shared tag
> 'sdw_interfaces_2_5.6' to ASoC folks, they might be merging that for
> cross tree dependency of ASoC drivers (soundwire slaves)
> 
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> 
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.6-rc1

Pulled and pushed out, thanks.

greg k-h
