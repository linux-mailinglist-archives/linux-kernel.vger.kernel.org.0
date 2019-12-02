Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9535B10E476
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLBCNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:13:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbfLBCNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575252823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MD/FUEK42oSHMB7hiycg0mH61x0MK91ak8z6OEH++Z0=;
        b=T1Es0AUD4KcF/qxKdp285bBeB8O63KP2B5UQj8SshHdEOPIw7PsTEuqP2ezdvNyGSHkI3K
        riuE30Fm1Y2XzGtMOhIva50LqVzPdTFJORm7nJzuEBAzIWgh9P5KVvVnHw4s87NbFjMRjl
        KmCJuSa96bgCKTTpfQfuQdO8WAvMBhM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-YowkO8D2PuK8ILHP_CfUiw-1; Sun, 01 Dec 2019 21:13:40 -0500
Received: by mail-qk1-f199.google.com with SMTP id a6so8613349qkl.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 18:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQnpA7RgxlDdEF2H0g9kRjOpdctax1cqipl0/e6Vazw=;
        b=s31W93llbKk2kdtWb5KpoCd6EYcm7FQ1KWn0QjKE6QRMH2GE/0JY4/CSkFozfbz5GC
         d5MZyR58mJRt41Oo6SQsl6jH7WL3TsJiRmWGiWK2rLLYNkyrWVpvrf9IRw+scFkpwv2k
         X+NLaZE9pKmFFW7fdNNPJLYCVVs+MGSIO3oJBZymX5zh2Z+49MXu/BoY4a/+2Xx8WIYi
         nSK4A7pAAx0wLYRirZfofvEcUYonfoG6aSulA24HssjR7rMsrhDDnMP24CXFn3jpkefK
         pvJ/2LQkLP9YNKrczYIH8FtjpAHG28bniz976969J4fKV8QfY/5L/a8tV+jZD+v5q379
         37jA==
X-Gm-Message-State: APjAAAXF6SypQ80l/XNXBrTWI2rV5kUJ0uJZjq59VKzuQOvCfSC7TFXl
        LSxBPciDsOdpemJfHdKxw2OIpQtlX2ZWibOxw8pALVhDwQX1vxV14ZtBylaPVCMieKItfh23A0a
        LNVwn7H7N15XCYkCY28kgiGir
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr29206599qkk.95.1575252819787;
        Sun, 01 Dec 2019 18:13:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsdEchHsrOVaCZ8ufxraE/74iOHuQ4QYI2j0xs5NsWVwh/PU27/D7I8XoWwMEw91CB7nHisA==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr29206580qkk.95.1575252819395;
        Sun, 01 Dec 2019 18:13:39 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
        by smtp.gmail.com with ESMTPSA id z4sm4262259qkz.62.2019.12.01.18.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 18:13:38 -0800 (PST)
Date:   Sun, 1 Dec 2019 21:13:37 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
Message-ID: <20191202021337.GB18887@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: YowkO8D2PuK8ILHP_CfUiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 09:29:42AM +0100, Paolo Bonzini wrote:
> Hi Peter,
>=20
> thanks for the RFC!  Just a couple comments before I look at the series
> (for which I don't expect many surprises).
>=20
> On 29/11/19 22:34, Peter Xu wrote:
> > I marked this series as RFC because I'm at least uncertain on this
> > change of vcpu_enter_guest():
> >=20
> >         if (kvm_check_request(KVM_REQ_DIRTY_RING_FULL, vcpu)) {
> >                 vcpu->run->exit_reason =3D KVM_EXIT_DIRTY_RING_FULL;
> >                 /*
> >                         * If this is requested, it means that we've
> >                         * marked the dirty bit in the dirty ring BUT
> >                         * we've not written the date.  Do it now.
> >                         */
> >                 r =3D kvm_emulate_instruction(vcpu, 0);
> >                 r =3D r >=3D 0 ? 0 : r;
> >                 goto out;
> >         }
>=20
> This is not needed, it will just be a false negative (dirty page that
> actually isn't dirty).  The dirty bit will be cleared when userspace
> resets the ring buffer; then the instruction will be executed again and
> mark the page dirty again.  Since ring full is not a common condition,
> it's not a big deal.

Actually I added this only because it failed one of the unit tests
when verifying the dirty bits..  But now after a second thought, I
probably agree with you that we can change the userspace too to fix
this.

I think the steps of the failed test case could be simplified into
something like this (assuming the QEMU migration context, might be
easier to understand):

  1. page P has data P1
  2. vcpu writes to page P, with date P2
  3. vmexit (P is still with data P1)
  4. mark P as dirty, ring full, user exit
  5. collect dirty bit P, migrate P with data P1
  6. vcpu run due to some reason, P was written with P2, user exit again
     (because ring is already reaching soft limit)
  7. do KVM_RESET_DIRTY_RINGS
  8. never write to P again

Then P will be P1 always on destination, while it'll be P2 on source.

I think maybe that's why we need to be very sure that when userspace
exits happens (soft limit reached), we need to kick all the vcpus out,
and more importantly we must _not_ let them run again before the
KVM_RESET_DIRTY_PAGES otherwise we might face the data corrupt.  I'm
not sure whether we should mention this in the document to let the
userspace to be sure of the issue.

On the other side, I tried to remove the emulate_instruction() above
and fixed the test case, though I found that the last address before
user exit is not really written again after the next vmenter right
after KVM_RESET_DIRTY_RINGS, so the dirty bit was truly lost...  I'm
pasting some traces below (I added some tracepoints too, I think I'll
just keep them for v2):

  ...
  dirty_log_test-29003 [001] 184503.384328: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.384329: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.384329: kvm_page_fault:       address 7=
fc036d000 error_code 582
  dirty_log_test-29003 [001] 184503.384331: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.384332: kvm_exit: reason EPT_VIOLATION =
rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.384332: kvm_page_fault:       address 7=
fc036d000 error_code 582
  dirty_log_test-29003 [001] 184503.384332: kvm_dirty_ring_push:  ring 1: d=
irty 0x37f reset 0x1c0 slot 1 offset 0x37e ret 0 (used 447)
  dirty_log_test-29003 [001] 184503.384333: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.384334: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.384334: kvm_page_fault:       address 7=
fc036e000 error_code 582
  dirty_log_test-29003 [001] 184503.384336: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.384336: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.384336: kvm_page_fault:       address 7=
fc036e000 error_code 582
  dirty_log_test-29003 [001] 184503.384337: kvm_dirty_ring_push:  ring 1: d=
irty 0x380 reset 0x1c0 slot 1 offset 0x37f ret 1 (used 448)
  dirty_log_test-29003 [001] 184503.384337: kvm_dirty_ring_exit:  vcpu 1
  dirty_log_test-29003 [001] 184503.384338: kvm_fpu:              unload
  dirty_log_test-29003 [001] 184503.384340: kvm_userspace_exit:   reason 0x=
1d (29)
  dirty_log_test-29000 [006] 184503.505103: kvm_dirty_ring_reset: ring 1: d=
irty 0x380 reset 0x380 (used 0)
  dirty_log_test-29003 [001] 184503.505184: kvm_fpu:              load
  dirty_log_test-29003 [001] 184503.505187: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.505193: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.505194: kvm_page_fault:       address 7=
fc036f000 error_code 582              <-------- [1]
  dirty_log_test-29003 [001] 184503.505206: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.505207: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.505207: kvm_page_fault:       address 7=
fc036f000 error_code 582
  dirty_log_test-29003 [001] 184503.505226: kvm_dirty_ring_push:  ring 1: d=
irty 0x381 reset 0x380 slot 1 offset 0x380 ret 0 (used 1)
  dirty_log_test-29003 [001] 184503.505226: kvm_entry:            vcpu 1
  dirty_log_test-29003 [001] 184503.505227: kvm_exit:             reason EP=
T_VIOLATION rip 0x40359f info 582 0
  dirty_log_test-29003 [001] 184503.505228: kvm_page_fault:       address 7=
fc0370000 error_code 582
  dirty_log_test-29003 [001] 184503.505231: kvm_entry:            vcpu 1
  ...

The test was trying to continuously write to pages, from above log
starting from 7fc036d000. The reason 0x1d (29) is the new dirty ring
full exit reason.

So far I'm still unsure of two things:

  1. Why for each page we faulted twice rather than once.  Take the
     example of page at 7fc036e000 above, the first fault didn't
     trigger the marking dirty path, while only until the 2nd ept
     violation did we trigger kvm_dirty_ring_push.

  2. Why we didn't get the last page written again after
     kvm_userspace_exit (last page was 7fc036e000, and the test failed
     because 7fc036e000 detected change however dirty bit unset).  In
     this case the first write after KVM_RESET_DIRTY_RINGS is the line
     pointed by [1], I thought it should be a rewritten of page
     7fc036e000 because when the user exit happens logically the write
     should not happen yet and eip should keep.  However at [1] it's
     already writting to a new page.

I'll continue to dig tomorrow, or quick answers will be greatly
welcomed too. :)

>=20
> > I did a kvm_emulate_instruction() when dirty ring reaches softlimit
> > and want to exit to userspace, however I'm not really sure whether
> > there could have any side effect.  I'd appreciate any comment of
> > above, or anything else.
> >=20
> > Tests
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > I wanted to continue work on the QEMU part, but after I noticed that
> > the interface might still prone to change, I posted this series first.
> > However to make sure it's at least working, I've provided unit tests
> > together with the series.  The unit tests should be able to test the
> > series in at least three major paths:
> >=20
> >   (1) ./dirty_log_test -M dirty-ring
> >=20
> >       This tests async ring operations: this should be the major work
> >       mode for the dirty ring interface, say, when the kernel is
> >       queuing more data, the userspace is collecting too.  Ring can
> >       hardly reaches full when working like this, because in most
> >       cases the collection could be fast.
> >=20
> >   (2) ./dirty_log_test -M dirty-ring -c 1024
> >=20
> >       This set the ring size to be very small so that ring soft-full
> >       always triggers (soft-full is a soft limit of the ring state,
> >       when the dirty ring reaches the soft limit it'll do a userspace
> >       exit and let the userspace to collect the data).
> >=20
> >   (3) ./dirty_log_test -M dirty-ring-wait-queue
> >=20
> >       This sololy test the extreme case where ring is full.  When the
> >       ring is completely full, the thread (no matter vcpu or not) will
> >       be put onto a per-vm waitqueue, and KVM_RESET_DIRTY_RINGS will
> >       wake the threads up (assuming until which the ring will not be
> >       full any more).
>=20
> One question about this testcase: why does the task get into
> uninterruptible wait?

Because I'm using wait_event_killable() to wait when ring is
completely full.  I thought we should be strict there because it's
after all rare (even more rare than the soft-limit reached), and with
that we will never have a change to lose a dirty bit accidentally.  Or
do you think we should still respond to non fatal signals due to some
reason even during that wait period?

Thanks,

--=20
Peter Xu

