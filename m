Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69E729A08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbfEXO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 10:26:35 -0400
Received: from foss.arm.com ([217.140.101.70]:44164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390885AbfEXO0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:26:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234CAA78;
        Fri, 24 May 2019 07:26:34 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36243F575;
        Fri, 24 May 2019 07:26:32 -0700 (PDT)
Date:   Fri, 24 May 2019 15:26:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: clock: set rate_discrete
Message-ID: <20190524142630.GB4408@e107155-lin>
References: <20190522102912.1032-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522102912.1032-1-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:15:21AM +0000, Peng Fan wrote:
> The rate_discrete needs to be assigned to clk->rate_discrete,
> then scmi_clk_round_rate could get the value.
>

Thanks for the fix, applied.

> Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock protocol")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 30fc04e28431..0a194af92438 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -185,6 +185,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
>  	if (rate_discrete)
>  		clk->list.num_rates = tot_rate_cnt;
>  
> +	clk->rate_discrete = rate_discrete;
> +
>  err:
>  	scmi_xfer_put(handle, t);
>  	return ret;
> -- 
> 2.16.4
> 
