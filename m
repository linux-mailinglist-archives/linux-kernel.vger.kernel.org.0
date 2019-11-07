Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97E2F3B63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKGW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 17:29:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbfKGW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573165762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HewLpiTYZdR6SKaDXv+O9j7By44Vn+GAbDlAzONyEI4=;
        b=CccOhV4Ins9TXupwOiNW2LJpbjUllO7D2Zotp/+KlwKgm3hGkPFLAH2yngWh4G3T41jOyQ
        SHQTlEmbh/jtzV2bxa5XNQWMtUYDHPO0tr52ldl+rzl8Vz4JPg0ESq/yB5tdyYqpXaBYub
        Mfuptp56rzW9CrbkqvodUIdD1h6eqLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-9yfZB0iiN4iLeXpa1sZAIA-1; Thu, 07 Nov 2019 17:29:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF7C1005500;
        Thu,  7 Nov 2019 22:29:17 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-79.ams2.redhat.com [10.36.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0763260BE2;
        Thu,  7 Nov 2019 22:29:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
References: <20191106215534.241796846@linutronix.de>
Date:   Thu, 07 Nov 2019 23:29:08 +0100
In-Reply-To: <20191106215534.241796846@linutronix.de> (Thomas Gleixner's
        message of "Wed, 06 Nov 2019 22:55:34 +0100")
Message-ID: <87zhh78gnf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9yfZB0iiN4iLeXpa1sZAIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner:

> The series is also available from git:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking/f=
utex

I ran the glibc upstream test suite (which has some robust futex tests)
against b21be7e942b49168ee15a75cbc49fbfdeb1e6a97 on x86-64, both native
and 32-bit/i386 compat mode.

compat mode seems broken, nptl/tst-thread-affinity-pthread fails.  This
is probably *not* due to
<https://bugzilla.kernel.org/show_bug.cgi?id=3D154011> because the failure
is non-sporadic, but reliable fails for thread 253:

info: Detected CPU set size (in bits): 225
info: Maximum test CPU: 255
error: pthread_create for thread 253 failed: Resource temporarily unavailab=
le

I'm running this on a large box as root, so ulimits etc. do not apply.

I did not see this failure with the x86-64 test.

You should be able to reproduce with (assuming you've got a multilib gcc):

git clone git://sourceware.org/git/glibc.git git
mkdir build
cd build
../git/configure --prefix=3D/usr CC=3D"gcc -m32" CXX=3D"g++ -m32" --build=
=3Di686-linux
make -j`nproc`
make test t=3Dnptl/tst-thread-affinity-pthread

Thanks,
Florian

