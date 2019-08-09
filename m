Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058DA8711E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfHIEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 00:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfHIEwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:52:50 -0400
Received: from localhost (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E56214C6;
        Fri,  9 Aug 2019 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565326369;
        bh=OBKijblckKGGjMtCi/PDL4MM+zX7ePxmkuXEG+1zdjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=co1e57XY/QH08zElefWyX/P0debF9WSWjVh689Cuip/xsllN0cwShWIemw1E3Qlvl
         g9r/vNpaF+QDZczvJRK02EUzWXW9chepIRBcuksxkS5VQsjtKyyOfQiNcRrIpjfN78
         H78YP//8eJWCLaAJp4czCM4TMXsCDFn3m/iNWNUs=
Date:   Fri, 9 Aug 2019 10:21:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
Message-ID: <20190809045131.GF12733@vkoul-mobl.Dlink>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-19, 18:02, Pierre-Louis Bossart wrote:
> The existing code has a mixed select/depend usage which makes no sense.
> 
> config SOUNDWIRE_BUS
>        tristate
>        select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>         tristate
>         depends on SOUNDWIRE_BUS
> 
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.

Applied, thanks

-- 
~Vinod
