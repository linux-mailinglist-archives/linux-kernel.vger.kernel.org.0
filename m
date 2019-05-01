Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB910AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEAQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfEAQH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1F720644;
        Wed,  1 May 2019 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726878;
        bh=+QIyFl4ZWzWfYiBsaC7r50ojqsjlAp1dymkvBkiQ/pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pn8HFtZyku6oFfPBfqbOyEnDViKE0ERz1S/TFFCygWgf+O0jBRtXinLeWBs7QdMrv
         6PO4n1PpwjOlgXy8QgB4pwWJLJrY+1rFPNXUbSjplctvDKExyQQAaGzcBn/sKnGphB
         wSDCxl41/h+iv3bpPOmD9ZDqi7ZJUIYPVMmkbvM8=
Date:   Wed, 1 May 2019 18:07:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v4 00/22] soundwire: code cleanup
Message-ID: <20190501160755.GC19281@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:57:23AM -0500, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Changes since v3:
> patch 1,3,4 were merged for 5.2-rc1
> No code change, only split patch2 in 21 patches to make Vinod
> happy. Each patch only fixes a specific issue. patch 5 is now patch22
> and wasn't changed. Not sure why Vinod reported the patch didn't
> apply.
> Added Takashi's Reviewed-by tag in all patches since the code is
> exactly the same as in v3.

These all look good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Vinod, want me to just pick these up from the list as-is so we can get
them into 5.2-rc1?

thanks,

greg k-h
