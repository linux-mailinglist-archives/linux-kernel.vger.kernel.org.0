Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302AA180D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 02:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCKB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 21:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbgCKB0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:26:48 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9464D205ED;
        Wed, 11 Mar 2020 01:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583890008;
        bh=eMDYXR2nJZoF3367Sc7t4Lc1WZJdnWQnD5UrvNe19Jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T8TmCtDpE64khBhTPI+ccVAiSHhT0IlO0Loa/vazicprYilRGiHWoolabqja0dOCG
         j/KdC66zHZydqdJpoJhd8CY9CsR/jH2HoSgl7KI9Mr7x2JPZe7gbPkfN+8p0MZj062
         iiRfYkMcoSbbzpqp/mg2jjNJZ3kZS3jGbGHWKzuw=
Date:   Tue, 10 Mar 2020 18:26:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces
 on oops event
Message-Id: <20200310182647.59f6ea73aad3aca619065f1e@linux-foundation.org>
In-Reply-To: <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
References: <20200310163700.19186-1-gpiccoli@canonical.com>
        <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 13:59:15 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> > +oops_all_cpu_backtrace:
> > +================
> > +
> > +Determines if kernel should NMI all CPUs to dump their backtraces when
> 
> I would much prefer that to be written without using NMI as a verb.

"Non maskably interrupt" ;)

I think it's OK.  Concise and the meaning is clear.


Why do we need the kernel boot parameter?  Isn't
/proc/sys/kernel/oops_all_cpu_backtrace sufficient?

