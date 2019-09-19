Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07CBB8238
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbfISUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 16:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392478AbfISUHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:07:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82A120644;
        Thu, 19 Sep 2019 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568923667;
        bh=vH1UlIZ1Hy1n9+YkCrc/fQHM5s+KDuQfzvDwHRNM8Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Aq//kYHRFpI3trIOOLFJpyxo38VuPaBFgEHDvspwKLBsvv08li4Ytw7h+S5FFq6o
         R/ci/80YL0xCjawRZ3qbl16OnvM7OrsXwZ0og2ciWll9yWE+e9mf/luAUTQJ/QvBGZ
         OwB4PiFfD7Z1fkjSEdbwtM4m9VA2gRrUTXNPRYjA=
Date:   Thu, 19 Sep 2019 13:07:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     KeMeng Shi <shikemeng@huawei.com>
Cc:     <will@kernel.org>, <james.morris@microsoft.com>,
        <gregkh@linuxfoundation.org>, <mortonm@chromium.org>,
        <will.deacon@arm.com>, <kristina.martsenko@arm.com>,
        <yuehaibing@huawei.com>, <malat@debian.org>,
        <j.neuschaefer@gmx.net>, <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH] connector: report comm change event when modifying
 /proc/pid/task/tid/comm
Message-Id: <20190919130746.58297294885dafa7ce0b91e5@linux-foundation.org>
In-Reply-To: <20190919024321.2675-1-shikemeng@huawei.com>
References: <20190917170737.dpchgliux4qi2qef@willie-the-truck>
        <20190919024321.2675-1-shikemeng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 22:43:21 -0400 KeMeng Shi <shikemeng@huawei.com> wrote:

> It's indeed necessary to fix the concurrence problem. I will submit
> a v2 patch when I fix this.

Even though this is a procfs change, connector patches are usually
handled by davem.  So please cc himself, Evgeniy Polyakov and
netdev@vger.kernel.org on the next version, thanks.

