Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90866A43C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfGPIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 04:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfGPIvP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BD68308A963;
        Tue, 16 Jul 2019 08:51:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1381001DC0;
        Tue, 16 Jul 2019 08:51:13 +0000 (UTC)
Date:   Tue, 16 Jul 2019 10:51:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf diff: Report noisy for cycles diff
Message-ID: <20190716085112.GC22317@krava>
References: <20190712075355.16019-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712075355.16019-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 08:51:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:53:55PM +0800, Jin Yao wrote:
> This patch prints the stddev and hist for the cycles diff of
> program block. It can help us to understand if the cycles diff
> is noisy or not.

I'm getting compile error:

  CC       builtin-diff.o
builtin-diff.c: In function ‘compute_cycles_diff’:
builtin-diff.c:712:10: error: taking the absolute value of unsigned type ‘u64’ {aka ‘long unsigned int’} has no effect [-Werror=absolute-value]
  712 |          labs(pair->block_info->cycles_spark[i] -
      |          ^~~~
cc1: all warnings being treated as errors
mv: cannot stat './.builtin-diff.o.tmp': No such file or directory


jirka
