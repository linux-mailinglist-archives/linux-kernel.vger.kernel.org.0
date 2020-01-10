Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9C136C06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 12:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgAJLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 06:37:16 -0500
Received: from foss.arm.com ([217.140.110.172]:42818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgAJLhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:37:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498D01063;
        Fri, 10 Jan 2020 03:37:15 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9CA3F534;
        Fri, 10 Jan 2020 03:37:13 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:37:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] arch_topology: Adjust initial CPU capacities with
 current freq
Message-ID: <20200110113711.GB39451@bogus>
References: <20200109075214.31943-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109075214.31943-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 03:52:14PM +0800, Jeffy Chen wrote:
> The CPU freqs are not supposed to change before cpufreq policies
> properly registered, meaning that they should be used to calculate the
> initial CPU capacities.
> 
> Doing this helps choosing the best CPU during early boot, especially
> for the initramfs decompressing.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

[...]

> @@ -146,10 +153,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  				return false;
>  			}
>  		}
> -		capacity_scale = max(cpu_capacity, capacity_scale);
>  		raw_capacity[cpu] = cpu_capacity;
>  		pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
>  			cpu_node, raw_capacity[cpu]);
> +
> +		cpu_clk = of_clk_get(cpu_node, 0);
> +		if (!PTR_ERR_OR_ZERO(cpu_clk))
> +			per_cpu(max_freq, cpu) = clk_get_rate(cpu_clk) / 1000;
> +
> +		clk_put(cpu_clk);

I don't like to assume DVFS to be supplied only using 'clk'. So NACK!
We have other non-clk mechanism for CPU DVFS and this needs to simply
use cpufreq APIs to get frequency value if required.

--
Regards,
Sudeep
