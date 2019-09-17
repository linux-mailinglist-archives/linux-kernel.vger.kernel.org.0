Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6CB4716
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbfIQFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 01:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392421AbfIQFzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:55:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F5021670;
        Tue, 17 Sep 2019 05:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568699714;
        bh=PguNlRlXErMMWFgmBjjpNfbyE9JGSwRipCM2vKmpfAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMAru7ZTwpG5XG8o5eI2RR/kZfwwODOjxoY+REOdv4P53vq1DmV04Onf7QJD64qis
         N1voFAqWO+PBd3i80zo9oszKCVBYFjxxbGUS1uJlLaLuRb9UVkXWxw/ollZQ1EDrId
         jWrzBJbSD+foaYZCPD4NImx6A7WpsXzPGTWp/oPA=
Date:   Tue, 17 Sep 2019 07:55:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 8/9] soundwire: intel: remove platform devices and
 provide new interface
Message-ID: <20190917055512.GE2058532@kroah.com>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
> +/**
> + * sdw_intel_probe() - SoundWire Intel probe routine
> + * @parent_handle: ACPI parent handle
> + * @res: resource data
> + *
> + * This creates SoundWire Master and Slave devices below the controller.
> + * All the information necessary is stored in the context, and the res
> + * argument pointer can be freed after this step.
> + */
> +struct sdw_intel_ctx
> +*sdw_intel_probe(struct sdw_intel_res *res)
> +{
> +	return sdw_intel_probe_controller(res);
> +}
> +EXPORT_SYMBOL(sdw_intel_probe);
> +
> +/**
> + * sdw_intel_startup() - SoundWire Intel startup
> + * @ctx: SoundWire context allocated in the probe
> + *
> + */
> +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> +{
> +	return sdw_intel_startup_controller(ctx);
> +}
> +EXPORT_SYMBOL(sdw_intel_startup);

Why are you exporting these functions if no one calls them?

thanks,

greg k-h
