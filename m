Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E065FD70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGDTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 15:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDTcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:32:20 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D707D2189E;
        Thu,  4 Jul 2019 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562268739;
        bh=sDn9pqNnZNQls6TlQC0E4i4OA5fVIAHZsv1mK7QjuUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xLYlLoVcNxDZe4xjXUvwx/phI6Gk2I2s1MqHsJnhvK2dhiM5vmmOgxqD3KpPOq1GI
         YZNDgDS+RHGtv/QAuLWVM4LeZoRGCgQfTba6bUvfTmu8bvT07N8/18ASofU5gvPZM6
         qTzELQghgD4BvffARvPi77TQK27tSY7dRePWiBGY=
Date:   Thu, 4 Jul 2019 12:32:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, axboe@kernel.dk, hch@lst.de,
        peterz@infradead.org, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap_readpage: avoid blk_wake_io_task() if !synchronous
Message-Id: <20190704123218.87a763f771efad158e1b0a89@linux-foundation.org>
In-Reply-To: <20190704160301.GA5956@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
        <20190704160301.GA5956@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 18:03:01 +0200 Oleg Nesterov <oleg@redhat.com> wrote:

> swap_readpage() sets waiter = bio->bi_private even if synchronous = F,
> this means that the caller can get the spurious wakeup after return. This
> can be fatal if blk_wake_io_task() does set_current_state(TASK_RUNNING)
> after the caller does set_special_state(), in the worst case the kernel
> can crash in do_task_dead().

I think we need a Fixes: and a cc:stable here?

IIRC, we're fixing 0619317ff8baa2 ("block: add polled wakeup task helper").
