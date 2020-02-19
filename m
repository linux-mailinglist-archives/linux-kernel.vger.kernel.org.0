Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6439164F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 21:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBSUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 15:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:08:13 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842F32176D;
        Wed, 19 Feb 2020 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582142891;
        bh=K/D5JbPk2+EBYp2gmQA0q9ditYqXaZ6u/jNNJaQQNeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4t0+1H9+T91595fwF5FJlrfN5hAP7b2OvyDrCSy3zwLJrvS07mTsYuEM5DXHnFGp
         4qFSz1jxRax7qvwJ19FfAf+jYHr05omtkY3xWKa9Bat7iEgGBVKKyg8tHE6D0KUotm
         JV5ctKrnTkl+82JgBHttCq5MEna+P72IO2uvUTbE=
Date:   Wed, 19 Feb 2020 12:08:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, mhocko@kernel.org
Subject: Re: [Patch v4] mm/vmscan.c: remove cpu online notification for now
Message-Id: <20200219120810.c7677fa58594f5423549f59d@linux-foundation.org>
In-Reply-To: <20200218224422.3407-1-richardw.yang@linux.intel.com>
References: <20200218224422.3407-1-richardw.yang@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 06:44:22 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:

> kswapd kernel thread starts either with a CPU affinity set to the full
> cpu mask of its target node or without any affinity at all if the node
> is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
> implements an elaborate way to update this mask when a cpu is onlined.
> 
> It is not really clear whether there is any actual benefit from this
> scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
> runtime.

This is the case across all platforms, all architectures, all users for
the next N years?  I'm surprised that we know this with sufficient
confidence.  Can you explain how you came to make this assertion?

> Drop the code for that reason. If there is a real usecase then
> we can resurrect and simplify the code.
