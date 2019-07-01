Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517F25C242
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfGARsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 13:48:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35131 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfGARsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:48:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so14391749otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaSNs2HPkef+Bju56da9n81KJMEMrMttgso442g/QFQ=;
        b=dDxXBYrffpjFtM2c0mbpgHYAdQWFOMC7Pg5wS3+aSRf27a4WL/vMFFEEX1k0Q+UEoD
         PxEbvX5YtveVeJbRRR4L+QvEY7JZXKaXWsmDMieqT3Vqa+ldWVs3Crj4SSUSk68x+TMW
         4rzGe83wXA28h4lBdWyPq2UXIHWh4/a9tWqhLsEArfRSxVKpx+7/XT7ej0qWYPRmDgX0
         jpo5P91s5ji/fLtheR47BG337NnW36xNfAwK8NbTVCjf90H1eMlSEfXst9tbCQD06Zq6
         luM/3dSzwvzTENJmBQw3gfDnXPyJUA1OZ0YEU2BaLqSnJ9aKLDmMBpZDG1wWGJe2Gd+V
         MNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaSNs2HPkef+Bju56da9n81KJMEMrMttgso442g/QFQ=;
        b=mBVKNgCdKNvVx8VOMswGRw8KBaUTtOo4Tqj5Xb0tgWvMHN840dZ4i62NacVYYgLdfU
         X72iqCBxK4PUmrHilSevIs/J2YXZZrnNdut+nSRJmk1t+xILL+W0vUlE7Zphmq0mhzQf
         dVLA/rUm0j0GEOq1AUwBJMPam8c9JCaFwWdfNvMxEj2bogMo/FTOnUeOYfr0Ez9cl2+4
         yHvW1hXQy+gweX8JRfqBOpHNHBWQ75O+gEGq1fC0YOeSqHNRyTzS3LIG0gZcB7W24qEs
         hzwQu9GF30JTFarBGjXo+YqC4xzZ4XHlz1ueI5+NN41+Zpu+9KgX7iI2W4eDGOf0YvqS
         H/jg==
X-Gm-Message-State: APjAAAXPz+F5pPkSyulinRdvZbSRKT1s5UURVEq+3181AxAeT1Lh8ksD
        Ahs5WNJdXUpnSL+UYgaYNUIuXYtEiJANpJKnQUHKxw==
X-Google-Smtp-Source: APXvYqzAP7YijoRhhk214MeHXQ+UJykFo/oaWVZnDcnHgEvTrOR3/XiDyA6gSgJGl8ucI5kH6eOwSlRA7n2oWVQcFUg=
X-Received: by 2002:a9d:2f26:: with SMTP id h35mr21598797otb.183.1562003332560;
 Mon, 01 Jul 2019 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190628193442.94745-1-joel@joelfernandes.org>
In-Reply-To: <20190628193442.94745-1-joel@joelfernandes.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Jul 2019 19:48:26 +0200
Message-ID: <CAG48ez11aCEBmO=DM58+Rk7cthW1VWK2O35GWsSJWwQ_fQJ6Fg@mail.gmail.com>
Subject: Re: [PATCH v2] Convert struct pid count to refcount_t
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 9:35 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> struct pid's count is an atomic_t field used as a refcount. Use
> refcount_t for it which is basically atomic_t but does additional
> checking to prevent use-after-free bugs.
[...]
>  struct pid
>  {
> -       atomic_t count;
> +       refcount_t count;
[...]
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..89c4849fab5d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -37,7 +37,7 @@
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
> -#include <linux/proc_fs.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>
> @@ -106,8 +106,7 @@ void put_pid(struct pid *pid)

init_struct_pid is defined as follows:

struct pid init_struct_pid = {
        .count          = ATOMIC_INIT(1),
[...]
};

This should be changed to REFCOUNT_INIT(1).

You should have received a compiler warning about this; I get the
following when trying to build with your patch applied:

jannh@jannh2:~/git/foreign/linux$ make kernel/pid.o
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      kernel/pid.o
kernel/pid.c:44:30: warning: missing braces around initializer
[-Wmissing-braces]
 struct pid init_struct_pid = {
                              ^
kernel/pid.c:44:30: warning: missing braces around initializer
[-Wmissing-braces]
kernel/pid.c:44:30: warning: missing braces around initializer
[-Wmissing-braces]
kernel/pid.c:44:30: warning: missing braces around initializer
[-Wmissing-braces]
kernel/pid.c:44:30: warning: missing braces around initializer
[-Wmissing-braces]
