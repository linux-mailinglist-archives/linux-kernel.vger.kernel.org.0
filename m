Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7513C1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAOMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 07:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgAOMt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:49:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0A820728;
        Wed, 15 Jan 2020 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579092596;
        bh=8+5Lx4bziJE+D7yOcfBU0J1xPAxTfUpO+7C4imVadaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGVyvxCMBlSbrCTbNORz8BlKVsBUUHs1By1YRj4ySf5n7cwHv9R96FNjQ7vfm9FpN
         P85NNSn4AcsiKRjJBi9PhifixE8/Km1cUpMq1MVRdcKkGOoaK2Nj++H6Gf+bRDQoHk
         dZP3hsj8dPLKz74sPXFcdMK/08BHhSdc52rPswvY=
Date:   Wed, 15 Jan 2020 12:49:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Frank Li <frank.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/imx_ddr: Fix cpu hotplug state cleanup
Message-ID: <20200115124951.GG21692@willie-the-truck>
References: <ed960d212fb6bec383c7cdfc73362e5770bda9cd.1579033493.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed960d212fb6bec383c7cdfc73362e5770bda9cd.1579033493.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:25:46PM +0200, Leonard Crestez wrote:
> This driver allocates a dynamic cpu hotplug state but never releases it.
> If reloaded in a loop it will quickly trigger a WARN message:
> 
> 	"No more dynamic states available for CPU hotplug"
> 
> Fix by calling cpuhp_remove_multi_state on remove like several other
> perf pmu drivers.
> 
> Also fix the cleanup logic on probe error paths: add the missing
> cpuhp_remove_multi_state call and properly check the return value from
> cpuhp_state_add_instant_nocalls.
> 
> Fixes: 9a66d36cc7ac ("drivers/perf: imx_ddr: Add DDR performance counter support to perf")
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> 
> Changes since v1:
> * Handle cpuhp_state_add_instant_nocalls error with additional error
> labels.
> Link to v1: https://patchwork.kernel.org/patch/11302423/
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Thanks, I've queued this up with Joakim's ack.

Will
