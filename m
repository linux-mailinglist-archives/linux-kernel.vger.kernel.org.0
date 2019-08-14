Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E98D7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfHNQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfHNQJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10BF9302C083;
        Wed, 14 Aug 2019 16:09:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0DF398D652;
        Wed, 14 Aug 2019 16:09:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Aug 2019 18:09:21 +0200 (CEST)
Date:   Wed, 14 Aug 2019 18:09:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814160917.GG11595@redhat.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814154400.6371-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 16:09:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Christian Brauner wrote:
>
> and a signal could come in between the system call that
> retrieved the process gorup and the call to waitid that changes the
                        ^^^^^
> current process group.

I noticed this typo only because I spent 2 minutes or more trying to
understand this sentence ;) But yes, a signal handler or another thread
can change pgrp in between.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

