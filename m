Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3B174198
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 22:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB1VqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 16:46:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:59612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB1VqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:46:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 13:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="411532257"
Received: from spackerm-mobl2.amr.corp.intel.com (HELO [10.255.231.253]) ([10.255.231.253])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 13:46:00 -0800
Subject: Re: [PATCH 2/8] soundwire: intel: transition to
 sdw_master_device/driver support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
 <20200228073416.GC2898712@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dd163b7f-0a12-6f99-942b-a098551b3354@linux.intel.com>
Date:   Fri, 28 Feb 2020 10:01:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228073416.GC2898712@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/20 1:34 AM, Greg KH wrote:
> On Thu, Feb 27, 2020 at 04:32:00PM -0600, Pierre-Louis Bossart wrote:
>> +static struct sdw_master_driver intel_sdw_driver = {
>> +	.driver = {
>> +		.name = "intel-master",
>> +		.owner = THIS_MODULE,
> 
> Nit, setting .owner isn't needed anymore, as the core code handles this
> for you, right?

Ah, yes indeed, the following code takes care of it. Thanks for spotting 
this!

I can remove this assignment in a follow-up patch if that's alright with 
Vinod.

+#define sdw_register_master_driver(drv) \
+	__sdw_register_master_driver(drv, THIS_MODULE)

+/**
+ * __sdw_register_master_driver() - register a SoundWire Master driver
+ * @mdrv: 'Master driver' to register
+ * @owner: owning module/driver
+ *
+ * Return: zero on success, else a negative error code.
+ */
+int __sdw_register_master_driver(struct sdw_master_driver *mdrv,
+				 struct module *owner)
+{
+	mdrv->driver.bus = &sdw_bus_type;
+
+	if (!mdrv->probe) {
+		pr_err("driver %s didn't provide SDW probe routine\n",
+		       mdrv->driver.name);
+		return -EINVAL;
+	}
+
+	mdrv->driver.owner = owner;
