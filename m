Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD1154C53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBFTgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 14:36:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727479AbgBFTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581017808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63tHR8gxCpqnhyTTleCyjPFAZKtvnLPIWeZPDjhFIKk=;
        b=IghUHWOYzlEpLVRO7hXzMQtDnSvBxJHGWCZ49OTakVGfulRHz/0pvXR/EeeZD8SXE8sNcQ
        Sx5D+OH+A9WCWQql0rZ0I04JSzZYLKt6mi8QYLCrd/PyF+hjyABRd8mwP/H7taj7HUkwUu
        nBtpAU9iNADT4/veFSaPoPIczYLlRzk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-uNXtqS1UMvOn5Sv17L7DaQ-1; Thu, 06 Feb 2020 14:36:44 -0500
X-MC-Unique: uNXtqS1UMvOn5Sv17L7DaQ-1
Received: by mail-qv1-f72.google.com with SMTP id cn2so4386765qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63tHR8gxCpqnhyTTleCyjPFAZKtvnLPIWeZPDjhFIKk=;
        b=EJ/nT72jFHCKmMz/1BKiRoSXU4uXz71FMgqpB8jhVnZLvyIrvNVmcDYj81JHV0ly7J
         3bnvzRzUbGSb2rNJFgPDxYDS4FjB5LFM8VC2KLNrwd1MjokAy/Bekz/MeIAgsjhbxbbE
         y66cPozMk0WukUtzlSEGE4bW+KH0FC7gF+1Sac6FFhuahUBFjz5KqqxdoSNG3W6Q1oze
         DZrNab7UbdynPFtLwdooVpzLKIm2sTrsMjb7hu8kXz9nBkYrF+HRp9RJbb5aIQT49gkT
         SNner/jGLmgXmKPcAP5GpDF26mWuZzdtQC5jx+ARf/3pkb5DqJ3/uqqU+i8H6AMRlVwS
         TqCw==
X-Gm-Message-State: APjAAAXp4kZoumRM2rZNr05ZINXfJh4E7faicPhT0M1nZEbUZrs2VyUN
        5XFMNA/St4TL0e1vla1Yas8BZrxhv+AQ2scfvRmvMPizkC50IsSYeLbQMZiUNzCPGjsw6hSZw/Y
        tVOE6lKPiShZBmypKMbTIQiXj
X-Received: by 2002:ac8:42c6:: with SMTP id g6mr4191475qtm.250.1581017803989;
        Thu, 06 Feb 2020 11:36:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzatdWQ9u1Csyt6ZBqzWmkIODyw51F4x3+ll70oC84aFgUA9YxLV7t3Xset8ndnG7nclcebeQ==
X-Received: by 2002:ac8:42c6:: with SMTP id g6mr4191461qtm.250.1581017803755;
        Thu, 06 Feb 2020 11:36:43 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm135332qtd.45.2020.02.06.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:36:43 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:36:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 14/19] KVM: Clean up local variable usage in
 __kvm_set_memory_region()
Message-ID: <20200206193640.GB700495@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-15-sean.j.christopherson@intel.com>
 <20200206190641.GA700495@xz-x1>
 <20200206192230.GE13067@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206192230.GE13067@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:22:30AM -0800, Sean Christopherson wrote:
> On Thu, Feb 06, 2020 at 02:06:41PM -0500, Peter Xu wrote:
> > On Tue, Jan 21, 2020 at 02:31:52PM -0800, Sean Christopherson wrote:
> > 
> > [...]
> > 
> > > @@ -1101,52 +1099,55 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> > >  		return -EINVAL;
> > >  
> > > -	slot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> > > -	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
> > > -	npages = mem->memory_size >> PAGE_SHIFT;
> > > -
> > > -	if (npages > KVM_MEM_MAX_NR_PAGES)
> > > -		return -EINVAL;
> > > -
> > >  	/*
> > >  	 * Make a full copy of the old memslot, the pointer will become stale
> > >  	 * when the memslots are re-sorted by update_memslots().
> > >  	 */
> > > -	old = *slot;
> > > +	tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> > > +	old = *tmp;
> > > +	tmp = NULL;
> > 
> > Shall we keep this chunk to the patch where it will be used?  Other
> > than that, it looks good to me.
> 
> I assume you're talking about doing this instead of using @tmp?
> 
> 	old = *id_to_memslot(__kvm_memslots(kvm, as_id), id);

Yes.

> 
> It's obviously possible, but I really like resulting diff for
> __kvm_set_memory_region() in "KVM: Terminate memslot walks via used_slots"
> when tmp is used.
> 
> @@ -1104,8 +1203,13 @@ int __kvm_set_memory_region(struct kvm *kvm,
>          * when the memslots are re-sorted by update_memslots().
>          */
>         tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> -       old = *tmp;
> -       tmp = NULL;
> +       if (tmp) {
> +               old = *tmp;
> +               tmp = NULL;
> +       } else {
> +               memset(&old, 0, sizeof(old));
> +               old.id = id;
> +       }

I normally don't do that, for each patch I'll try to make it
consistent to itself, assuming that follow-up patches can be rejected.
I don't have strong opinion either, please feel free to keep them if
no one disagrees.

-- 
Peter Xu

