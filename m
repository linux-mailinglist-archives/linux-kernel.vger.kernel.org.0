Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22414E3266
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439084AbfJXMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 08:31:26 -0400
Received: from foss.arm.com ([217.140.110.172]:49906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJXMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:31:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8672DCA2;
        Thu, 24 Oct 2019 05:31:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BFAF3F71A;
        Thu, 24 Oct 2019 05:31:09 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:31:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [trivial] perf: Spelling s/EACCESS/EACCES/,
 s/privilidge/privilege/
Message-ID: <20191024123106.GE4300@lakrids.cambridge.arm.com>
References: <20191024122904.12463-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024122904.12463-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:29:04PM +0200, Geert Uytterhoeven wrote:
> As per POSIX, the correct spelling of the error code is EACCES:
> 
> include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks sane to me; brings the documentation into line with reality given
EACCESS doesn't exist in tree.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v2:
>   - Add POSIX reference,
>   - Also correct privilidges in the same line.
> ---
>  include/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132c29c..68ccc5b1913b485b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -292,7 +292,7 @@ struct pmu {
>  	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
>  	 *  -EINVAL	-- @event is for this PMU but @event is not valid
>  	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
> -	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
> +	 *  -EACCES	-- @event is for this PMU, @event is valid, but no privileges
>  	 *
>  	 *  0		-- @event is for this PMU and valid
>  	 *
> -- 
> 2.17.1
> 
