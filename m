Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD157FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfF0KBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 06:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF0KBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:01:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E0A20843;
        Thu, 27 Jun 2019 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561629683;
        bh=PQxefsGle01iEZR2XS4HOsAv02vQNYRGVUNsjXKAbWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZzbPGqAUmv/Zs/fxJoSjOy+Os+mdbYK7ojW3/2VEANvqilJMAl1wXx8av3eIk+Wh
         GNZF+Dn4RfD6KWb7gpc//dq1wlfmOU/FPo6YJTH+POZGtYOinGywummuhz64khHTCa
         GUI6s9Yg8U+1/AzJaTcE0rnwW67Z4gBloLUvIo5A=
Date:   Thu, 27 Jun 2019 11:01:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
Message-ID: <20190627100118.nfveq4oktomqybtx@willie-the-truck>
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
 <1560534144-13896-2-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560534144-13896-2-git-send-email-gkulkarni@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:42:45PM +0000, Ganapatrao Kulkarni wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@marvell.com>
> 
> Add documentation for Cavium Coherent Processor Interconnect (CCPI2) PMU.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> ---
>  Documentation/perf/thunderx2-pmu.txt | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> index dffc57143736..62243230abc3 100644
> --- a/Documentation/perf/thunderx2-pmu.txt
> +++ b/Documentation/perf/thunderx2-pmu.txt
> @@ -2,24 +2,26 @@ Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
>  =============================================================
>  
>  The ThunderX2 SoC PMU consists of independent, system-wide, per-socket
> -PMUs such as the Level 3 Cache (L3C) and DDR4 Memory Controller (DMC).
> +PMUs such as the Level 3 Cache (L3C), DDR4 Memory Controller (DMC) and
> +Cavium Coherent Processor Interconnect (CCPI2).
>  
>  The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles.
>  Events are counted for the default channel (i.e. channel 0) and prorated
>  to the total number of channels/tiles.
>  
> -The DMC and L3C support up to 4 counters. Counters are independently
> -programmable and can be started and stopped individually. Each counter
> -can be set to a different event. Counters are 32-bit and do not support
> -an overflow interrupt; they are read every 2 seconds.
> +The DMC, L3C support up to 4 counters and CCPI2 support up to 8 counters.

The DMC and L3C support up to 4 counters, while the CCPI2 supports up to 8
counters.

> +Counters are independently programmable and can be started and stopped
> +individually. Each counter can be set to a different event. DMC and L3C
> +Counters are 32-bit and do not support an overflow interrupt; they are read

Counters -> counters

> +every 2 seconds. CCPI2 counters are 64-bit.

Assuming CCPI2 also doesn't support an overflow interrupt, I'd reword these
two sentences as:

  None of the counters support an overflow interrupt and therefore sampling
  events are unsupported. The DMC and L3C counters are 32-bit and read every
  2 seconds. The CCPI2 counters are 64-bit and assumed not to overflow in
  normal operation.

>  PMU UNCORE (perf) driver:
>  
>  The thunderx2_pmu driver registers per-socket perf PMUs for the DMC and
> -L3C devices.  Each PMU can be used to count up to 4 events
> -simultaneously. The PMUs provide a description of their available events
> -and configuration options under sysfs, see
> -/sys/devices/uncore_<l3c_S/dmc_S/>; S is the socket id.
> +L3C devices.  Each PMU can be used to count up to 4(DMC/L3C) or up to 8

Space between 4 and (

Will
