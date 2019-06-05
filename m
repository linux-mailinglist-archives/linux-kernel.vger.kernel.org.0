Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12835BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfFELoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfFELop (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 204017E437;
        Wed,  5 Jun 2019 11:44:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33B231001E73;
        Wed,  5 Jun 2019 11:44:33 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:44:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190605114432.GD5868@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 05 Jun 2019 11:44:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:

SNIP

>  					   sort_compute);
>  }
>  
> +static int64_t
> +hist_entry__cmp_cycles_idx(struct perf_hpp_fmt *fmt __maybe_unused,
> +			   struct hist_entry *left __maybe_unused,
> +			   struct hist_entry *right __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  static void hists__process(struct hists *hists)
>  {
>  	if (show_baseline_only)
> @@ -746,6 +930,8 @@ static void data_process(void)
>  	struct perf_evsel *evsel_base;
>  	bool first = true;
>  
> +	memset(&dummy_al, 0, sizeof(dummy_al));

why is this needed? it's zero by static declaration, and it's never set, right?

jirka
