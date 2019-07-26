Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4464176AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfGZOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:00:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:42260 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387395AbfGZOAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:00:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322045973"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:00:28 -0700
Subject: Re: [alsa-devel] [RFC PATCH 04/40] soundwire: intel: add debugfs
 register dump
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <9d5bc940-eadd-4f82-0bac-6a731369436d@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d231f6b0-555a-8c45-1a9a-215c73171923@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:00:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9d5bc940-eadd-4f82-0bac-6a731369436d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 4:35 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
>> +static void intel_debugfs_init(struct sdw_intel *sdw)
>> +{
>> +    struct dentry *root = sdw->cdns.bus.debugfs;
>> +
>> +    if (!root)
>> +        return;
>> +
>> +    sdw->fs = debugfs_create_dir("intel-sdw", root);
>> +    if (IS_ERR_OR_NULL(sdw->fs)) {
>> +        dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
>> +        sdw->fs = NULL;
>> +        return;
>> +    }
>> +
>> +    debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
>> +                &intel_reg_fops);
>> +
>> +    sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs);
>> +}
> 
> I believe there should be dummy equivalent of _init and _exit if debugfs 
> is not enabled (if these are defined already and I've missed it, please 
> ignore).

I think the direction is just to keep going if there is an error or 
debufs is not enabled.

> 
>> +static void intel_debugfs_exit(struct sdw_intel *sdw)
>> +{
>> +    debugfs_remove_recursive(sdw->fs);
>> +}
