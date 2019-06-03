Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B6327ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFCFQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 01:16:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52594 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfFCFQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:16:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E03501340AD6E;
        Sun,  2 Jun 2019 22:16:48 -0700 (PDT)
Date:   Sun, 02 Jun 2019 22:16:48 -0700 (PDT)
Message-Id: <20190602.221648.1225654208143233174.davem@davemloft.net>
To:     92siuyang@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: perf: fix updated event period in response to
 PERF_EVENT_IOC_PERIOD
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559096508-25847-1-git-send-email-92siuyang@gmail.com>
References: <1559096508-25847-1-git-send-email-92siuyang@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 22:16:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>
Date: Wed, 29 May 2019 10:21:48 +0800

> The PERF_EVENT_IOC_PERIOD ioctl command can be used to change the
> sample period of a running perf_event. Consequently, when calculating
> the next event period, the new period will only be considered after the
> previous one has overflowed.
> 
> This patch changes the calculation of the remaining event ticks so that
> they are offset if the period has changed.
> 
> See commit 3581fe0ef37c ("ARM: 7556/1: perf: fix updated event period in
> response to PERF_EVENT_IOC_PERIOD") for details.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>

Applied, thanks.
