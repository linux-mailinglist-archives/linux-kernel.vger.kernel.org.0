Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B158FF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHPJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 05:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfHPJoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:44:22 -0400
Received: from localhost (unknown [117.99.90.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FFA20644;
        Fri, 16 Aug 2019 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565948661;
        bh=RkU/EVqq1vhFMUqIe13oGkZ0ZSndMkAlwA9Q5IYDAUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpYXQ5ItQAhKKEjq3xmvtyw4GoGUmqLAGIUXwwSuYxyZz8+XGNNfVnia17cXeBCj2
         cADfpm5rceB7ENMlPn4bBsDchHOrNt9iF9dzPFvXqioHGibNhOQn/Jz8fUFQROLtWA
         +hvSgeo5JJVi9s9RleY896YefeQCwXB/l4UZ3lXQ=
Date:   Fri, 16 Aug 2019 15:13:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com
Subject: Re: [PATCH v2 0/3] soundwire: debugfs support for 5.4
Message-ID: <20190816094308.GA12733@vkoul-mobl.Dlink>
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-08-19, 18:59, Pierre-Louis Bossart wrote:
> This patchset enables debugfs support and corrects all the feedback
> provided on an earlier RFC ('soundwire: updates for 5.4')
> 
> There is one remaining hard-coded value in intel.c that will need to
> be fixed in a follow-up patchset not specific to debugfs: we need to
> remove hard-coded Intel-specific configurations from cadence_master.c
> (PDI offsets, etc).
> 
> Changes since v1 (Feedback from GKH)
> Handle debugfs in a more self-contained way (no dentry as return or parameter)
> Used CONFIG_DEBUG_FS in structures and code to make it easier to
> remove if need be.
> No functional change for register dumps.
> 
> Changes since RFC (Feedback from GKH, Vinod, Guennadi, Cezary, Sanyog):
> removed error checks
> used DEFINE_SHOW_ATTRIBUTE and seq_file
> fixed copyright dates
> fixed SPDX license info to use GPL2.0 only
> fixed Makefile to include debugfs only if CONFIG_DEBUG_FS is selected
> used static inlines for fallback compilation
> removed intermediate variables
> removed hard-coded constants in loops (used registers offsets and
> hardware capabilities)
> squashed patch 3

These looks good but failed to apply. Please rebase on soundwire-next
and resend

Thanks

-- 
~Vinod
