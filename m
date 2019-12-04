Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30E7113569
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfLDTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:07:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbfLDTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575486445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3sjFZw9opuacU4JfT1I2hipUIWoYYgMlYwS54eyyzWE=;
        b=gbBFrW2+0ObWpgBW7Sf8SWFWe6IfVLLQXQ3f+12JTKNfH/ZQbN0qBNWfEboYlzvF+5pJeD
        MuHG2sQNrWyiH4npwrT/rKNEiAzFUrNl5eRNoL5hui7+K/fpZLFCx/uQGb6+2ghQvvYjqb
        VOKkB1WgZLtSp2XGRBMCguOQ8AW+ugU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-8-oRSS8oMvKvJNNz-aNKfA-1; Wed, 04 Dec 2019 14:07:24 -0500
Received: by mail-qk1-f198.google.com with SMTP id q125so450916qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xsItnjtI2JZZmK3Ztp9Y4PpNo6TZaMFBK50xKDCNG6o=;
        b=f/3LDfN0JUb4xoo0wzZQGsNxnCRFTFhpTTfMRh4L+E+H28ghQun1suGO69YKUyQdY8
         7eT3zvSjcsunc4fGJ747RRkGOrwDJR4UVX0o7wt7GeWC2IU961ZMWYpu7Dj8yTdp3ypx
         /t1WB35y1nGfhhAYFUIgRd132aTR12e77E/8eXjsuDMbjUWjAFcydUjAYL71r1iR1XPB
         FNn3fQd36iO3vd4lDyQa8KfEXBc0pH2upSY/VP/g0/tZO/65EwszJk6Dw6gkH5NyChY2
         wHSlCYfqoJFQgr3TFf9BFilS/WdVNp8ZKqHBomPcezXZNhMuSHyQSGIB+AEz99g4N2mc
         dxnQ==
X-Gm-Message-State: APjAAAXguf6R0o2oL6IcfITygWlDIKpziixYkbfimIzZgOMjrum8yu7S
        lPGhvzKcZxWHdo3sZ80FQIzWcsCNKHuLV9rBvCJ9Y7wnf1l4tLp9Wc+gL++fX9dqDjVKt/9g9vS
        qNl3pRh6NtqaiWrzeypRbyOry
X-Received: by 2002:ac8:1385:: with SMTP id h5mr4205466qtj.59.1575486443325;
        Wed, 04 Dec 2019 11:07:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLU0mdye3l7w56UCm9urWD6xnVdMRda/R8N73j8koZDC/cqy5mxzPws7nri9PIl8MC0d3yWA==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr4205424qtj.59.1575486443053;
        Wed, 04 Dec 2019 11:07:23 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y18sm4072126qtn.11.2019.12.04.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:07:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 0/6] KVM: X86: Cleanups on dest_mode and headers
Date:   Wed,  4 Dec 2019 14:07:15 -0500
Message-Id: <20191204190721.29480-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: 8-oRSS8oMvKvJNNz-aNKfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- rename param of ioapic_to_lapic_dest_mode to dest_mode_logical [Sean]
- in patch 5, also do s/short_hand/shorthand/ for kvm_apic_match_dest [Vita=
ly]
- one more r-b picked

v4:
- address all comments from Vitaly, adding r-bs properly
- added one more trivial patch:
  "KVM: X86: Conert the last users of "shorthand =3D 0" to use macros"

v3:
- address all the comments from both Vitaly and Sean
- since at it, added patches:
  "KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand"
  "KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK"

Each patch explains itself.

Please have a look, thanks.

Peter Xu (6):
  KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
  KVM: X86: Move irrelevant declarations out of ioapic.h
  KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode
  KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
  KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros
  KVM: X86: Conert the last users of "shorthand =3D 0" to use macros

 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/hyperv.c           |  1 +
 arch/x86/kvm/ioapic.c           | 24 +++++++++++++++---------
 arch/x86/kvm/ioapic.h           |  6 ------
 arch/x86/kvm/irq.h              |  3 +++
 arch/x86/kvm/irq_comm.c         | 12 +++++++-----
 arch/x86/kvm/lapic.c            |  9 +++------
 arch/x86/kvm/lapic.h            |  9 +++++----
 arch/x86/kvm/svm.c              |  4 ++--
 arch/x86/kvm/x86.c              |  4 ++--
 10 files changed, 43 insertions(+), 34 deletions(-)

--=20
2.21.0

