Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85BD11360
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEBGbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 02:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfEBGbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:31:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4559B20873;
        Thu,  2 May 2019 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556778701;
        bh=9kQfTgRbn7BgX36DKuhOlMTBnMrgYJ3lA2q1ZFCe0Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRpPFrI+nLqoXGHxtKnq8xxjxssnaGXPV0SqZzMNBnpUjrEtuMM6kuRllc4mN/1yD
         MJVeEpkfeFnh/1e6fmotR7ygT2ys5GIDJyLzqhfGbcYmN7PLYFjwMRaNNslvNpGwSW
         e7C3rdU2qD9OIzh2nZn/+6rRRdpXycWWxZGHlEXY=
Date:   Thu, 2 May 2019 08:31:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Message-ID: <20190502063139.GA14347@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
 <20190502051440.GA3845@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502051440.GA3845@vkoul-mobl.Dlink>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:46:49AM +0530, Vinod Koul wrote:
> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > No C++ comments in .h files
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  drivers/soundwire/bus.h            | 4 ++--
> >  drivers/soundwire/cadence_master.h | 4 ++--
> >  drivers/soundwire/intel.h          | 4 ++--
> 
> As I said previously this touches subsystem header as well as driver
> headers which is not ideal.

What?  Who knows that?  Who cares?

This is doing "one logical thing" to all of the needed files.  Your
split of "this is a driver" vs. "this is a subsystem" split is _VERY_
arbritary.

That's just too picky and assumes a subsystem-internal-knowledge much
deeper than anyone submitting a normal cleanup patch would ever know.

I think you have swung too far to the "too picky" side, you might want
to dial it back.

thanks,

greg k-h
