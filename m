Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE9102D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 21:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKSUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 15:02:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42451 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:02:57 -0500
Received: by mail-io1-f65.google.com with SMTP id k13so24698291ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MFMy3LYEEEj2WKJnpUWE+LjcS6ExOPNWRw+rJNdpsw=;
        b=JYv+QpU9RCzMu4YGwNE4IB0XYB/RP0EfJKAEMlntSqLQq0E82KlEQZrkDlKAwaPWxO
         Mz3OAm3f9ta1eO7exD485mQX3lGz5rHLeAT8cN+BTsjYU5wya780Zo7pqtfw57oRCcHl
         F0LaIouXgLin+x60Mlr22jmfr/arSOJQTkH3ou2RSqPdu3pI8ahGiJol1Kwxy2n4Q8TJ
         2bhyhfsxi/F1u/6O08noh3aY8u4m0tUMe6LZEv39C/0DZjrp7xCtZjN45LzNozF2Wk57
         yT2Xx5pIwyoPvTSjNHHHnZEdoelW4/R3Amc1OH6u38evpSpQg7JiLNwbr2HLckMYr1YE
         +4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MFMy3LYEEEj2WKJnpUWE+LjcS6ExOPNWRw+rJNdpsw=;
        b=dyq1MBvkZyD+YPDRqSLQRL5kIf3M00KuKvOj2O/rWxVkqP7euO2R+9E9A/TnOis3V8
         IETVgq3Xps3qzmIBo5zRh9eXQgfHuryyMEC2g56GzTt2StxD4/XIPDplqUio/U1yZ4OG
         9ICcIjZSHt/QjnFwMFB2h5Tg5Z2+3N07Oqd/JsXfH6nU6ENmD3iJ6L8UZ84vk0flO8ZN
         m4JGlkyzXBNItNqS/+FHAFxDDTKy85Wo2Pba0u1QeQ63CYkgEaDQRT1Dn+yMyXaCrcXu
         irSSkd50dKQD8Ebln32RBBRoS7dfofoEALQ6hwou5MTHBDZVfyexL64Z/QGR18vMyS1M
         ztxg==
X-Gm-Message-State: APjAAAVY1udzX2W/v6iDkIfMdqdiF3/6LI+nyhG9n32dC5Q8VpAlhOWW
        UAJgz5Bxi8+QDcnKAE1dMJBnOmhxEscnweAT4NBrhnIb
X-Google-Smtp-Source: APXvYqxyqKJGCaiQS2Qc1Xu3XQTsFmFp5Qs3VRSx5jry5cnEcT5RLvshAfvWelgmhFGgWO/EUGEbOJzXdX0WJfIkJbA=
X-Received: by 2002:a6b:e016:: with SMTP id z22mr12580177iog.296.1574193776044;
 Tue, 19 Nov 2019 12:02:56 -0800 (PST)
MIME-Version: 1.0
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com> <1574101067-5638-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574101067-5638-4-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 19 Nov 2019 12:02:44 -0800
Message-ID: <CALMp9eQb5i99ML_gkbgebXP7CNmvmu4hOdmzfrti-5cpJwknVw@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: x86: implement MSR_IA32_TSX_CTRL effect on CPUID
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Because KVM always emulates CPUID, the CPUID clear bit
> (bit 1) of MSR_IA32_TSX_CTRL must be emulated "manually"
> by the hypervisor when performing said emulation.
>
> Right now neither kvm-intel.ko nor kvm-amd.ko implement
> MSR_IA32_TSX_CTRL but this will change in the next patch.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
