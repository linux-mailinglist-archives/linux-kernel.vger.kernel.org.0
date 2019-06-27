Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C957D24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfF0H1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 03:27:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfF0H1U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD9EA308424C;
        Thu, 27 Jun 2019 07:27:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id C46075D9DE;
        Thu, 27 Jun 2019 07:27:18 +0000 (UTC)
Date:   Thu, 27 Jun 2019 09:27:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190627072718.GA24279@krava>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
 <1561644569-22306-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561644569-22306-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 07:27:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:09:26PM +0800, Jin Yao wrote:

SNIP

> +
> +static int process_block_per_sym(struct hist_entry *he)
> +{
> +	struct annotation *notes;
> +	struct cyc_hist *ch;
> +	struct block_hist *bh;
> +
> +	if (!he->ms.map || !he->ms.sym)
> +		return 0;
> +
> +	notes = symbol__annotation(he->ms.sym);
> +	if (!notes || !notes->src || !notes->src->cycles_hist)
> +		return 0;
> +
> +	bh = container_of(he, struct block_hist, he);
> +	init_block_hist(bh);
> +
> +	ch = notes->src->cycles_hist;
> +	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
> +		if (ch[i].num_aggr) {
> +			struct block_info *bi;
> +			struct hist_entry *he_block;
> +
> +			bi = block_info__new();
> +			if (!bi)
> +				return -1;
> +
> +			init_block_info(bi, he->ms.sym, &ch[i], i);
> +			he_block = hists__add_entry_block(&bh->block_hists,
> +							  NULL, &dummy_al, bi);

nit, it's the only caller of hists__add_entry_block, so we don't need
the 'ops' argument in there

other than this, this all looks good to me

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
