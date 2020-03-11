Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF8181F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgCKR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:27:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33195 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgCKR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:27:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id f13so3289629ljp.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6sQSsi3UobD+SiMyauoIL5YpFnOKCsVWdR687lY+ao=;
        b=NJYDNI6MqJAuLHpRl9YLDtRo4dN9HMkarsiN1uMKPDOb3afVGpwPtCRqkGSUNF4kTh
         DuT1S09TVZrg8COFoWRDf5FT4BFBjn1MchXIuuUT5KRNuKaUma3aHeT5KIPl5SJ+sXwF
         eEyxd7XlyaC4c5fm3Ud6HJ7nspp6krpFIF+OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6sQSsi3UobD+SiMyauoIL5YpFnOKCsVWdR687lY+ao=;
        b=b1YWMeUM8ycHuN0oa1/nnzDtHn1WVLMGFlaewBdfOPY5/RfxncdPqXEuHXDXOQ/5E1
         7LrDuPRg6KrBxX/Ldb8CGe/nEhfnPbysMkZLqHzDOoILUJjonkiUff9O9E+L2lrY8J0R
         C2ivFHFrFJOUprPNf+2MVNQL5YA92Rhul8CmWVNlpSyFgmFFU/gCtVTF80bznBsSvNL3
         55rWBb+w68kkdNP0eeZOjz8n3M9SRaGP1qtkeSG5/LVzztu190q1zT4btsgct8rw7fYo
         a9ZuCu6OgCUSVY72Z9n2Tai3SWpjyEPouC7gWhI4imjthvM60qboEHQEkyzcjtzBt5uz
         cL/w==
X-Gm-Message-State: ANhLgQ30BDYYsBkhnRHThdtGmXtcd9SCv9cGa4oV86VVLFEg26uH6GWN
        wTFGNWGIzPqJpIkBHJ+XxZkD6kImjXk=
X-Google-Smtp-Source: ADFU+vuBDoIgg6lJv4YnfX9wH+wEiK89LSEm80fjbjiPi7/v5Tl6fiDp+70R1OZJrRySfSy9dlka8A==
X-Received: by 2002:a2e:a16a:: with SMTP id u10mr2636998ljl.283.1583947669229;
        Wed, 11 Mar 2020 10:27:49 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v9sm1958561ljv.82.2020.03.11.10.27.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:27:48 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i19so2444354lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:27:48 -0700 (PDT)
X-Received: by 2002:ac2:5203:: with SMTP id a3mr2792496lfl.152.1583947667785;
 Wed, 11 Mar 2020 10:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com> <e97de44a-39b0-c4fa-488c-d9fa76eb1eae@gmx.com>
In-Reply-To: <e97de44a-39b0-c4fa-488c-d9fa76eb1eae@gmx.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:27:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBLLdMH2-qu3_ZkQjX3zXNmmDHWSoO_=mLBbzzQ5O0yg@mail.gmail.com>
Message-ID: <CAHk-=whBLLdMH2-qu3_ZkQjX3zXNmmDHWSoO_=mLBbzzQ5O0yg@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:21 AM Artem S. Tashkinov <aros@gmx.com> wrote:
>
> I've been able to compile and run
> e3a36eb6dfaeea8175c05d5915dcf0b939be6dab successfully. I won't claim
> this patch doesn't break something for other people :-)

Thanks, that's all I was looking for.

If it breaks something for somebody else, I have a solid plan for that
too: I'll just sit in a corner and cry.

               Linus
