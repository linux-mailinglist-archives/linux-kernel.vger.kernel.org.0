Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15303C4A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJBI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 04:56:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:47214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfJBI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:56:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2104ABF4;
        Wed,  2 Oct 2019 08:55:57 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:55:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
Message-ID: <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
> There are pr_warning and pr_warng to show WARNING level message,
> most of the code using pr_warn, number based on next-20190919,
>
> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)

The ratio is 10:1 in favor of pr_warn(). It would make sense
to remove the pr_warning().

Would you accept pull request with these 32 simple patches
for rc2, please?

Alternative is to run a simple sed. But it is not trivial
to fix indentation of the related lines.

Best Regards,
Petr
