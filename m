Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56749124B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfLRPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:19:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29857 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbfLRPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576682364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AvN+er9tSk1nvAa51RyHfekLOaMRSKqcu33jfkq9kqU=;
        b=d5oAz/HnfqFMWm9tKs7hFDw3TC88MkZ0YeKCEFRGBs69MwVHHmbpGZR72vov4U2L+4fryS
        iqA1bGH16FqJ6tTzMDFsGlL235wEELP5GM/34iWCQLy1tCbDZWQyfpFQXMshgYHf+ZHadm
        Q9d5+adzGY0r3WuDKuvp5WzE+XUOpbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-riyu79fQPeK--2ikhdPqxg-1; Wed, 18 Dec 2019 10:19:18 -0500
X-MC-Unique: riyu79fQPeK--2ikhdPqxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B18E8C3DD4;
        Wed, 18 Dec 2019 15:19:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 235705DDAA;
        Wed, 18 Dec 2019 15:19:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 18 Dec 2019 16:19:12 +0100 (CET)
Date:   Wed, 18 Dec 2019 16:19:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20191218151904.GA3127@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203141239.GA30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Linus, do you have any objections?

On 12/03, Oleg Nesterov wrote:
>
> This version follows the latest recommendation from Linus,
> arch_set_restart_data() just saves ti->status in restart->arch_data.
>
> Andy, I can add another patch or change 4/4 to save the syscall number
> instead, I am fine either way.
>
> However, personally I dislike restart->arch_data, imo 3/4 is all we need.
>
> I agree, set_restart_fn() is better than the ugly ERESTART_RESTARTBLOCK
> check in syscall_return_slowpath() added by v1. But to me the x86-only
> arch_data field in restart_block is much worse than the sticky TS_ flag.
>
> To remind, there is another reason for the "transient" 3/4, 4/4 is not
> easily backportable.
>
> Oleg.
> ---
>  arch/x86/include/asm/processor.h   |  9 ---------
>  arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
>  arch/x86/kernel/signal.c           | 24 +-----------------------
>  fs/select.c                        | 10 ++++------
>  include/linux/restart_block.h      |  1 +
>  include/linux/thread_info.h        | 12 ++++++++++++
>  kernel/futex.c                     |  3 +--
>  kernel/time/alarmtimer.c           |  2 +-
>  kernel/time/hrtimer.c              |  2 +-
>  kernel/time/posix-cpu-timers.c     |  2 +-
>  10 files changed, 36 insertions(+), 44 deletions(-)

