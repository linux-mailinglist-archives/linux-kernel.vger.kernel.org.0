Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C174D171531
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgB0KmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 05:42:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgB0KmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:42:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABDD91FB;
        Thu, 27 Feb 2020 02:42:17 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916A73F881;
        Thu, 27 Feb 2020 02:42:16 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:42:14 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        t1zhou@aliyun.com
Subject: Re: [PATCH v2 0/3] sched/debug: Add uclamp values to procfs
Message-ID: <20200227104213.4viewcfy5povydpj@e107158-lin.cambridge.arm.com>
References: <20200226124543.31986-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226124543.31986-1-valentin.schneider@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/20 12:45, Valentin Schneider wrote:
> Hi,
> 
> This is a small debug series I've been sitting on. It's been helpful in
> testing and reviewing some uclamp stuff, for instance the issue Qais fixed
> at [1] was really easy to observe with those debug prints.
> 
> [1]: https://lore.kernel.org/lkml/20191224115405.30622-1-qais.yousef@arm.com/

That would be handy indeed. And nice cleanup along the way.

For the series

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Cheers

--
Qais Yousef

> 
> Cheers,
> Valentin
> 
> Revisions
> =========
> 
> v1 -> v2
> --------
> o Added parentheses for the casting part of the macros (Tao)
> 
> Valentin Schneider (3):
>   sched/debug: Remove redundant macro define
>   sched/debug: Bunch up printing formats in common macros
>   sched/debug: Add task uclamp values to SCHED_DEBUG procfs
> 
>  kernel/sched/debug.c | 44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> --
> 2.24.0
> 
