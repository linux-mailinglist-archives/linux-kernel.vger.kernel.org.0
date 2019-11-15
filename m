Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF7FD282
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 02:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKOBkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 20:40:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40151 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOBkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:40:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so6686001lfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 17:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFskqtLP2N2VaZi1tFqSAtlpsDvGGv7YPwSPEpuMZEo=;
        b=bNsKgL/vFHp5Dmh3egwCsmkq3RAyW9y/VBXFH8UbShDrDwtrKHLz34Pn4zFWo7NY3z
         5PTmOWxwXywEvoxu/SVKs/6hilrCcEjC1tkbXU0MpRa0Kjf7gd9thLWv7a4NNgMTEhjy
         R+PXiaXD6Fumb4JQVKY6gBby+WxozAtLDvBfgUxDFoXKVSVk/i0026CQAfFbbcVENqUv
         nXeDS56UsnuKqn3R+tKNQBxYvYuZ5LuP2VlicTTUdzTi6YuDc/FFH2zGkx6Wyd5uRiC9
         rZ15dZyUHKKwXmGVMqaYnwBITAFeEPy2k0xgOebCWOX4T2HsIZT7P1/Hr8okT67PFkqB
         09qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFskqtLP2N2VaZi1tFqSAtlpsDvGGv7YPwSPEpuMZEo=;
        b=A+u1oETw/GEDJ2yCVLVXO2zWxD8gpwXl0a9NcTX2aXxMHwEd8Bt06zj+XSDPFWui7M
         Oe2tXXr7yHH2rr0qV/u1YYmQOOc1gXN2Ka7JRs4v/HYK+XEdORischXVO7i9N/+nslbd
         d0wJrAWsvGaVtWVZmbJFSYk/Nnblwx7mwy8CwnpPs1AnBhiMDY2XdwoAC9HhF/slGVWD
         IWW0QVC48O6WOHVVNYIMBb3/GEXRazuZlQGVWJkqEUlSoRvsD/0kzfKp7N+robmiOsGm
         l2NHxa+8xfmpFN/eC9P49DjM+rc/u1OOAnZzrQIoek4EEHRt0zbSbJNSFvfTMWotlMFn
         Is6g==
X-Gm-Message-State: APjAAAWNOEl/xYlrAd68/1MoTg1mVlLBnFEgpHd8UBDEtARyOVxAfesQ
        YmNhV3bciDTqlwDHIUQuJ6IFn1rsbOegg1WHdF0fsg==
X-Google-Smtp-Source: APXvYqz60nURqcP+ihfir96vZTjjr0ZAN8WS3qlm2R92Tk9C+zIRN/Bzmh5fMkWjRsuUPdRJxDb2bptiDaojJBCZVYY=
X-Received: by 2002:a19:c790:: with SMTP id x138mr9439033lff.61.1573782011720;
 Thu, 14 Nov 2019 17:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20190710201244.25195-1-brijesh.singh@amd.com> <20190710201244.25195-12-brijesh.singh@amd.com>
 <CABayD+ctvNszs6gVdjP+geJTk1RN3Ko-RWaRTdeU6-7G1=F=Mw@mail.gmail.com>
In-Reply-To: <CABayD+ctvNszs6gVdjP+geJTk1RN3Ko-RWaRTdeU6-7G1=F=Mw@mail.gmail.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Thu, 14 Nov 2019 17:39:35 -0800
Message-ID: <CABayD+fnnyLxh1Nak9vskKQpLBOXROvaaj5Q64Ksx_qHB0DE5g@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] KVM: x86: Introduce KVM_SET_PAGE_ENC_BITMAP ioctl
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 5:22 PM Steve Rutherford <srutherford@google.com> wrote:
>
> On Wed, Jul 10, 2019 at 1:13 PM Singh, Brijesh <brijesh.singh@amd.com> wrote:
> >
> >  struct kvm_arch_async_pf {
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index e675fd89bb9a..31653e8d5927 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -7466,6 +7466,47 @@ static int svm_get_page_enc_bitmap(struct kvm *kvm,
> >         return ret;
> >  }
> >
> > +static int svm_set_page_enc_bitmap(struct kvm *kvm,
> > +                                  struct kvm_page_enc_bitmap *bmap)
> > +{
> > +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> > +       unsigned long gfn_start, gfn_end;
> > +       unsigned long *bitmap;
> > +       unsigned long sz, i;
> > +       int ret;
> > +
> > +       if (!sev_guest(kvm))
> > +               return -ENOTTY;
> > +
> > +       gfn_start = bmap->start_gfn;
> > +       gfn_end = gfn_start + bmap->num_pages;
> > +
> > +       sz = ALIGN(bmap->num_pages, BITS_PER_LONG) / 8;
> > +       bitmap = kmalloc(sz, GFP_KERNEL);
>
> This kmalloc should probably be either a vmalloc or kvmalloc. The max
> size, if I'm reading kmalloc correctly, is 2^10 pages. That's 4MB,
> which should correspond to a bitmap for a 128GB VM, which is a
> plausible VM size.
>
> --Steve

Ignore this, you are clearly never going to copy that much in one
call, and the backing bitmap correctly uses kvmalloc.
