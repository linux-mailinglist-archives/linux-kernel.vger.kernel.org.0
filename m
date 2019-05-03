Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF1130F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfECPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:11:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35444 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfECPLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECA7374;
        Fri,  3 May 2019 08:11:53 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D903F557;
        Fri,  3 May 2019 08:11:52 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] coresight: funnel: Support static funnel
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shiwanglai@hisilicon.com
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-5-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <16ae9127-b282-e6b8-3a6c-5165c8618bb4@arm.com>
Date:   Fri, 3 May 2019 16:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412102738.12679-5-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo,


On 12/04/2019 11:27, Leo Yan wrote:
> Since CoreSight hardware topology can use a 'hidden' funnel in the
> trace data path, this kind funnel doesn't have register for accessing
> and is used by default from hardware design perspective.  Below is an
> example for related hardware topology:
> 
>    +------+  +------+
>    | cpu0 |->| ETM  |-\
>    +------+  +------+  \-> +--------+  +-----+
>     ......                 | Funnel |->| ETF |-\    Hidden funnel
>    +------+  +------+  /-> +--------+  +-----+  \        |
>    | cpu3 |->| ETM  |-/                          \       V
>    +------+  +------+                             \-> +--------+
>                                                       | Funnel |-> ...
>    +------+  +------+                             /-> +--------+
>    | cpu4 |->| ETM  |-\                          /
>    +------+  +------+  \-> +--------+  +-----+  /
>     ......                 | Funnel |->| ETF |-/
>    +------+  +------+  /-> +--------+  +-----+
>    | cpu7 |->| ETM  |-/
>    +------+  +------+
> 
> The CoreSight funnel driver only supports dynamic funnel with
> registration register resource, thus it cannot support for the static
> funnel case and it's impossible to create trace data path for this case.
> 
> This patch is to extend CoreSight funnel driver to support both for
> static funnel and dynamic funnel.  For the dynamic funnel it reuses the
> code existed in the driver, for static funnel the driver will support
> device probe if without providing register resource and the driver skips
> registers accessing when detect the register base is NULL.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>   
> +	if (of_device_is_compatible(np, "arm,coresight-funnel"))
> +		pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
> +

Given that we now warn about OBSOLETE bindings, please could you fix
the existing DTS in the kernel source tree to use the new binding ?
Similarly for the replicator.

Suzuki
