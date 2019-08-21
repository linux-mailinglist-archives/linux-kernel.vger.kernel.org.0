Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21116975AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHUJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 05:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfHUJIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:08:54 -0400
Received: from localhost (unknown [106.201.100.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3DE22DA7;
        Wed, 21 Aug 2019 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566378533;
        bh=dARJle9XFpL/iWHfz04Vacwn8mi//tSVCikWU24/Hr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KD29rFn9JgR460WTB/bgNXV7RsoP8JpcjiK6Qdmvn8XMm5z1rX9b97tMGt5Zy/fe8
         LYFb+3cR1kPlIQSOhPpMIFXiC9o/Y19R8kW9Tx/RLeueZh+MZY7oEa/9bATPMYNqaH
         8JVeEg9ZmoL2GczJMbVJRDAekUUsk+5PAERd1i8A=
Date:   Wed, 21 Aug 2019 14:37:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        Blauciak@gmail-pop.l.google.com,
        Slawomir <slawomir.blauciak@intel.com>
Subject: Re: [PATCH 00/17] soundwire: fixes for 5.4
Message-ID: <20190821090742.GI12733@vkoul-mobl.Dlink>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-08-19, 19:55, Pierre-Louis Bossart wrote:
> This series provides an update on the initial RFC. Debugfs and Intel
> updates will be provided in follow-up patches. The order of patches
> was changed since the RFC so detailed change logs are provided below.

Applied all except 14, which didnt apply, thanks

-- 
~Vinod
