Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7621A151C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBDOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:42:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727240AbgBDOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580827329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtNuq+c53520XJbZSzjdH2GmUQ771nRPcTR/Jk2Pais=;
        b=GhK5f+pMeZWRQvW/yUXgbHCznJNiTlkNVWIZ0RCgpN04KOcdkkS6G1Ts5848aUysfgdeqf
        Txh1gXLZCCkbVAqv1pab7vDs/cpZOlbfrkPVnK2F3Enm4vtDul7TyvEoUEtrMmt7kLLqY+
        8f2iHCVb1SQ1jNiAZDFK/5vHoKJ5VMU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-dlOoZ5gaPneKlSZF2oAnFQ-1; Tue, 04 Feb 2020 09:42:07 -0500
X-MC-Unique: dlOoZ5gaPneKlSZF2oAnFQ-1
Received: by mail-wm1-f69.google.com with SMTP id n17so1468976wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CtNuq+c53520XJbZSzjdH2GmUQ771nRPcTR/Jk2Pais=;
        b=KBqJPi4qX6FZ7b5wf9EP8IpoU1+i89MDutKyzKpN4c+RoBZdIyvfMCCHrUj+i2F5jC
         IU33772UdL+hnEwsYtJdDrfbuVG6CIgCpEwhHqtGZqdgeaZSZb3maSkoWEF8GcDm0Sea
         nv0XsxU6gLEN9LoRY30IFvBNtrKkYZPpNQSAzcNUj16QUVfcDIiqfD3E1PWv3G41FxB1
         CFKVWpjm/ADFTdR0hQis8JDLwYHpjEUWGIwupVTvSL68Diwdw1q3/vrPa9d5FMrZp1CW
         edjBvgA/7FghniBwO8myT0BX48cEN8Wm+WxQLLXXT4jvGw3MAmZ1fYptgquTYKnGKY20
         lFXA==
X-Gm-Message-State: APjAAAVBoG1AMBvayX7V20yp1VhhrPNaa7l6kDqn69Gy0H8uXuZWMt2F
        6OQRbkDgaHNxkNZbV1mvSrPZczIUaCmPr7ucqh/+isvON1PAFzY8IjQZxHWllZfyhPGyzJxyNVL
        lvwHt/pXDDcged5qxD3mJgz3p
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr6355194wme.111.1580827326388;
        Tue, 04 Feb 2020 06:42:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqypTDEDakV76RkWQqeNB72gLx3oT4S4iakRJIIuDBeaPp0gC9/miKhqArP5K8jyNcHqIoM9Mg==
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr6355174wme.111.1580827326200;
        Tue, 04 Feb 2020 06:42:06 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t5sm29943498wrr.35.2020.02.04.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:42:05 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: Pre-allocate 1 cpumask variable per cpu for both pv tlb and pv ipis
In-Reply-To: <20200204142733.GI40679@calabresa>
References: <CANRm+CwwYoSLeA3Squp-_fVZpmYmxEfqOB+DGoQN4Y_iMT347w@mail.gmail.com> <878slio6hp.fsf@vitty.brq.redhat.com> <CANRm+CzkN9oYf4UqWYp2SHFii02=pvVLbW4oNkLmPan7ZroDZA@mail.gmail.com> <20200204142733.GI40679@calabresa>
Date:   Tue, 04 Feb 2020 15:42:04 +0100
Message-ID: <871rrao1mr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:

>> > >      /*
>> > > @@ -624,6 +625,7 @@ static void __init kvm_guest_init(void)
>> > >          kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>> > >          pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>> > >          pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>> > > +        pr_info("KVM setup pv remote TLB flush\n");
>> > >      }
>> > >
>
> I am more concerned about printing the "KVM setup pv remote TLB flush" message,
> not only when KVM pv is used, but pv TLB flush is not going to be used, but
> also when the system is not even paravirtualized.

Huh? In Wanpeng's patch this print is under

	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))

and if you mean another patch we descussed before which was adding
 (!kvm_para_available() || nopv) check than it's still needed. Or,
alternatively, we can make kvm_para_has_feature() check for that.

-- 
Vitaly

