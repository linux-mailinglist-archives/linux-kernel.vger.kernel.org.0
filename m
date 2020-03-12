Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3A182737
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 04:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgCLDA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 23:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbgCLDA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:00:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7AD20735;
        Thu, 12 Mar 2020 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583982024;
        bh=Tzw7OkLhuKwlGaNH6zUaZ92HAbrd6ZAx96ilGAda8sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QUV+09ZDscWerAse5sMC/Bzmq/6T1Cul8RokXefoSY9muH4YSLKdP2RTr1DQYA6Un
         oWCq5rRjXh8iHoFTbisIR8r0um5szGsHkK8yWVdlfMRV9jI4RGxt1tEGYF9CQ01w9F
         WUozF+mo4X7aT7ET/rDxVpcWQkKMb4sNj7t/6np4=
Date:   Wed, 11 Mar 2020 20:00:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] backing-dev: refactor wb_congested_put()
Message-Id: <20200311200023.974009d9a5648b977d5168f6@linux-foundation.org>
In-Reply-To: <20200312022948.GH22433@bombadil.infradead.org>
References: <20200312002156.49023-1-jbi.octave@gmail.com>
        <20200312002156.49023-2-jbi.octave@gmail.com>
        <20200311175919.30523d55b2e5307ba22bbdc0@linux-foundation.org>
        <20200312022948.GH22433@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 19:29:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Mar 11, 2020 at 05:59:19PM -0700, Andrew Morton wrote:
> > hm, it's hard to get excited over this.  Open-coding the
> > refcount_dec_and_lock_irqsave() internals at a callsite in order to
> > make sparse happy.
> > 
> > Is there some other way, using __acquires (for example)?
> 
> sparse is really bad at conditional lock acquisition. 

I can well imagine.

> we have similar
> problems over the vfs.  but we shouldn't be obfuscating our code to make
> the tool happy.

Perhaps sparse needs a way of being directed to suppress checking
across a particular function.

