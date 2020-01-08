Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041C4133A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 05:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHEum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 23:50:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13314 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAHEum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:50:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e155f900001>; Tue, 07 Jan 2020 20:50:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:50:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 20:50:41 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:50:40 +0000
Subject: Re: Re: [PATCH] regmap: add iopoll-like atomic polling macro
To:     Mark Brown <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
 <20200107120902.GC4877@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <ae119533-6966-157a-d14b-365306907554@nvidia.com>
Date:   Wed, 8 Jan 2020 10:20:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107120902.GC4877@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578459024; bh=PCXVPzPJzd1sJcj4gbIN14vn1t4Dc66uzQlFAt6SvlE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lkDhV3VfhUSXG3APPOZzPXrKfJwaj/ui8XTRRS9uIPL32aNSwYv8c72VFEVKdBWQ3
         zffTU/J3GugtvXQNG2R/WnGWosU6XnzW2pkFmNS1Ob5u/0MfEI/UZeMkevNXmVw6mW
         cOHiG6FXLMyZZ4R5QgzYf6AJl9M2t4OiPqYAsSQFEaBTw1OhyslX9hFBX70kcGJ+dt
         sj2G0G+Ezh7+hTp3pX+66bPIXebEXh+bkGAS/81De7Lt8ELYbycFcfPxEhJ54IO+0L
         NmxgGtk2BOe4FHgGmNK+/DLQkD+A2WRbbFhttjzPl0/9RGwfVK6NzRG+SW7bfFjdm4
         NAzrS6M4i+yiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2020 5:39 PM, Mark Brown wrote:
> On Tue, Jan 07, 2020 at 03:58:09PM +0530, Sameer Pujar wrote:
>> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
>> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
>> is atomic version of already available 'regmap_read_poll_timeout' macro.
> In general regmap really can't be used in atomic contexts - we do have
> options to configure a regmap so it can be used there but they're not
> the default.  It'd be better if the comment mentioned this and warned
> against use with normal regmaps so people are less likely to try to use
> this in an atomic context when the regmap doesn't support that.

Oh I see.

While using regmap_read_poll_timeout() in snd_soc_dai_ops trigger 
callback, I was hitting below print.
"BUG: scheduling while atomic" and kernel panic there after.

While checking the documentation on snd_soc_dai_ops, it appears 
trigger() is in atomic context.
This means I cannot use regmap interface (with default configuration) in 
trigger().
The above issue went away with usage of 
regmap_read_poll_timeout_atomic() and now I think I just got lucky.

Also, with the limited testing, I did not see the issue in current 
linux-next, where as I hit above issue in
older kernel. Has anything changed with respect to above?

Though I need to test this, I guess there is a way to use non-atomic 
versions of PCM operations by setting
'nonatomic' flag in snd_pcm and continue to use 
regmap_read_poll_timeout(). In that case new macro may not
be necessary.

