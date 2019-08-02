Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347CF7FF6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391829AbfHBRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbfHBRUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:20:20 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F5820B7C;
        Fri,  2 Aug 2019 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564766420;
        bh=wff88TISwv4kNTmhGtyEipuGD0E7PUtarxD7H8iS0SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+tR6OQhKe0wWMRkqMN6KQnpI/DTVmFk6QzZqPkddtBsUHhvPPUzYN6L8BR3jPuE7
         tcbJ8KWr5Pf3vlSnPQyz0HzUkzARjcEJhXYa5Pzhwt/rmTqufeydN74lJ4yrTyCyil
         9WrtKkDgs504UqUzV6oeNBXNtRGaE4bgLCGLtAF4=
Date:   Fri, 2 Aug 2019 22:49:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Rander Wang <rander.wang@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 26/40] soundwire: cadence_master: fix divider setting
 in clock register
Message-ID: <20190802171906.GB12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
> 
> The existing code uses an OR operation which would mix the original
> divider setting with the new one, resulting in an invalid
> configuration that can make codecs hang.

This looked fine but fails to apply, feel free to send as a fix

-- 
~Vinod
