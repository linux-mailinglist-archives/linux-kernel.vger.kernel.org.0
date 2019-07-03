Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA77F5E811
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 11:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCPpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:45:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33FEB218B8;
        Wed,  3 Jul 2019 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562168753;
        bh=pm5rTouD6xHz++5CAMKe/cfXETNu2i0/sl/YoyPzmz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soBEtjfJ/l3Z4chuNxK1t5vLtLgUoRPkRzzUwzsQAE+LKmhhknDyaTvtC/b07t0rN
         EnWLpr+7MmQoFtaIKhmT0LztTb+CzAoIatUXwvXZmCTyGjYF73jmqFr/OG19QADdce
         WemDWe3+VbHrZySKD1wcjKvSo47OyF834+sOgSpQ=
Date:   Wed, 3 Jul 2019 17:45:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on
 arm64 platform
Message-ID: <20190703154551.GA19371@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:51:44PM +0300, Alexander Shishkin wrote:
> From: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> Commit ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> introduced the following warnings on non-x86 architectures, as a result
> of reordering the multi mode buffer allocation sequence:
> 
> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> > drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’
> > [-Wunused-variable]
> > int ret = -ENOMEM, i;
> >                    ^
> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> > drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’
> > [-Wunused-variable]
> > int i;
> >     ^
> 
> Fix this compiler warning by factoring out set_memory sequences and making
> them x86-only.
> 
> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Fixes: ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 13 deletions(-)

Does not apply to my tree :(
