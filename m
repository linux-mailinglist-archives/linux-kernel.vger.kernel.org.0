Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D92898C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHLIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 04:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfHLIf6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98A792A41;
        Mon, 12 Aug 2019 08:35:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE9571D1;
        Mon, 12 Aug 2019 08:35:56 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:35:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
Message-ID: <20190812083555.GC11752@krava>
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809233029.12265-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 12 Aug 2019 08:35:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 07:30:29AM +0800, Jin Yao wrote:

SNIP

> +		if (vals[i] != 0)
> +			return 0;
> +	return 1;
> +}
> +
> +static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
> +{
> +	int len = n, printed;
> +
> +	if (len <= 1)
> +		return 0;
> +
> +	if (len > NUM_SPARKS)
> +		len = NUM_SPARKS;
> +	if (all_zero(svals, len))
> +		return 0;
> +
> +	printed = print_spark(bf, size, svals, len);
> +	printed += scnprintf(bf + printed, size - printed, " ");
> +
> +	if (n > NUM_SPARKS)
> +		printed += scnprintf(bf + printed, size - printed, "..");

will this '..' ever be printed? I can't see that even if I enlarge
the column width..

jirka
