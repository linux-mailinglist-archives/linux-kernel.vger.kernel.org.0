Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC009DBC34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 06:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409562AbfJRE6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 00:58:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbfJRE6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D5A24146CF6F3;
        Thu, 17 Oct 2019 21:58:04 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:58:04 -0700 (PDT)
Message-Id: <20191017.215804.307604979788731139.davem@davemloft.net>
To:     wangkefeng.wang@huawei.com
Cc:     pmladek@suse.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH v2 06/33] sparc: Use pr_warn instead of pr_warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191018031850.48498-6-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
        <20191018031850.48498-1-wangkefeng.wang@huawei.com>
        <20191018031850.48498-6-wangkefeng.wang@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 21:58:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 18 Oct 2019 11:18:23 +0800

> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
