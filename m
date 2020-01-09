Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB4135E36
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgAIQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 11:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgAIQ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:27:39 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8134C2067D;
        Thu,  9 Jan 2020 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578587259;
        bh=x2A08gS4Efk3wEZAZq/aese6Ii7jMVc8nZLXbRPYOgo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wW3c1WxdemS6l2wJl3KrEvEdoVhPogskutL+/UlyT/hRpLIOfZqkA3kzhaFcUNb48
         BMveo6WOQlyicFRAv8oFm36TKGsV0YLS+Vvy2n7z/P47Z8yqU/blJ0dt0IN6nCZjDY
         hgAc+tsUb9xTnAst6/I6QQcv8Fw5ltTbnUuovNAA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3685F3520B2F; Thu,  9 Jan 2020 08:27:39 -0800 (PST)
Date:   Thu, 9 Jan 2020 08:27:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu 0/2] kcsan: Improvements to reporting
Message-ID: <20200109162739.GS13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200109152322.104466-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109152322.104466-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:23:20PM +0100, Marco Elver wrote:
> Improvements to KCSAN data race reporting:
> 1. Show if access is marked (*_ONCE, atomic, etc.).
> 2. Rate limit reporting to avoid spamming console.
> 
> Marco Elver (2):
>   kcsan: Show full access type in report
>   kcsan: Rate-limit reporting per data races

Queued and pushed, thank you!  I edited the commit logs a bit, so could
you please check to make sure that I didn't mess anything up?

At some point, boot-time-allocated per-CPU arrays might be needed to
avoid contention on large systems, but one step at a time.  ;-)

							Thanx, Paul

>  kernel/kcsan/core.c   |  15 +++--
>  kernel/kcsan/kcsan.h  |   2 +-
>  kernel/kcsan/report.c | 153 +++++++++++++++++++++++++++++++++++-------
>  lib/Kconfig.kcsan     |  10 +++
>  4 files changed, 148 insertions(+), 32 deletions(-)
> 
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 
