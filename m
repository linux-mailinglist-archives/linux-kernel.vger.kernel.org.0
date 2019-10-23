Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559FBE2278
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfJWS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 14:26:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35378 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfJWS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ilfsvkQZhflxpwApssuF0SxtHAiqATDZH9AtW7X4oPs=; b=0JmadXmXYKwJL2c+ZhpX92FTQ
        mhe5+ZtixqNGmRC6SrFXmSvi05PSDLOESRYUhXWzvZluFGISA0LCgG6vM3ELBuUo2rKkg//DkRJhO
        gweIiJdxFnwhr/rntlzGxs5ZZ1e6RYo06In0ahN4mL3ZWMX0ZwHEL+5BaJdB2enbSn2mfi/OKVET+
        TaXy1f7tO6jsQvwXhSIv2sClqlP6fZsgVRPVOFVY0SZuaSh7ZB4/41v+ZmPxjkBWpsXVbgiSJPdck
        n77nBTt+E14t7DvtTxmLiJVRFAK6kEXG6FFBKcGQKiRNqATik5H9BgMm61Gfnu02946w6ZcHsK7TQ
        hzbF6bOlA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:46520)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iNLKu-0006h6-Jl; Wed, 23 Oct 2019 19:26:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iNLKs-0005ki-FT; Wed, 23 Oct 2019 19:26:18 +0100
Date:   Wed, 23 Oct 2019 19:26:18 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce mutex locking"
Message-ID: <20191023182618.GC25745@shell.armlinux.org.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <20191023161203.28955-2-jbrunet@baylibre.com>
 <20191023163716.GI5723@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163716.GI5723@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 05:37:16PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 06:12:02PM +0200, Jerome Brunet wrote:
> > This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.
> > 
> > This fixes the following warning reported by lockdep and a potential
> > issue with hibernation
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Hi Mark,

If you look at the git log for reverted commits, the vast majority
of them follow _this_ style.  From 5.3 back to the start of current
git history, there are 3665 commits with "Revert" in their subject
line, 3050 of those start with "Revert" with no subsystem prefix.

It seems that there are a small number of subsystems that want
something different, ASoC included.  That will be an ongoing problem,
people won't remember which want it when the majority don't.

Maybe the revert format should be standardised in some manner?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
