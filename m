Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A4189180
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCQWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:31:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33180 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCQWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:31:05 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so21806315ilg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cy9EBkEXP8mKrE1tWYDArUinNkiiQlqPyNhgotiBbRw=;
        b=P43FjTKd0T5/YQKdtaWgVoXEy18bxKaNnuX61RCQVAyMX08mal/nWxiOX2rnGI6+2E
         ifMLGV9Oksz8dDkoimFarqdH3u8NJ+kAxWi+Q78yMyMdBe9XZmcoHxlPBLbrUI+qubCa
         7qAFN3+PC1lrCarn3nDKpSq7KaXkpKMx17E/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cy9EBkEXP8mKrE1tWYDArUinNkiiQlqPyNhgotiBbRw=;
        b=nqQMoAMOphA+O2nS3+snJMQfqqRdpAbU1/F0ZVbQJP7nKg0ZNjaqULu8WmmBmLXyQ2
         hlkqk3erbs6fYwh7xtmHc+9ltfWMv3i+UQVWXWuXxHIBhgLgpnhDayYv42Ni4bhVxfDT
         fy/k50Eo5c6BYvNoj3oYz3eGSbVaVAcVvYROOb6VrhiuGT3tvfSXJ80axqmjE5+2lh9c
         F3V39p/cBEAD6f6zi6r7IMAYSI9JS44+ioD8Bpjz0R+qFTRmtfDZ69svPpDMx4buqO4V
         IJTncuijlUpAiQ174QUQLZOkpMDQmzpdD87e+fhJFycJCCFC4MWCwD5r9hO8992mzFZx
         o0Ww==
X-Gm-Message-State: ANhLgQ0EZckXg97OgPMm/7ODinNkvFJh0oqhpYILj5MCBEdsSUip0l9b
        Ta6RG/cChaYFBFtGkugUPId1c8qHymJtc8oti1mvCA==
X-Google-Smtp-Source: ADFU+vsmPWAvveep930fw52ooTIuIXySJT8RDOWRG06Ck9aFoHf6+/7B/JRHemPQPS76anrITG9rAdvoDIUnoN5PR+Y=
X-Received: by 2002:a92:8f53:: with SMTP id j80mr1106826ild.171.1584484262823;
 Tue, 17 Mar 2020 15:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200316163228.62068-1-joel@joelfernandes.org>
 <20200317210822.GM3199@paulmck-ThinkPad-P72> <20200317214502.GA29184@paulmck-ThinkPad-P72>
In-Reply-To: <20200317214502.GA29184@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Mar 2020 18:30:51 -0400
Message-ID: <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com>
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object
 allocation size
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 5:45 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google) wrote=
:
> > > This allows us to increase memory pressure dynamically using a new
> > > rcuperf boot command line parameter called 'rcumult'.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Applied for testing and review, thank you!
>
> But testing did not go far:
>
> kernel/rcu/tree.c: In function =E2=80=98kfree_rcu_shrink_count=E2=80=99:
> kernel/rcu/tree.c:3120:16: warning: unused variable =E2=80=98flags=E2=80=
=99 [-Wunused-variable]
>   unsigned long flags, count =3D 0;

I fixed the warning already but did not resend since it was just the
one unused variable warning. The patches are otherwise good to apply.
Sorry, and I can resend it soon if you are not reapplying right now.

thanks,

 - Joel
