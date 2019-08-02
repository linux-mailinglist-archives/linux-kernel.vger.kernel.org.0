Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4014E802E5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392499AbfHBWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 18:39:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38369 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392438AbfHBWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:39:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so36719016pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xtoAGxBdiLOUknlhHTx8GNIb+LMwTi7H97I3neUlIPA=;
        b=wjV7AbrHhgkT2XLYtZG2ovEdz+FypvUIWsUDlYU4I+0o/z3HbUiLTtxzulJrRuDR66
         nktecPr/bpd84BXXJsGMZk5npIv/E+gZLaoZ0mvs5lZSIRpEGIXlg2U7S70s5mvwjHQP
         5I9d8GrxsG/o4PHwwn3Gg7QY+a5LfHlWw8PA+XJba4NTy21/xck7y0xjVkeeyrwM1BBh
         5oK33sIj7LimA6/2W34ERiPaapWS4J2mKddN9DL1MIR4FiguNq2gnbGtwG4tfRgK76Fp
         KCZxBmnsQHJ0QZyJB+3rY72fy45osR9GXNG/zG1ZYHGhq7IrL6t8KK7btHKc7vsNx6Oa
         x9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xtoAGxBdiLOUknlhHTx8GNIb+LMwTi7H97I3neUlIPA=;
        b=nrrccBmGnfr2hTQ8XKQsdKJ7/irvvoZSqq8QSQceEpmy9/U/m1+dWWRKeJeiBkNptC
         HIFr2z0nn1NuF386/YtkTB7rku9FxjcIthAywZmaNCATjp5o/+FNQLf/mgDH93QtObjC
         k2oGsmVKFxbnf+5LnBsgw4qebmLUuopK2AQ3fXVqnqBB80Ztcj+nHL9PCCVkf8zivfhL
         bWg9cWQpT0KITi7Yo7o5KfQmZfCmXtWehHSB3AspIDvvyR9fRrKYj7xDLsyCq1kWQC9q
         a/i5FEnqYD/FNeO6s/E4BDGoMI//yFMructpBbyTotNo9nmgYTOg2PiTVVBEqmqo38z9
         1QyQ==
X-Gm-Message-State: APjAAAU0uR4xTkxcJGEbpGUQcuD4OnC8AnmCgUpQ4nzwSdlU4a6lwYVX
        ueoY5/pkx8ai+agmppRc+V/ZoQ==
X-Google-Smtp-Source: APXvYqze8hQUQZYFJxl6Kf/11NwXqpgpVI1uOQzkOUxpW4Lfyk/NrWHTfysYkhemaQk3mYt67WCEqg==
X-Received: by 2002:a63:595d:: with SMTP id j29mr4211932pgm.134.1564785565245;
        Fri, 02 Aug 2019 15:39:25 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06b:6482:694d:11f8:429b:f614? ([2600:1010:b06b:6482:694d:11f8:429b:f614])
        by smtp.gmail.com with ESMTPSA id v22sm75519122pgk.69.2019.08.02.15.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 15:39:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 2/5] x86/kvm: Handle task_work on VMENTER/EXIT
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <alpine.DEB.2.21.1908030015330.4029@nanos.tec.linutronix.de>
Date:   Fri, 2 Aug 2019 15:39:22 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net>
References: <20190801143250.370326052@linutronix.de> <20190801143657.887648487@linutronix.de> <20190801162451.GE31538@redhat.com> <alpine.DEB.2.21.1908012025100.1789@nanos.tec.linutronix.de> <20190801213550.GE6783@linux.intel.com> <alpine.DEB.2.21.1908012343530.1789@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908012345000.1789@nanos.tec.linutronix.de> <c8294b01-62d1-95df-6ff6-213f945a434f@redhat.com> <alpine.DEB.2.21.1908030015330.4029@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 2, 2019, at 3:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 2 Aug 2019, Paolo Bonzini wrote:
>>> On 01/08/19 23:47, Thomas Gleixner wrote:
>>> Right you are about cond_resched() being called, but for SRCU this does n=
ot
>>> matter unless there is some way to do a synchronize operation on that SR=
CU
>>> entity. It might have some other performance side effect though.
>>=20
>> I would use srcu_read_unlock/lock around the call.
>>=20
>> However, I'm wondering if the API can be improved because basically we
>> have six functions for three checks of TIF flags.  Does it make sense to
>> have something like task_has_request_flags and task_do_requests (names
>> are horrible I know) that can be used like
>>=20
>>    if (task_has_request_flags()) {
>>        int err;
>>        ...srcu_read_unlock...
>>        // return -EINTR if signal_pending
>>        err =3D task_do_requests();
>>        if (err < 0)
>>            goto exit_no_srcu_read_unlock;
>>        ...srcu_read_lock...
>>    }
>>=20
>> taking care of all three cases with a single hook?  This is important
>> especially because all these checks are done by all KVM architectures in
>> slightly different ways, and a unified API would be a good reason to
>> make all architectures look the same.
>>=20
>> (Of course I could also define this unified API in virt/kvm/kvm_main.c,
>> so this is not blocking the series in any way!).
>=20
> You're not holding up something. Having a common function for this is
> definitely the right approach.
>=20
> As this is virt specific because it only checks for non arch specific bits=

> (TIF_NOTIFY_RESUME should be available for all KVM archs) and the TIF bits=

> are a subset of the available TIF bits because all others do not make any
> sense there, this really should be a common function for KVM so that all
> other archs which obviously lack a TIF_NOTIFY_RESUME check, can be fixed u=
p
> and consolidated. If we add another TIF check later then we only have to d=
o
> it in one place.
>=20
>=20

If we add a real API for this, can we make it, or a very similar API, work f=
or exit_to_usermode_loop() too?  Maybe:

bool usermode_work_pending();
bool guestmode_work_pending();

void do_usermode_work();
void do_guestmode_work();

The first two are called with IRQs off.  The latter two are called with IRQs=
 on.=
