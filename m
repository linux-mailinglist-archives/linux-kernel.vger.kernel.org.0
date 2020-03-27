Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47FD1960BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0VwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 17:52:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34618 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0VwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:52:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id b5so7248386vsb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLSkqDjXGppnPQSy1Vn0gnXBsoZc1g+ZDEEe2pp7iqI=;
        b=YydX8RqTyhKyz/B4VUga1a//AGjDjr7Nr79zSPRYZTfxaC+puymOH7pA23Ql7DCnm1
         vYFJQ+FLGy64gw2HerQpyB0gOZNFNO4GkAb4BVErMpMLYCh2EJoOxSr0XYzzBZoqj1PO
         +IitK6PY4QlHtTFeLIiudauk4IIk6b4g1KSrX4N6XFmaOoKNbATqeNY199XL9aSdE8sN
         GKXWUJcKt8w9KV5HmET79hldXYVsXrS6AOOYcV0dPTX25mn03Be7fR4qxLog/vo4k4LB
         KYOXk9/sNR8RTOw3c4G0rwEJTx1BadjJlcuviPy1XTpU2HXFXmzqkJlQsvxMJqqShFEq
         RCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLSkqDjXGppnPQSy1Vn0gnXBsoZc1g+ZDEEe2pp7iqI=;
        b=SEJy3tFP3/S1sDGkoCqzulvtKSad/Itmq3Z3YPyYeoyHLSolD6SPkV5mMTkRs4mhvs
         L/6NiNq1a6zCp4Wh1iYcKSlyw0SD89Xe5KjMLMW/VFcXJn1bVo4gw4dGeTttX6DKeeat
         Wd54wG4CNWjTr/FLdBMENbnytmNQTVrHII2DVK436mlc5ws/HRCGALDp4y13nbAbM2fP
         W2qV+Cx7bsxeK8H/QcQzRzO246zl5QTbNcxOGaUnlNkVlW83hrOCFBxEhrlIAqkTD0mn
         NeECueFaIrO0sOUoIncAQ4MxRYVgRXeNGpsdBd/GSF/hHaqPfFqtyIOTSqQ3YbnEqB35
         Fjxg==
X-Gm-Message-State: AGi0PuZfLMsrYE3SaVfXfk+b+el2riRrObUuL7HHTIM1KZdq19L6dqjD
        gibjDLPKQVHJqF5xTAwuj0OvVN6AgWubt0uggo3quA==
X-Google-Smtp-Source: APiQypIoUiQ5u6gME0sLlzFcrOhyd8GUObNa5eYTBQkDXuTqasu0a+KM2vJyyqPfpqdzxA0nd8PMMEomLbZgqgERdRA=
X-Received: by 2002:a67:ee81:: with SMTP id n1mr1004632vsp.184.1585345942344;
 Fri, 27 Mar 2020 14:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com> <20200327021058.221911-2-walken@google.com>
 <20200327121625.GS20941@ziepe.ca>
In-Reply-To: <20200327121625.GS20941@ziepe.ca>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 27 Mar 2020 14:52:09 -0700
Message-ID: <CANN689EDuc-9tcBcOOP+4CWeAxjKJq95yxJtZXvCo3H0GBcyrQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mmap locking API: initial implementation as
 rwsem wrappers
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 5:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 26, 2020 at 07:10:49PM -0700, Michel Lespinasse wrote:
>
> > +static inline bool mmap_is_locked(struct mm_struct *mm)
> > +{
> > +     return rwsem_is_locked(&mm->mmap_sem) != 0;
> > +}
>
> I didn't notice any callers to this in the series? Can it be deleted?

Good catch. Yes, it should be deleted. There were 5 uses in v1 of this
patchset and I got rid of these in v2 of the patchset, but forgot to
actually remove the function definition here.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
