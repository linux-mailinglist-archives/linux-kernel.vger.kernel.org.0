Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5260513A10D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 07:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 01:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgANGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:37:43 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FBF207FD;
        Tue, 14 Jan 2020 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983862;
        bh=NBIza/ymMVuUCaPXacKYwhUHlMW1KvmRdb+puHl++z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evne6lx6eGCVUOFd4izSpN2llgzRkiJK5XATRjbordGx98m5YSbiX3nWlx1xHgo3O
         hS+nBOSpmAhra3jWnzS4vuBkT4ySiFB6eXb6d5oRHSwXmJ+jFExefT/twUSZuwFWvk
         /e0Xa/BPdQZ6BfL5ge0nvLdikwUtIvop2Ps37jKw=
Date:   Tue, 14 Jan 2020 12:07:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: bus: fix device number leak on errors
Message-ID: <20200114063738.GG2818@vkoul-mobl>
References: <20200113225637.17313-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113225637.17313-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 16:56, Pierre-Louis Bossart wrote:
> If the programming of the dev_number fails due to an IO error, a new
> device_number will be assigned, resulting in a leak.
> 
> Make sure we only assign a device_number once per Slave device.

Although I am not sure if this would be a leak, we assign a new num and
old number should have gotten recycled as they would be unattached
status.

Anyway this is good improvement as it helps to debug having same
dev_num, so Applied, thanks

-- 
~Vinod
