Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9591E1E891
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEOGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:51:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:57740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOGvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 23:51:10 -0700
X-ExtLoop1: 1
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 23:51:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Yabin Cui <yabinc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased data_head.
In-Reply-To: <20190515003059.23920-1-yabinc@google.com>
References: <20190515003059.23920-1-yabinc@google.com>
Date:   Wed, 15 May 2019 09:51:07 +0300
Message-ID: <87ef50xlb8.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yabin Cui <yabinc@google.com> writes:

> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 674b35383491..0b9aefe13b04 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>  	 * IRQ/NMI can happen here, which means we can miss a head update.
>  	 */
>  
> -	if (!local_dec_and_test(&rb->nest))
> +	if (local_read(&rb->nest) > 1) {
> +		local_dec(&rb->nest);

What stops rb->nest changing between local_read() and local_dec()?

Regards,
--
Alex
