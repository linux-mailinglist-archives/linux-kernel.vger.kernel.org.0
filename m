Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8002217667E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBV5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 16:57:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39293 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:57:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id s2so473157pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8cncLmIKb74ARY4u3Ul3MTwXaMgUO4z3at0fIC1AK4=;
        b=EDLx57wYDMC42+RD8Bjb4sT2XTMNlAbUwf3l1LrxVqSpBX2E2wSJbS8L3zZuJ5KFK/
         orwqWQgcrgo8VkfM8MT0mZqeEcdJHs51pFsTArOzKyfOhg/6dzKI1dRDjaRaNCnNl2rE
         rlBuLruu7hC0DANgqBiWXToQDm/kW3vs86nfZnbsI/B7yVpbP9mMDcQp2mSuI0PoR4ho
         9KKmphGgd08rRoAQR+CeCg9uWWuD8AIqynKCRgkg45poLTjjgFqsbvhUcP/Wa1sS++mv
         IK/FRK7C8XwR2U4xn7vTENgP47doomWSJZ0kTTcg90Vo6kRT3fMoPgTSR3xn4x8f+oNy
         tijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8cncLmIKb74ARY4u3Ul3MTwXaMgUO4z3at0fIC1AK4=;
        b=NpBn47lIujmP/EwK1xq++XxLyW+H7MdvY8oi2NEOXbdpukq7n7/m4yrdesUjbeupm3
         IculXNmY/Hyvfa9L1bI5kXmt0Oc7x+nmuHap2inRiB78RecIXL1Fy3FWgo/dzbT+vHuF
         lkl2VetSwK6NyHB/XSFOrj5yNYsW3zCZHFzuISJ4icWY95+ECRWLvSjNtn8zgAorvKAb
         F9BLqoSsoZ4foHgCwY/03xU1jhEuNCU612+FR7eWu/lSy1t8y+j0RQPNULxBVHpMh6lI
         6XTUgdGgIPegalQgjZU3Wca5nJTJMru/U++gYhuA9pnUZzrrNPYY1g80BvOMF5n68LAJ
         tKSA==
X-Gm-Message-State: ANhLgQ12L4ybQgY87u8lLpLTfd7Oad7fMbn/vUYFV3bybz75jcYfX8C8
        qxUXDvCWbqxnV3b4reQZGn6w60xBGvY2RG2bWcSEbA==
X-Google-Smtp-Source: ADFU+vsJDnL1SMQunAJetk8ZEmktYTmZkt3K50PfzufkgiGIqMmM9XdNzoTxDlrMABCC5BblU52ieA5yH7SC3PGVGn0=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr1002877pfa.165.1583186234526;
 Mon, 02 Mar 2020 13:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20200302213402.9650-1-natechancellor@gmail.com> <CAKwvOdn8SgY-C1YRGOcCnTn84MHHGirkDHPfg=mCONmUV_wqSQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn8SgY-C1YRGOcCnTn84MHHGirkDHPfg=mCONmUV_wqSQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Mar 2020 13:57:03 -0800
Message-ID: <CAKwvOdnbSOatU3DjKsKAeRmpVtzWUWu6NxxJ9sP-t5es6K9_Ag@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Remove unnecessary NULL check in cti_sig_type_name
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:51 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Mar 2, 2020 at 1:34 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/hwtracing/coresight/coresight-cti-sysfs.c:948:11: warning:
> > address of array 'grp->sig_types' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (grp->sig_types) {
> >         ~~  ~~~~~^~~~~~~~~
> > 1 warning generated.
> >
> > sig_types is at the end of a struct so it cannot be NULL.
> >
> > Fixes: 85b6684eab65 ("coresight: cti: Add connection information to sysfs")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/914
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Yep, GCC and Clang both eliminate the false case as impossible:
> https://godbolt.org/z/tjbDqR
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

0day just reported this, too (3 minutes after you sent your patch)
https://groups.google.com/forum/#!msg/clang-built-linux/_SpkRyhMIxI/IrBtEk-8AAAJ
If you wanted to show some love for the bot:
Reported-by: kbuild test robot <lkp@intel.com>

>
> > ---
> >  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > index abb7f492c2cb..214d6552b494 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > @@ -945,10 +945,8 @@ cti_sig_type_name(struct cti_trig_con *con, int used_count, bool in)
> >         int idx = 0;
> >         struct cti_trig_grp *grp = in ? con->con_in : con->con_out;
> >
> > -       if (grp->sig_types) {
> > -               if (used_count < grp->nr_sigs)
> > -                       idx = grp->sig_types[used_count];
> > -       }
> > +       if (used_count < grp->nr_sigs)
> > +               idx = grp->sig_types[used_count];
> >         return sig_type_names[idx];
> >  }
> >
> > --
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
