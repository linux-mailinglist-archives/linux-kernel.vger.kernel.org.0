Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72741B4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfEMLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 07:19:35 -0400
Received: from foss.arm.com ([217.140.101.70]:52904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMLTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:19:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC0D374;
        Mon, 13 May 2019 04:19:34 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8543F703;
        Mon, 13 May 2019 04:19:32 -0700 (PDT)
Date:   Mon, 13 May 2019 12:19:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.garry@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] perf vendor events arm64: Add Cortex-A57 and
 Cortex-A72 events
Message-ID: <20190513111930.GD6711@fuggles.cambridge.arm.com>
References: <20190502234704.7663-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502234704.7663-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:47:04PM -0700, Florian Fainelli wrote:
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index 59cd8604b0bd..69a73957e35c 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -13,6 +13,8 @@
>  #
>  #Family-model,Version,Filename,EventType
>  0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
> +0x00000000411fd07[[:xdigit:]],v1,arm/cortex-a57-a72,core

The 4-bit variant field should be 0x0, not 0x1. In fact, I think we could do
the same for the revision field too and use 0x0 instead of [[:xdigit:]] for
Cortex-A53, no? Our implementation of get_cpuid_str() masks these out for us.

Am I missing something?

Will
