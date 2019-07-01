Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C906211365
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 08:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfEBGcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 02:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfEBGcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:32:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C63620873;
        Thu,  2 May 2019 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556778741;
        bh=h6lQUZAXWXjVncrTfdjGeEblQS97dkVgyYPRpZ8VW90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBBk4E5Ylzod4E003AbqFlC3AvaC8ABsCM4IbQ7pySzcD9tZpd7Y9fFvgxpkyzf76
         uWYvzldvXXUoG+f1ErefYkAdl4EzYp40H5KClfPuxxJQbn92Kf0JY/ynkoGWqxitpX
         ard7zdwZUgqVgFHTgTHUG4NnS3ytXlg0D5HTTvuw=
Date:   Thu, 2 May 2019 08:32:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 22/22] soundwire: add missing newlines in dynamic
 debug logs
Message-ID: <20190502063219.GB14347@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
 <20190502053746.GE3845@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502053746.GE3845@vkoul-mobl.Dlink>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 11:07:46AM +0530, Vinod Koul wrote:
> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > For some reason the newlines are not used everywhere. Fix as needed.
> > 
> > Reported-by: Joe Perches <joe@perches.com>
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  drivers/soundwire/bus.c            |  74 +++++++++----------
> >  drivers/soundwire/cadence_master.c |  12 ++--
> >  drivers/soundwire/intel.c          |  12 ++--
> >  drivers/soundwire/stream.c         | 110 ++++++++++++++---------------
> 
> Sorry this needs to be split up. I think bus.c and stream.c should go
> in patch with cadence_master.c and intel.c in different ones

Again, _way_ too picky.  You can't look a gift horse _too_ closely in
the mouth...

greg k-h
