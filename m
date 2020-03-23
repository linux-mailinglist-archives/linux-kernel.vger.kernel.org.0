Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44BA18F9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCWQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:36:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38802 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgCWQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:36:35 -0400
Received: by mail-io1-f66.google.com with SMTP id m15so9710373iob.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZed4vuzAn5/aNVB1Kdbz5tqSTALBHIWaW5u1icHeCY=;
        b=U/UGFiIz7X9b1XORx4G0t8VK2Vtpq2Ha1+ZZX+tSAZSdmyebvAE6+Y5V3rx3lRKG75
         CaHAQofdlayPv8CK04pkyFPISqwOZ12wVaCKtxGqI4L8OqxNPE68vVotVCsaseur+Ke9
         SDsz2XIy4C592KfSooSZAhWPZTKCfbcd5AWndoy4+d4IIEx/bHdOUdzz6BxLR7+ixqYW
         rcJzSdbZIBxjMhIqu4WIJZNRXUn2zvi37lc4UaBlYGHLeJvWuz0qY8+n2KBNobObumAh
         Vyp5WAg+o0j7apYcrfEYWq3QtkCZfO+hrK1eyHyvgtlR5wWrZY2JasZicfeV2wqt3zB2
         yg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZed4vuzAn5/aNVB1Kdbz5tqSTALBHIWaW5u1icHeCY=;
        b=OVRsDzblTySb8TXFYHBNVE1+QEu9sq9p4OlrqCoz4l4T2OXKQ/bOsYWniB6JDLFouw
         aQkIcvuaDqhyd9J8RFII9XlvJoMj3Ea7r+E4vm8C+7Pc7nyvnSjJrL9mkbx4tWLsaHJh
         II9iubMluw+PCr11uptlaw4LgJMnFxHvNJf5cAoMuaqGoY+ibau4PFe7PRbBg/LbpDq7
         zis8j8hNCiG/8XBhaXTNUieXMUrpqtMxXP2k4vdw2d4EprTbEA1mBRCjqwRjkqhoU2jx
         L4DBNCbgCl04zi+ofPEWQZ0hIil0iPjThVXMlhv7tUXB+wQSwrngZC2l6ymsk0GqptNK
         HtJw==
X-Gm-Message-State: ANhLgQ3+5+P87EWDWi0iriMw75smC5KMK3qIGBuDMGX8w8rmq2k7sPzf
        mWW8W11Lt52QPRwYm++fx6fPuKDPb6+yOtu8+ktwvA==
X-Google-Smtp-Source: ADFU+vsWzcumLwhqw56m/BCbndSZWQyTZy977Pe1EcOchX9GJbFfWlVB9Xjq+FDtNdouWnpRTTre4vuCJsXIdPHUUk8=
X-Received: by 2002:a02:5a87:: with SMTP id v129mr19330387jaa.48.1584981393823;
 Mon, 23 Mar 2020 09:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-4-sean.j.christopherson@intel.com> <CALMp9eR5Uu7nRDOS2nQHGzb+Gi6vjDEk1AmuiqkkGWFjKNG+sA@mail.gmail.com>
 <20200323162807.GN28711@linux.intel.com>
In-Reply-To: <20200323162807.GN28711@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 23 Mar 2020 09:36:22 -0700
Message-ID: <CALMp9eR42eM7g81EgHieyNky+kP2mycO7UyMN+y2ibLoqrD2Yg@mail.gmail.com>
Subject: Re: [PATCH v3 03/37] KVM: nVMX: Invalidate all EPTP contexts when
 emulating INVEPT for L1
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 9:28 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Mar 23, 2020 at 09:24:25AM -0700, Jim Mattson wrote:
> > On Fri, Mar 20, 2020 at 2:29 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > Free all L2 (guest_mmu) roots when emulating INVEPT for L1.  Outstanding
> > > changes to the EPT tables managed by L1 need to be recognized, and
> > > relying on KVM to always flush L2's EPTP context on nested VM-Enter is
> > > dangerous.
> > >
> > > Similar to handle_invpcid(), rely on kvm_mmu_free_roots() to do a remote
> > > TLB flush if necessary, e.g. if L1 has never entered L2 then there is
> > > nothing to be done.
> > >
> > > Nuking all L2 roots is overkill for the single-context variant, but it's
> > > the safe and easy bet.  A more precise zap mechanism will be added in
> > > the future.  Add a TODO to call out that KVM only needs to invalidate
> > > affected contexts.
> > >
> > > Fixes: b119019847fbc ("kvm: nVMX: Remove unnecessary sync_roots from handle_invept")
> >
> > The bug existed well before the commit indicated in the "Fixes" line.
>
> Ah, my bad.  A cursory glance at commit b119019847fbc makes that quite
> obvious.  This should be
>
>   Fixes: bfd0a56b9000 ("nEPT: Nested INVEPT")

Actually, I think that things were fine back then (though we
gratuitously flushed L1's TLB as a result of an emulated INVEPT). The
problem started when we stopped flushing the TLB on every emulated
VM-entry (i.e. L1 -> L2 transitions). I'm not sure what that commit
was, but I think you referenced it in an earlier email.
