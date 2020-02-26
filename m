Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A338816F9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBZIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgBZIja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:39:30 -0500
Received: from localhost (unknown [171.76.87.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543DF2084E;
        Wed, 26 Feb 2020 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582706370;
        bh=ytnd76MiJNXHaByv3oTOm1FC8A8dH3TLYQBSH6N48gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FobR3kDeMc1b6SJ5ntF1e9FyWd/X3c7IvZrwuxwC/70H3/1rHSIuOosbIGG/lAsE7
         VKNIIjqgD1ObRpAcNKqEOai3Jn1N+ldb9md4zeD9+pItvanmPMDN8iiaft+uucIGby
         /k05jk3I/ePWBdlL4K8W/IdNQwz42NrPMH6P2p18=
Date:   Wed, 26 Feb 2020 14:09:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/3] soundwire: cadence: remove useless prototypes
Message-ID: <20200226083926.GW2618@vkoul-mobl>
References: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
 <20200225170041.23644-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225170041.23644-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-20, 11:00, Pierre-Louis Bossart wrote:
> These prototypes are no longer used, remove.

Applied, thanks

-- 
~Vinod
