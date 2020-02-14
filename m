Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046CD15D19D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 06:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgBNF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 00:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgBNF0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:26:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A38222C2;
        Fri, 14 Feb 2020 05:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581658000;
        bh=EwGlcBQLRDDlyORXL4Qa6tWXh3pGrLaQjCBL1Fd4YKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=02xFsuOjGczxd5yglCo7VaB/PzBoec7K/tdaZuRNng/9F+xRlcJQbIvQyPaG4xMfi
         vkW4CRn1R1SCeV19ZL8TRdlI4Eo8p9MtBLNqBlJmvupD0wRwwR8CJSBY4vG+jzJ1Cc
         VYpCD/s1QOwRUh/+5sydb4/CfyEVG1qVYOfRTxhQ=
Date:   Thu, 13 Feb 2020 21:26:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Li Xinhai" <lixinhai.lxh@gmail.com>
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in
 queue_pages_test_walk()
Message-Id: <20200213212639.90c5eef95e4e3a4211dcf0a9@linux-foundation.org>
In-Reply-To: <89FF2013-1B59-4702-BF1B-A200C6785B37@lca.pw>
References: <d6c1a434-8670-97f4-345c-28c8007a25ce@linux.alibaba.com>
        <89FF2013-1B59-4702-BF1B-A200C6785B37@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 15:23:08 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Jan 27, 2020, at 2:57 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
> > 
> > Dumping more information to help debugging. I don't run into related bug personally.
> 
> This is a relatively weak justification for merging. If we are keeping accepting those mindless debugging patches, the workload will be unbearable for all.

I think it's OK.  If this ever triggers the kernel is dead, so the
volume of output isn't a problem.  And if it triggers, the more info
the better.

