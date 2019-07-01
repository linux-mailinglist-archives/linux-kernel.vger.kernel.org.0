Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11F82D16A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfE1WWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 18:22:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:57608 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1WWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:22:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:22:43 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 15:22:42 -0700
Received: from msakib-mobl2.amr.corp.intel.com (unknown [10.254.189.121])
        by linux.intel.com (Postfix) with ESMTP id EF0F25802C9;
        Tue, 28 May 2019 15:22:40 -0700 (PDT)
Subject: Re: linux-next: Fixes tags need some work in the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20190529075614.150b1877@canb.auug.org.au>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <44bbb3f1-5674-6431-5818-d8b5cca708dd@linux.intel.com>
Date:   Tue, 28 May 2019 17:22:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529075614.150b1877@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 4:56 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    be1b577d0178 ("ASoC: SOF: Intel: hda: fix the hda init chip")
> 
> Fixes tag
> 
>    Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel DSP")

Sorry about that, not sure how I managed to add an off-by-one in all 
these tags. Checkpatch.pl --strict did not report any issues, something 
must be broken either in my setup or the script.
Not sure how I can fix this now?
