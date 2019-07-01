Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024DF105FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfEAID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 04:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAID4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 04:03:56 -0400
Received: from linux-8ccs (ip5f5ade58.dynamic.kabel-deutschland.de [95.90.222.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5858521734;
        Wed,  1 May 2019 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556697835;
        bh=tbBM1g+FiEOjBmIG8Qd5Y6+KdWgZZC+apZiwQPkwfeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQPwDOX2iVGyR4gEz/Yd3c4wRHY3HibssGH1adJZJ9Tcz6SEfeTt0AwpTSx2gZWca
         jh5wvRYDfW3dzy0W5gtddQkjLRIILXRiTn9+dBNxUmzSTWU1NcfPVUJWTZQcamPFkz
         HAscoE1k+qWbTQW/7Cyktmq0uM97Itd0OhrWoC8U=
Date:   Wed, 1 May 2019 10:03:51 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <20190501080351.GB10762@linux-8ccs>
References: <20190501081054.387820b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190501081054.387820b2@canb.auug.org.au>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Stephen Rothwell [01/05/19 08:10 +1000]:
>Hi all,
>
>In commit
>
>  7e470ea99bcd ("kernel/module: Reschedule while waiting for modules to finish loading")
>
>Fixes tag
>
>  Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
>
>has these problem(s):
>
>  - the "linux-next commit" is unexpected (and not really meaningful
>    once this is merged into Linus' tree)
>
>-- 
>Cheers,
>Stephen Rothwell

A fixed verison has been pushed out to modules-next.

Thanks!

Jessica
