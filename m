Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6EB9731
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406531AbfITSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 14:31:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33292 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406488AbfITSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:31:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id g25so7043131otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhEh8bVzYUGuUCB/RpHUx78n8Qc9+jFz1obXEDydgGw=;
        b=A+jpbUMt0eQyN9IeJlC+6ZG3CYqMX3zZLIMp0aWDMveI99go9TGsKvmQQYHQU/DrQT
         rzDqBeTODojWZUAHWTBfF65DPs1ZYeZp96wCBpIV59NW53jvSnsdtPBs4NemKWzgiWws
         crKQJb2NIE9OvYaBFANsTHDHtqOVg69nieaZDOH5CKSXAiRKHOQ5M3XoY4Z1Vxw57Snl
         +MbA6DAPhFag6JTu1b0fFiN+VgAu62Zuus5tgsYTvGZIoxZBSIHSy7hFpxIP8dOPmkoB
         dFOWcZXf86ENnEuRv8zBV73wAFcTTPKcHRhs1oz0ialrnNLtej2MgHiKXCojYMynJXT8
         kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhEh8bVzYUGuUCB/RpHUx78n8Qc9+jFz1obXEDydgGw=;
        b=rI1iWKwOm+k5wsJpKmtU/j1Tdeaqvs869SCy/aYbvtqaa9CLV+j9z36A/VYYrNneoT
         fN5/ElUudzcfBsPeWuXMCfxKcSjFJOAHEMwRV0uf4B19xF65VHkG71Z0hEUbvx0PUElV
         bOIH59heyGp3vwO0vjoAta9rKjYuxys8/jwH2bOraTQGk+GUhGhreBtVyCGH6xR5djTv
         pd7xh0LrtWf07lGUtNMrfVpbeoBhH+YHEX0Nr6UcNJOfY5NuAlRPnZb5BolIPqBVoFUb
         cWIPdQG4k/7U4HpS1ZAAt6idBZdy9CPcVBJsk9saJeoKw4t7U0BdkWaAtc8thNtpawFM
         TRUw==
X-Gm-Message-State: APjAAAUmbQoTiLgKu5EBDYfcj62XR1reEoYDV/VIRvGDKGr1BhAA+ZUT
        s6H940h3GtBtLjrV4gw0qTSs0DjtgXU9hpbxB7ylRgx8A6U=
X-Google-Smtp-Source: APXvYqw3ifHvoFnzQ3exGPJpJXSnXKYAdYLlKTBTPDAEXq5TsrOPPKZJgZpC1mlD62hN93w9yJRbykcofvi3kYWSMGo=
X-Received: by 2002:a9d:3b02:: with SMTP id z2mr1415168otb.71.1569004288709;
 Fri, 20 Sep 2019 11:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com> <1569003478.5576.202.camel@lca.pw>
In-Reply-To: <1569003478.5576.202.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Sep 2019 11:31:16 -0700
Message-ID: <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
To:     Qian Cai <cai@lca.pw>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
> > Qian Cai <cai@lca.pw> writes:
> >
> > > The linux-next commit "libnvdimm/dax: Pick the right alignment default when
> > > creating dax devices" causes powerpc failed to build with this config. Reverted
> > > it fixed the issue.
> > >
> > > ERROR: "hash__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
> > > ERROR: "radix__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko]
> > > undefined!
> > > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
> > > make: *** [Makefile:1305: modules] Error 2
> > >
> > > [1] https://patchwork.kernel.org/patch/11133445/
> > > [2] https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> >
> > Sorry for breaking the build. How about?
>
> It works fine.

Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
default when creating dax devices" until after -rc1 to allow Michael
time to ack/nak this new export.
