Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4E13D996
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAPMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgAPMFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:05:04 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF6A20663;
        Thu, 16 Jan 2020 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579176303;
        bh=Ye1+UG3M999GBdvHyzVG7SyBKkNJZ2O4bs+/AbBdoqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3qNDd+z0TpJeegASC2kB0iOsLKBwD7+4GtXLK7MjDeNbeH/9luaDCQVgp0b9+/fZ
         4yGO/1TXQ0McC4CY5tH6NcEukOrKPs4NbALZheS00cvmwhIm8adx/l/T8ivnrLTPD1
         NqO/pa2N06M58q7HdZmVxsc3CrvK1L2WknQxuhwU=
Date:   Thu, 16 Jan 2020 17:34:59 +0530
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
Subject: Re: [PATCH] soundwire: cadence: fix kernel-doc parameter descriptions
Message-ID: <20200116120459.GP2818@vkoul-mobl>
References: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 17:31, Pierre-Louis Bossart wrote:
> Fix previous update, bad git merge likely. oops.

Applied, thanks

-- 
~Vinod
