Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE718F513
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgCWMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgCWMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:54:42 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A27E206F9;
        Mon, 23 Mar 2020 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584968081;
        bh=pUVVBotV/ymFMfsonWmwbWJ7zjKKGrfnxqC6V2nQWA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6w9I3r/FO7A14vzRiCkdy73REFHaWNMXx7GiToMgogTkRYVFVzAhJLrvot6c/1C1
         OVPdY4i3TdvzLFYkCj19x7o6762WJVjFS9R4MUh69LShLOLXXY8Iy6gwSYaDxaAKsT
         oBTzSCNitIarKrgm3cFUkb+SAlF8O/Z/qYaKmzDc=
Date:   Mon, 23 Mar 2020 18:24:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/5] soundwire: bus_type: add master_device/driver support
Message-ID: <20200323125437.GP72691@vkoul-mobl>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
 <20200320162947.17663-2-pierre-louis.bossart@linux.intel.com>
 <5d78f0f8-7418-e50e-6f0b-dd6988224744@linaro.org>
 <626a074b-06a9-01a0-334f-3aaed1f7ed76@linux.intel.com>
 <286e7ae2-6677-1d92-5ae2-9250d3ff7a9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286e7ae2-6677-1d92-5ae2-9250d3ff7a9d@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-20, 11:06, Srinivas Kandagatla wrote:
> 
> 
> On 20/03/2020 18:17, Pierre-Louis Bossart wrote:
> > Thanks for the quick review Srinivas,
> > 
> > > This patch in general is missing device tree support for both
> > > matching and uevent so this will not clearly work for Qualcomm
> > > controller unless we do via platform bus, which does not sound
> > > right!
> > 
> > see other email, the platform bus is handled by a platform
> > device/driver. There was no intention to change that, it's by design
> > rather than an omission/error.
> 
> I understand this partly now!
> 
> This can be probably made better/clear by:
> renaming sdw_master_device_add to sdw_master_alloc and do a
> device_initialize() as part of this function in subsequent call to
> sdw_add_bus_master() we can do a device_add(). Doing this way will avoid a
> bit of unnecessary call to device_unregister by the controller driver, tbh
> which is confusing.
> 
> If the intended call sequence for controller is this (by keeping the parent
> bus type intact):
> 
> sdw_master_alloc/sdw_master_device_add()
> sdw_add_bus_master()

why not have single bus api which does all this :)

> Then we should also remove sdw_unregister_master_driver() and
> module_sdw_master_driver() all together. Having them makes the reader think
> that they can use module_sdw_master_driver directly without any parent bus
> like platform bus in this case.

Precisely, this is one of the reasons for not liking the
sdw_master_driver! It doesnt get used by anyone except Intel.

-- 
~Vinod
