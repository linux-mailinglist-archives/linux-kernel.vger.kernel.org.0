Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB86A185AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 08:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCOHPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 03:15:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCOHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXc/c+ZKh3wHtb2Dc8YCwaJA//JT5SbM6lXWpvbO8AQ=; b=MMrIUEuzJ7ebjTc9V9Nlnb76n0
        gQrqIhRup7osiVRCct3KlZzlmrOFKYJxstp2o1tjF3yAPe8ZyKFXgO39+HEDxPtq2/PLVf4szDnR6
        MuOTnbvBlbW0Y2wo/hBY7h8tnd1A36QjFiqympgUhuAHsqAXzi+ei527pdTvx7CX9WwjMjB+gZXJA
        GhEMuXocBMYfmbtVOX38t+8rjoz3QLRW+2Qoal6G+OZ8ARmYbIBSh9MJ5aMR6a7EYgWRvwyOKGVdZ
        yQ+KWxKa3J6dehD/ZDl5VZ8FUByCU+tm8d8x+J2AQ1yGLjODsbO7HgyX1UB0F2eJQMtcUCyBK0zYK
        10/F1sIA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jD7m0-0001K0-MD; Sat, 14 Mar 2020 14:28:20 +0000
Date:   Sat, 14 Mar 2020 07:28:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, akpm@linux-foundation.org, kernel@gpiccoli.net
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces on
 oops event
Message-ID: <20200314142820.GQ22433@bombadil.infradead.org>
References: <20200310163700.19186-1-gpiccoli@canonical.com>
 <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 01:59:15PM -0700, Randy Dunlap wrote:
> > +oops_all_cpu_backtrace:
> > +================
> > +
> > +Determines if kernel should NMI all CPUs to dump their backtraces when
> 
> I would much prefer that to be written without using NMI as a verb.

Concrete suggestion: "If this option is set, the kernel will send an NMI to
all CPUs to dump ..."

