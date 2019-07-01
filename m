Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63622ADFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfE0FYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 01:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0FYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:24:01 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9648216FD;
        Mon, 27 May 2019 05:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558934640;
        bh=oqHyKLmqbmz83G7bOIGzPBCvDihDOBQfvCCdsIaxkoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUeiVe/NgRc8Q7rApCnxPrh+x8ci1o4I45nVg4YYqLGu80xuiq2QgVQR7d+APhL5F
         EW/RzPuvOBI5Vopy+V8SID54PLNarCa+pXlubg3AO5xhY0U5JxTwaluE76J64O50l8
         u9qZY8QVUFKgc/DE+Wrej54PC0DIs3RNARLzV8sA=
Date:   Mon, 27 May 2019 10:53:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2 00/15] soundwire: corrections to ACPI/DisCo/Intel
 support
Message-ID: <20190527052356.GA15118@vkoul-mobl>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-19, 14:47, Pierre-Louis Bossart wrote:
> Now that we are done with cleanups, we can start fixing the code with
> actual semantic or functional changes.
> 
> This patchset corrects issues with Intel BIOS and hardware properties
> that prevented a successful init, aligns the code with the MIPI DisCo
> spec, adds rate-limiting for frequent errors and adds checks on number
> of links and PDIs.
> 
> With all these changes, the hardware can be initialized correctly and
> modules can be added/removed without issues on WhiskyLake and
> IceLake.
> 
> Parts of this code was initially written by my Intel colleagues Vinod
> Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
> longer with Intel or no longer involved in SoundWire development. When
> relevant, I explictly added a note in commit messages to give them
> credit for their hard work, but I removed their signed-off-by tags to
> avoid email bounces and avoid spamming them forever with SoundWire
> patches.

Applied all, thanks
-- 
~Vinod
