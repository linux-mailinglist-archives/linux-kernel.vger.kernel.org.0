Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C798AAB817
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbfIFMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 08:24:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41172 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfIFMYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:24:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id a4so5814598ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEuqyoR6pX9WcKO2lv8Qx9uofetASJrnmmBj7HQZAO0=;
        b=sPVCnusfoWpyRZ2QVHQwTwTXqVDSLABe1kb/Mev99Hg2vqfHfoVLATzkVRi2+ZQlU/
         jUe4bKWmFENp+T5qqbKfZENo1l8dvYqIfw+OK9uKx8yblxrFiCq65laNMqVAldjVdmmu
         1GzOuoVP5R+l+wfB6mShSS7GmPqISpD/ueZPYKZfKCo4BCRz7iD18iYuQ9oIlLVoA3Ah
         /NpIXrmXWC8JrXAC3FFaQ/G2EWcWlJXui2gM4J+oZH/lDDSMKALFRDkn2EyJjthC+RdX
         ZLl3lqv9OoD5ojMhnCCfHGU7MR8CdPT6nkoAHaWC5Fw6UNvT81yS99ZKj8c7hFrkikKG
         +JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEuqyoR6pX9WcKO2lv8Qx9uofetASJrnmmBj7HQZAO0=;
        b=LYWN0B78NqSKCY6en8SkJZB3WNtpSx7/WGceY0QOBx4ycQM1ibKERKd9pp6ZWwfSjn
         mcoFr5BZPm+qpcOedBSWaS+0jZvIME9wf+h2VLXgJV/7Spbot6ABqRypZjF/FjLS3shl
         WkIIYJK0CE/vEQu80uxPtBxMiqnVQZKdMGc9K4pgdeAxK/UtjQxHI2Ed1AyvU2MMwGL8
         cKqzETC5iheC7Fm2hsSk2GTZVguvVAeV8xw4sqU+am1KXNSZjW+UF02wG4R1xPYyfbED
         TvqeJZdzx5APJp9gYal1FmLDF2gRfEfRA/kZPqFDXbwc/1DAhjIry/LzvrR9LWK9e9a9
         BjQg==
X-Gm-Message-State: APjAAAUZ7ScM0GG/cbL8nvbGptufkaGwABhMuF9BJGrA8fCbGRF788M7
        3AUGXwnz8WewhjlSrMH6UvcE/h8/JbELkNsk2OY=
X-Google-Smtp-Source: APXvYqygEaAWPMGIe4tWR6VpyFc1DI2SYZ2tryPFQlAxF5bTrdZ+Bc90vgs+nITDv56N7g83GkVN1pcDuglS9Aq6kkY=
X-Received: by 2002:a2e:9104:: with SMTP id m4mr5521513ljg.28.1567772673112;
 Fri, 06 Sep 2019 05:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <1567708980-8804-1-git-send-email-jrdr.linux@gmail.com> <20190905185910.GS29434@bombadil.infradead.org>
In-Reply-To: <20190905185910.GS29434@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 6 Sep 2019 17:54:21 +0530
Message-ID: <CAFqt6zZ_M3_Jr_08SO+OnnurWNbLJJsNZvVDZOnjh88vzaiXGg@mail.gmail.com>
Subject: Re: [PATCH] mm/memory.c: Convert to use vmf_error()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, airlied@redhat.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:29 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 06, 2019 at 12:13:00AM +0530, Souptick Joarder wrote:
> > +++ b/mm/memory.c
> > @@ -1750,13 +1750,10 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
> >       } else {
> >               return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
> >       }
> > -
> > -     if (err == -ENOMEM)
> > -             return VM_FAULT_OOM;
> > -     if (err < 0 && err != -EBUSY)
> > -             return VM_FAULT_SIGBUS;
> > -
> > -     return VM_FAULT_NOPAGE;
> > +     if (!err || err == -EBUSY)
> > +             return VM_FAULT_NOPAGE;
> > +     else
> > +             return vmf_error(err);
> >  }
>
> My plan is to convert insert_page() to return a VM_FAULT error code like
> insert_pfn() does.  Need to finish off the vm_insert_page() conversions
> first ;-)

Previously we have problem while converting vm_insert_page() to return
vm_fault_t.

vm_insert_page() is called from different drivers. Some of them are
already converted
to use vm_map_pages()/ vm_map_pages_zero(). But still we left with few users.

drivers/media/usb/usbvision/usbvision-video.c#L1045
mm/vmalloc.c#L2969

These 2 can be converted with something like vm_map_vmalloc_pages().
I am working on it. Will post it in sometime.

drivers/android/binder_alloc.c#L259 (have objection)
drivers/infiniband/hw/efa/efa_verbs.c#L1701
drivers/infiniband/hw/mlx5/main.c#L2085 (have objection as using
vm_map_pages_zero() doesn't make sense)
drivers/xen/gntalloc.c#L548 (have limitation)
kernel/kcov.c#L297 (have objection)
net/ipv4/tcp.c#L1799
net/packet/af_packet.c#L4453

But these are the places where replacing vm_insert_page() is bit
difficult/ have objection.
In some cases, maintainers/ reviewers will not agree to replace
vm_insert_page().

In  other scenario, if we change return type of vm_insert_page() to vm_fault_t,
we end up with adding few lines of conversion code from vm_fault_t to errno
in drivers which is not a correct way to go with.

Any suggestion, how to solve this ?
