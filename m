Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2D89F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHLNZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:25:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:26089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfHLNY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:24:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 06:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="375946636"
Received: from aferozpu-mobl2.amr.corp.intel.com (HELO [10.254.109.160]) ([10.254.109.160])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 06:24:57 -0700
Subject: Re: [alsa-devel] [PATCH 1/3] soundwire: add debugfs support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
 <20190810070139.GA6896@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <89e456e7-35a6-c7e9-64bd-1b30f0f019cc@linux.intel.com>
Date:   Mon, 12 Aug 2019 08:24:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810070139.GA6896@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   #Cadence Objs
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 49f64b2115b9..89d5f1537d9b 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>   		}
>>   	}
>>   
>> +	bus->debugfs = sdw_bus_debugfs_init(bus);
>> +
> 
> It's "nicer" to just put that assignment into sdw_bus_debugfs_init().
> 
> That way you just call the function, no need to return anything.

ok, thanks for the suggestion.

> 
>>   	/*
>>   	 * Device numbers in SoundWire are 0 through 15. Enumeration device
>>   	 * number (0), Broadcast device number (15), Group numbers (12 and
>> @@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>>   	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>   	struct sdw_bus *bus = slave->bus;
>>   
>> +	sdw_slave_debugfs_exit(slave->debugfs);
> 
> Same here, just pass in slave:
> 	sdw_slave_debugfs_exit(slave);
> and have that function remove the debugfs entry in the structure.  That
> way, if you are really paranoid about size, you could even drop the
> debugfs structure member from non-debugfs builds without any changes to
> bus.c or other non-debugfs files.

ok makes sense. will fix in v2.
