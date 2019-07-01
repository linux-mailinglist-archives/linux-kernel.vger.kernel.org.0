Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2C112A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEBFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 01:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfEBFhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:37:55 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F7220873;
        Thu,  2 May 2019 05:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556775475;
        bh=1DawRFLT7t05k8v0cV9BglVQshWM9ob5TgAeTumjZ+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTZNCRqxAwj7YMKiu8DsWogyCAiJIhuF0jiFeHK2QS4mnX7T4WhzvPKCPhcgvYhiw
         BUpCjng8msMo43DijBSVgEUUvtznjNbNizYGxVRD+OLZzrcsEN13LjYB4/2Uth1PrF
         OzD5qxyOnmOtZWIRSbvGP3dMAxL7ri0Unr01+Ius=
Date:   Thu, 2 May 2019 11:07:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 22/22] soundwire: add missing newlines in dynamic
 debug logs
Message-ID: <20190502053746.GE3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> For some reason the newlines are not used everywhere. Fix as needed.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c            |  74 +++++++++----------
>  drivers/soundwire/cadence_master.c |  12 ++--
>  drivers/soundwire/intel.c          |  12 ++--
>  drivers/soundwire/stream.c         | 110 ++++++++++++++---------------

Sorry this needs to be split up. I think bus.c and stream.c should go
in patch with cadence_master.c and intel.c in different ones


>  4 files changed, 104 insertions(+), 104 deletions(-)
-- 
~Vinod
