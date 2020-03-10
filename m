Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809C41803AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCJQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:38:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:1135 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCJQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:38:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="321858019"
Received: from djdickof-mobl.amr.corp.intel.com (HELO [10.252.192.103]) ([10.252.192.103])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2020 09:38:37 -0700
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
 <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
 <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a2b24f84-0f9a-29ab-8748-dc5a26c05ffa@linux.intel.com>
Date:   Tue, 10 Mar 2020 10:53:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

>>  > My recommendation would be to add a DisCo property stating the
>> WordLength value can be used by the bus code but not written to the 
>> Slave device registers.
> 
> Does something like "mipi-sdw-read-only-wordlength" as slave property, 
> make sense?

The properties can be handled at two levels.

First, you'd want to change include/linux/soundwire/sdw.h, and add a new 
field in

struct sdw_dpn_prop {
	u32 num;
	u32 max_word;
	u32 min_word;
	u32 num_words;
	u32 *words;
+       bool read_only_wordlength;

Once this is added, along with the code that bypasses the programming of 
DPn_BlockCtrl1, the implementation has two choices:

a) hard-code the field value in the codec driver.

b) read the property from firmware with the DisCo helpers.

There is no requirement that all properties be read from firmware, and 
if you look at existing code base sdw_slave_read_prop() is currently 
unused, each codec implements its own .read_prop() callback.

We really wanted to be pragmatic, and give the possibility to either 
override bad firmware or extend incomplete firmware to avoid coupling OS 
and firmware too much. If you foresee cases where this implementation 
might vary and firmware distribution is not a problem, then a property 
read would make sense.

Just once procedural reminder that all 'mipi-sdw' properties are handled 
by the MIPI software WG, so we'd need to have this property added in a 
formal MIPI document update.

I suggest you talk with Lior first on this.

Hope this helps
-Pierre
