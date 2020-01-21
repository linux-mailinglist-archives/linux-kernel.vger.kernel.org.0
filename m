Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6F144634
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAUVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 16:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbgAUVEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:04:46 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318D924655;
        Tue, 21 Jan 2020 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579640686;
        bh=f7FfZ/UUMe8S4zn+3x50yAOcJjltmiZc2OrGcfZ4D5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zkQ8wPHcIqx0yRpuTxqffi9zPImBGmkKir+qRVRSJ1VBytXCOsQtrzdOHHM3iVYV+
         Re8Rl8Y4qyJCF0tzVkkCjlpyerTheEv12H8/YIeeFEtItbf88wCY4t9HeGgyRkO5+5
         z681/CVe33tSRpkriWzBqTfYKxRz4L9KTzPjZV/Y=
Date:   Tue, 21 Jan 2020 13:04:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] lib/rbtree: avoid pointless rb_node alignment
Message-Id: <20200121130444.0f5c39dc1ca6ba393084b14b@linux-foundation.org>
In-Reply-To: <20200120175144.67625skg6eiprpsa@linux-p48b>
References: <20200110215429.30360-1-dave@stgolabs.net>
        <CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com>
        <20200120175144.67625skg6eiprpsa@linux-p48b>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 09:51:44 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 20 Jan 2020, Geert Uytterhoeven wrote:
> 
> >timerqueue_del() uses rbtree, and
> >
> >    #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
> >
> >relies on all objects being 4-byte aligned.  But your patch broke that
> >assumption on m68k, where the default alignment is 2-byte.
> >
> >Andrew: please drop this patch.
> 
> Yeah that's too bad. I'll send a patch improving the comment around the alignment
> once the patch is dropped.

Thanks, I'll drop this patch.
