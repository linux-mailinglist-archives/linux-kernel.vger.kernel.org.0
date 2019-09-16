Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCAB3EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfIPQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 12:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfIPQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:23:03 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 988E7B2DC4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:23:02 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id t185so2320wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDgjsWSDn6xBrhx6U+9m9Eu+qyYKBG2MdOtlO9XcnZA=;
        b=aR/jng09Vx+d6e2zO2KSeAtBHf37eG/4PQsuCxbdUeq1IfUBCjzZtAaDLc6+6n8hL9
         YiXpanIxNcOPJUs5TKlxjyGb7bKyrNQQjb0FuzVZrQtxcWV0suL5cM8NvtV75RtN2Cqu
         Q1yPSQaR12eVLJXWpMKaiKnoZTxhM4VeikAg5s2orwVlsb4u0Cj3KoHDCM+bG/hs0w/V
         xrKtbAMIgQdfZ1jtM7A/ql31dnsjI4iBL8j1ZJ3pS5FzkENeDycta0tPdX5sQ9D4wirN
         jSWKttetMKDl5GWMYzbaBEoVuCFxNesGGUCqZQL//C4zDgSxD68Ttfssw/arEM9lcEBj
         EM/w==
X-Gm-Message-State: APjAAAUBoChlowe/VUfFvJnYflFE7VDcvCAPzUx+Z8eOIyfOcd5axh4g
        8LDnQJzRdyix7b1kTTJkVhPtRCT1ThSuxCqbeHIq7Jn/dsRrFhKfyiCARAXaMB54I3bj5NJVYbb
        ldYIjsPhsbPsy/4vY9WSJDHcF
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr42852wmd.36.1568650981047;
        Mon, 16 Sep 2019 09:23:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHalXeJGi+RCuzUK9rmpW00UqDDt5f6sreleDyRFkD/UPh7GhVb0E++elsWy8IafgPDqQgOA==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr42826wmd.36.1568650980794;
        Mon, 16 Sep 2019 09:23:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm78370575wrd.39.2019.09.16.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:22:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 0/3] KVM: x86: hyper-v: make L2 Hyper-V 2019 on KVM guests see MD_CLEAR
Date:   Mon, 16 Sep 2019 18:22:55 +0200
Message-Id: <20190916162258.6528-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[The series is KVM specific but the first patch of the series likely requires
 someone else's ACK. hyperv-tlfs.h gets a small addition too.]

It was discovered that L2 guests on Hyper-V 2019 on KVM don't see MD_CLEAR
bit (and thus think they're MDS vulnerable) even when it is present on the
host. Turns out, Hyper-V is filtering it out because it is not sure the
topology L0 is exposing is trustworthy and generally it is not. In some
specific cases (e.g. when SMT is unsupported or forcesully disabled) it is
and we can tell this to userspace hoping that it'll pass this info to L1.
See PATCH2 of the series for additional details.

The series can be tested with QEMU-4.1+ and 'hv-passthrough' CPU flag.

Vitaly Kuznetsov (3):
  cpu/SMT: create and export cpu_smt_possible()
  KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing CPUID bit when
    SMT is impossible
  KVM: selftests: hyperv_cpuid: add check for
    NoNonArchitecturalCoreSharing bit

 arch/x86/include/asm/hyperv-tlfs.h            |  7 +++++
 arch/x86/kvm/hyperv.c                         |  4 ++-
 include/linux/cpu.h                           |  2 ++
 kernel/cpu.c                                  | 11 ++++++--
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 27 +++++++++++++++++++
 5 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.20.1

