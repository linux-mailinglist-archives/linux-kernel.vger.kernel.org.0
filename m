Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1045A13A0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgANG0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 01:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgANG0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:26:10 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6C220678;
        Tue, 14 Jan 2020 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983169;
        bh=mxczTMmm2Pg7j2c9xrST05zaDM8ERDYB9c1YmyaS3VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzzCnZs/bXszwYJhlH0/Q+3HqrsYS0QlHJUgcEEdrVNoaLATlyVxn9/CeuIXWvCBo
         taTGVPmhzSqDBkQ7Ie/kW2ZVHpH1B2psOM6r2yr8ny4aLcv+jpak19PQHzTli77rnd
         Ftfr/ir+2XFglll1NWQU6ZK7jGO6ozBJ6bDlyi5g=
Date:   Tue, 14 Jan 2020 11:56:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: report slave_ids for each
 link to SOF driver
Message-ID: <20200114062605.GD2818@vkoul-mobl>
References: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
 <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 16:31, Pierre-Louis Bossart wrote:
> 
> 
> On 1/10/20 4:00 PM, Pierre-Louis Bossart wrote:
> > From: Bard Liao <yung-chuan.liao@linux.intel.com>
> > 
> > The existing link_mask flag is no longer sufficient to detect the
> > hardware and identify which topology file and a machine driver to load.
> > 
> > By reporting the slave_ids exposed in ACPI tables, the parent SOF
> > driver will be able to compare against a set of static configurations.
> > 
> > This patch only adds the interface change, the functionality is added
> > in future patches.
> 
> Vinod, this patch would need to be shared as an immutable tag for Mark, once
> this is done I can share the SOF parts that make use of the information (cf.
> https://github.com/thesofproject/linux/pull/1692 for reference)
> 
> Sorry we missed this in the earlier interface changes, we didn't think we
> would have so many hardware variations so quickly.

do you want the tag now..? I can provide... We are already in -rc6
and i will send PR to greg later this week...
-- 
~Vinod
