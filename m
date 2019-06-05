Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEA35B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfFELah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:30:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19331 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFELah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:30:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf7a7da0000>; Wed, 05 Jun 2019 04:30:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 04:30:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 05 Jun 2019 04:30:36 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Jun
 2019 11:30:33 +0000
Subject: Re: [PATCH] clk: tegra210: Fix default rates for HDA clocks
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
References: <1559121501-8566-1-git-send-email-jonathanh@nvidia.com>
 <20190529134625.GD17223@ulmo>
 <5f2b8f8d-f3e5-fab8-8cf0-fa8a3e917845@nvidia.com>
Message-ID: <f2757c84-363c-cef0-db9d-c4e4423200b5@nvidia.com>
Date:   Wed, 5 Jun 2019 12:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5f2b8f8d-f3e5-fab8-8cf0-fa8a3e917845@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559734234; bh=0p6mNaMjQPO8lN/MkCvb/luHUOwN9kFQfK7z4rY4vdA=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dl01BDGHx9+fNyiOUX2eAW9yEZJO15tTStvOb+pqXTH76B5v114SjSrkN+h+vE+gC
         Cg2oj9A8y5B9bzGhRTieqpsu55HLrhJLix+58bWEmwDeahaPRnjD9CqaGGAb1hjsDS
         Jc8hXb1Zm3ysIYx93gRyEzozYe3Fep8XWDhU+Ld3hBvGv+oR3GvsvdtxOhMkqJhoDW
         1TbiSOjm1BAXipzOFFGmQz3QTPKuZnV/FL2/ClgX3sXsOfZ8OqHqVQ2xbbamGRbqcA
         bpD19rrTdc7L2LBQb4C1QI4iTgaPBh1ZdYRNWhBNGhRl74IKWytAFwgrIoM9WBXB12
         hnoTqTFqH5O5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2019 15:58, Jon Hunter wrote:
> 
> On 29/05/2019 14:46, Thierry Reding wrote:
>> On Wed, May 29, 2019 at 10:18:21AM +0100, Jon Hunter wrote:
>>> Currently the default clock rates for the HDA and HDA2CODEC_2X clocks
>>> are both 19.2MHz. However, the default rates for these clocks should
>>> actually be 51MHz and 48MHz, respectively. Correct the default clock
>>> rates for these clocks by specifying them in the clock init table for
>>> Tegra210.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>  drivers/clk/tegra/clk-tegra210.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> Does this fix anything? Should this be backported to stable releases?
> 
> Good point. We are aligning the clock configuration with what we ship.
> So I thought for completeness it would be good to test HDA playback
> across the various sample-rates we support (32kHz to 192kHz) but with or
> without this patch I am not hearing anything. Let me check on this with
> Sameer as I would like to see if we need to mark this for stable or not.
> 
>> Acked-by: Thierry Reding <treding@nvidia.com>

I have confirmed that this does fix HDA playback on Tegra210. Without
this fix, I am seeing the following messages during playback and
playback is distorted ...

Write error: -32,Broken pipe
[   15.069335] tegra-mc 70019000.memory-controller: hdar: read
@0x0000000000000000: EMEM address decode error (EMEM decode error)
Write error: -32,Broken pipe
[   15.465362] tegra-mc 70019000.memory-controller: hdar: read
@0x0000000000000000: EMEM address decode error (EMEM decode error)
Write error: -32,Broken pipe
[   15.858615] tegra-mc 70019000.memory-controller: hdar: read
@0x0000000000000000: EMEM address decode error (EMEM decode error)
W

Do you want me to update the change and resend?

Jon

-- 
nvpublic
