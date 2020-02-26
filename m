Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529F416F4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 02:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgBZBFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 20:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgBZBFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:05:31 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9506E21927;
        Wed, 26 Feb 2020 01:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582679130;
        bh=4BlXMjWvXp73VnknIxzhXDHwDI5DgjekStSavwCRchs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhW0CvjyDcow6ELHbQ+JTDJheBLdwhuFKJahhLLvwPi+5lx5dr65C2QaTYYrl/XKJ
         wIzqc9WvtWheCgM6QBDTPzKn8HV+NjboJdw00+2XWQHLB5S44BEMhW1MZ8Zj7EpPDu
         NkmjrvpGh3QdY3SowUNfTrfdD4BgstKggoOXxdFA=
Date:   Tue, 25 Feb 2020 17:05:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [for-linus][PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING
 dependency issue
Message-Id: <20200225170530.529a7246c1a4aa9b25d51039@linux-foundation.org>
In-Reply-To: <20200225191237.03643f96@gandalf.local.home>
References: <20200225191237.03643f96@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 19:12:37 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> Since commit d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by
> default") also changed the CONFIG_BOOTTIME_TRACING to select
> CONFIG_BOOT_CONFIG to show the boot-time tracing on the menu,
> it introduced wrong dependencies with BLK_DEV_INITRD as below.

Confusing.  It's described as "for Linus" but d8a953ddde5e isn't in
Linus's tree.
