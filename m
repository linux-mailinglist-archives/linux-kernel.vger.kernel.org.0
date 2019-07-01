Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD86411293
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEBFZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 01:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfEBFZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:25:54 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1112089E;
        Thu,  2 May 2019 05:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556774753;
        bh=svo261ePVl1LIloKIObODZ39QGmPxBU9BQXRPFDEf5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vE8lDiI7T2hTUwHxxGkhdGThq/gA/6/DqSa7gfKo3DV5R32TpwVWWcnra7kcuWQgz
         ypG0Jm1dGNy3imzC/y/A7K7tXCI748Yozh6d7qak9rak2k0hGZUMgJkZNZLEGZRlKG
         OsI7UIPVh2Ure05lGhSBoV7a/7nBPmlTOs3zA1jM=
Date:   Thu, 2 May 2019 10:55:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 03/22] soundwire: fix alignment issues in header files
Message-ID: <20190502052544.GB3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> use Linux style
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 12 ++++++------
>  drivers/soundwire/cadence_master.h | 18 +++++++++---------

Again this touches core and lib.

Btw I applied the patches to check for alignment and they look good on
that part.

Thanks

-- 
~Vinod
