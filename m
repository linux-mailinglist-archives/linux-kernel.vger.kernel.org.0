Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD3D11AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfJIOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 10:46:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34065 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJIOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:46:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so3836540qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDYimNdlqZqti9uoTUL9lVho/jaJwsRQPs3PzeToXqA=;
        b=c6jocuHIz3N6hTVYKaMaNLDcGo4jq8kIZm30W95LUvZ70eYiNV4La8Ov71iiyZApF6
         F0RrH8KgBFFoKN07XWe6oDLsYKHqSUGNSJ+U1lcCFA2dwnTv/zJes4LIIXkW2hKdi511
         dPVCxsUxQxMNx/KkLZ8iKJcMxbf5WHOFR/gk0QnyD3ZYgOE+kVXgVuk/HCDFCqWvmtSt
         KNNFgbddkpOyzIs9gzTpK9pPbT+ir6BTFlaauJIFBGy3SWC7TJq4nW64C9MJEQXppdQi
         UTLc6nArP4p7hEdBgJ/5iU7wMtPSYfQRVoWSZ/VTvCvOeo8wfXy1dgR8JyYf9Up+nt6S
         xx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDYimNdlqZqti9uoTUL9lVho/jaJwsRQPs3PzeToXqA=;
        b=uYc6Yl8a/yqaLXQUE2qJejZF1D7vFlke1gvExGikZ5fTDt2KKElAAFdusX6rA9Y43R
         i+/UZjs0o8328RWp666S/gD2VqaaHykdf6J0ZpfJLwAkiZRkyvflSQNxu6cQKLc08OpR
         CRQ1eNHHBxBFrDZxRxljQ/dPR1eeEHXcLWVadNlpIKX0OugrexQqLSspTssF3s+yEuEJ
         /+TBKFLQIz20Gz+63sSyUYFTDE5nM9mebhQmjsbkgbq7ZH/F/ihrBneXmRq8+oYn+49J
         dubBcf3/1QBU105YZZ74CX/LoI9f0sAk8DsY9W8Ms1g/FNrDCC1/hINpQbj2lR/30ODb
         DU5A==
X-Gm-Message-State: APjAAAVWvqDBQRXJ+V6Z1/mLj9+36kbER+/oqyzmzfoG7GfHcB490ny3
        d7vHiOFO+eeBoMIr1g/nrHOwVg==
X-Google-Smtp-Source: APXvYqySm+nkzZ9mLR20xYq8dvYVkcqa029czjHQlPaLLb2zNFSgHANkdGDNzAVYTA0YOhcQMBFJVQ==
X-Received: by 2002:aed:30c6:: with SMTP id 64mr3908950qtf.91.1570632377158;
        Wed, 09 Oct 2019 07:46:17 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o14sm1444386qtk.52.2019.10.09.07.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:46:16 -0700 (PDT)
Message-ID: <1570632374.5937.8.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        PeterOberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 10:46:14 -0400
In-Reply-To: <20191009142438.yx74ukfqwy2hr4fz@pathway.suse.cz>
References: <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
         <1570563324.5576.309.camel@lca.pw>
         <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
         <1570626402.5937.1.camel@lca.pw> <20191009132746.GA6681@dhcp22.suse.cz>
         <1570628593.5937.3.camel@lca.pw>
         <20191009142438.yx74ukfqwy2hr4fz@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 16:24 +0200, Petr Mladek wrote:
> On Wed 2019-10-09 09:43:13, Qian Cai wrote:
> > On Wed, 2019-10-09 at 15:27 +0200, Michal Hocko wrote:
> > > On Wed 09-10-19 09:06:42, Qian Cai wrote:
> > > [...]
> > > > https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/
> > > > 
> > > > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > > > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > > > [  297.425967]        lock_acquire+0x126/0x280
> > > > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > > > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > > > [  297.425970]        univ8250_console_write+0x4b/0x60
> > > > [  297.425970]        console_unlock+0x501/0x750
> > > > [  297.425971]        vprintk_emit+0x10d/0x340
> > > > [  297.425972]        vprintk_default+0x1f/0x30
> > > > [  297.425972]        vprintk_func+0x44/0xd4
> > > > [  297.425973]        printk+0x9f/0xc5
> > > > [  297.425974]        register_console+0x39c/0x520
> > > > [  297.425975]        univ8250_console_init+0x23/0x2d
> > > > [  297.425975]        console_init+0x338/0x4cd
> > > > [  297.425976]        start_kernel+0x534/0x724
> > > > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > > > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > > > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > > > 
> > > > where the report again show the early boot call trace for the locking
> > > > dependency,
> > > > 
> > > > console_owner --> port_lock_key
> > > > 
> > > > but that dependency clearly not only happen in the early boot.
> > > 
> > > Can you provide an example of the runtime dependency without any early
> > > boot artifacts? Because this discussion really doens't make much sense
> > > without a clear example of a _real_ lockdep report that is not a false
> > > possitive. All of them so far have been concluded to be false possitive
> > > AFAIU.
> > 
> > An obvious one is in the above link. Just replace the trace in #1 above with
> > printk() from anywhere, i.e., just ignore the early boot calls there as they are
> >  not important.
> > 
> > printk()
> >   console_unlock()
> >     console_lock_spinning_enable() --> console_owner_lock
> >   call_console_drivers()
> >     serial8250_console_write() --> port->lock
> 
> Please, find the location where this really happens and then suggests
> how the real deadlock could get fixed. So far, we have seen only
> false positives and theoretical scenarios.

Now the bar is higher again. You are now asking me to actually trigger this
potential deadlock live. I am probably better off buying some lottery tickets
then if I could be that lucky.
