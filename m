Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094D7156EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 06:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBJFpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 00:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJFpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:45:31 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD3720715;
        Mon, 10 Feb 2020 05:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581313530;
        bh=a6GtMCJ6LYEgHRTB2twm3iLrqc5jPa8TECt9e1cyYmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7/b7G5ZgOyBEAo9Vq/29ja3ynt+kXXDaiBfqcKrJtMwLtsgF+kEzZodYZQwgB5+U
         Cix0Nfj9oMg3bLpFm+fVwcg3+v9VZsKKt7+QGF2d2QtEz2R8aAA3yo+Oui770qwzwt
         atl0lve2djKpBApDNLd4yMuWzgktRx+JnKs2YjiE=
Date:   Sun, 9 Feb 2020 21:45:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm: fix tick_sched timer blocked by
 pgdat_resize_lock
Message-Id: <20200209214530.e17798f182000b7726a621c5@linux-foundation.org>
In-Reply-To: <39eb8ac4-bdb2-bdf2-9189-2d088edb43c1@linux.alibaba.com>
References: <20200110082510.172517-2-shile.zhang@linux.alibaba.com>
        <20200110093053.34777-1-shile.zhang@linux.alibaba.com>
        <1ee6088c-9e72-8824-3a9a-fc099d196faf@virtuozzo.com>
        <c7ac0338-78a6-2ae3-465c-2d6371d96a72@linux.alibaba.com>
        <9420eab3-5e5e-150f-53c9-6cd40bacf859@virtuozzo.com>
        <ba242ee6-22be-3047-5a88-e6b39e1509ef@linux.alibaba.com>
        <e87a04fa-c96b-c15e-126e-46f1cc2885d1@virtuozzo.com>
        <39eb8ac4-bdb2-bdf2-9189-2d088edb43c1@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 15:24:38 +0800 Shile Zhang <shile.zhang@linux.alibaba.com> wrote:

> Hi, Andrew,
> 
> Sorry for ping, could you please also help to check this issue?
> Any comments from you is welcome!
> 

Kirill's suggestion isn't pretty but it appears that it will work OK -
redo deferred_init_memmap() so it releases 1024(?) pages at a time,
releasing and retaking pgdat_resize_lock/unlock each time around?

