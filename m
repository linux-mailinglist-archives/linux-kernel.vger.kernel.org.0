Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FD4117905
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLIWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:05:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20708 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbfLIWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575929117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foPomkZZHn+fl/+k/LBQXwFbzjdsSjHkkGqYwk6TqkM=;
        b=AzLikofF8C3Iytx4YNwACrDKLEE5Q+8aM4arrtDh807TwcKCmY4zuT2RiY683nziVfY47y
        64u7RWtaLn4kaAX09BIZ088A0c1S+icpM5o28u+AcI0rrg7NJRwTPJW4pKnB7p6FaKe69v
        EOgEcxUM7iBViwSYnOj1AAo62euKv4o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-F1kAscUePPqZ0fj6ctg55g-1; Mon, 09 Dec 2019 17:05:13 -0500
Received: by mail-qt1-f198.google.com with SMTP id o24so487804qtr.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nx7/jgy/0hqWMwbx9WXuS3LtbNfgu/8UAt4zNXzHNaM=;
        b=cZNIX5RRIdFKbi/EfQckny+9Z9NQcfeuCeodpFVnPTyg4c70QpxH45kNkS+0Q2MNFK
         oQ7fwduOjErIpcyhyCpscH7DcJQ5n1LAEf0OId97l+nuMLJevdQidyXUG5O1P9twbhHx
         1ogl6ONnpTAEP2o2hDKJFjwFBJHtJLJmX2a8LgT0tRNam8CCvpvXn7wSRNf9+4PH9ItD
         eOXJOwo1ib92L9oHsE5emVyfiRk+MoISk2X/xTC3WEV/8l59F9xpAHbfJllQI7iIl885
         uCvQp36cSCbBGqP8VqkvEANfrqmCoW+S/dOh2K2WMnjF7YftIi8Q1wjkyDVlDYwoAo7F
         Xu/g==
X-Gm-Message-State: APjAAAXRl6sPJr/i4XK694QmDcHzPBmM9ISXa5uNURHGxz9hrM3Ua0Zq
        OxCQlSmXC1IVD1W7es31iacuhmQLyVBLWyqNGk1wNy2/WTxdzGpvPB+l5miHK588VfKtxXeI/4N
        9uYqYiN90Xn7S0uGSJtIGfs3X
X-Received: by 2002:a37:794:: with SMTP id 142mr6911041qkh.348.1575929112524;
        Mon, 09 Dec 2019 14:05:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxwnec2wNeIpqiKODeEI2N6KwumS+V0HMESm4wg/+r3zeVfUjC0y3kANOIn7fAvQZWAunnvg==
X-Received: by 2002:a37:794:: with SMTP id 142mr6910997qkh.348.1575929111957;
        Mon, 09 Dec 2019 14:05:11 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id z4sm280179qkz.62.2019.12.09.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 14:05:11 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:05:10 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 01/15] KVM: Move running VCPU from ARM to common code
Message-ID: <20191209220510.GB3352@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-2-peterx@redhat.com>
 <20191203190126.GC19877@linux.intel.com>
 <a9d3301c-4c2f-9624-dc52-1033b940ef06@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a9d3301c-4c2f-9624-dc52-1033b940ef06@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: F1kAscUePPqZ0fj6ctg55g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 10:42:27AM +0100, Paolo Bonzini wrote:
> On 03/12/19 20:01, Sean Christopherson wrote:
> > In case it was clear, I strongly dislike adding kvm_get_running_vcpu().
> > IMO, it's a unnecessary hack.  The proper change to ensure a valid vCPU=
 is
> > seen by mark_page_dirty_in_ring() when there is a current vCPU is to
> > plumb the vCPU down through the various call stacks.  Looking up the ca=
ll
> > stacks for mark_page_dirty() and mark_page_dirty_in_slot(), they all
> > originate with a vcpu->kvm within a few functions, except for the rare
> > case where the write is coming from a non-vcpu ioctl(), in which case
> > there is no current vCPU.
> >=20
> > The proper change is obviously much bigger in scope and would require
> > touching gobs of arch specific code, but IMO the end result would be wo=
rth
> > the effort.  E.g. there's a decent chance it would reduce the API betwe=
en
> > common KVM and arch specific code by eliminating the exports of variant=
s
> > that take "struct kvm *" instead of "struct kvm_vcpu *".
>=20
> It's not that simple.  In some cases, the "struct kvm *" cannot be
> easily replaced with a "struct kvm_vcpu *" without making the API less
> intuitive; for example think of a function that takes a kvm_vcpu pointer
> but then calls gfn_to_hva(vcpu->kvm) instead of the expected
> kvm_vcpu_gfn_to_hva(vcpu).
>=20
> That said, looking at the code again after a couple years I agree that
> the usage of kvm_get_running_vcpu() is ugly.  But I don't think it's
> kvm_get_running_vcpu()'s fault, rather it's the vCPU argument in
> mark_page_dirty_in_slot and mark_page_dirty_in_ring that is confusing
> and we should not be adding.
>=20
> kvm_get_running_vcpu() basically means "you can use the per-vCPU ring
> and avoid locking", nothing more.  Right now we need the vCPU argument
> in mark_page_dirty_in_ring for kvm_arch_vcpu_memslots_id(vcpu), but that
> is unnecessary and is the real source of confusion (possibly bugs too)
> if it gets out of sync.
>=20
> Instead, let's add an as_id field to struct kvm_memory_slot (which is
> trivial to initialize in __kvm_set_memory_region), and just do
>=20
> =09as_id =3D slot->as_id;
> =09vcpu =3D kvm_get_running_vcpu();
>=20
> in mark_page_dirty_in_ring.

Looks good.  I'm adding another patch for it, and dropping patch 2 then.

Thanks,

--=20
Peter Xu

