Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D201A903
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfEKSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 14:17:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:49615 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfEKSRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 14:17:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 May 2019 11:17:03 -0700
X-ExtLoop1: 1
Received: from bgtruong-mobl1.amr.corp.intel.com (HELO [10.252.205.232]) ([10.252.205.232])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2019 11:17:01 -0700
Subject: Re: [alsa-devel] [PATCH v3 0/2] ASoC: Intel: Add Cometlake PCI IDs
To:     Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <20190510223929.165569-1-evgreen@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3cd20987-c251-f068-271a-546a83f27188@linux.intel.com>
Date:   Sat, 11 May 2019 13:17:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510223929.165569-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/19 5:39 PM, Evan Green wrote:
> 
> This small series adds PCI IDs for Cometlake platforms, for a
> dazzling audio experience.
> 
> This is based on linux-next's next-20190510.

Thank you Evan, looks good. For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Changes in v3:
> - Copy cnl_desc to new cml_desc, and avoid selecting cannonlake (Pierre-Louis)
> - Don't select CML_* in SND_SOC_INTEL_SKYLAKE (Pierre-Louis)
> 
> Changes in v2:
> - Add CML-H ID 0x06c8 (Pierre-Louis)
> - Add 0x06c8 for CML-H (Pierre-Louis)
> 
> Evan Green (2):
>    ASoC: SOF: Add Comet Lake PCI IDs
>    ASoC: Intel: Skylake: Add Cometlake PCI IDs
> 
>   sound/soc/intel/Kconfig                | 16 +++++++++++++
>   sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++
>   sound/soc/intel/skylake/skl.c          | 10 ++++++++
>   sound/soc/sof/intel/Kconfig            | 32 ++++++++++++++++++++++++++
>   sound/soc/sof/sof-pci-dev.c            | 28 ++++++++++++++++++++++
>   5 files changed, 102 insertions(+)
> 
