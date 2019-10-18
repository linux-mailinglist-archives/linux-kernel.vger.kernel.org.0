Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDADDD0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634605AbfJRVM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 17:12:28 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36542 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394095AbfJRVM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:12:28 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so6799320ilb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bTakgz7LEZbnsJ6SfGZfkJdZLXTmdE5E7CAN0l9zGs=;
        b=OYrB4dw9gOsYCWo4syH/MFfrRmj7gjPcUk56pQPkSYzcnoehqVtqgxGyue5h2rJ/5q
         UrUGacNmUXkYVIz3VhI47mM5wM07gcYNzepR6WUplr9/++Xxel4iALzGaABMJyBOdA/z
         Siyyis/hQS0PCFgZjFpboDCeHAytZqXKyaK6qhr/kN72KeoU92BwxX6J1asfNIGfZ9oV
         vOyGL10KFrWxezdDaSPw7lcTMXKu90Mif3b4fxuiZt84YXbduxPV8cplAzOLJekLBjPQ
         bweDKonrJrnCjJxRUC9YKAH7VMD7pu77W+N5X93Mdhq2F8J3uXx4x8poH3sCyQ6J/O7v
         M/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bTakgz7LEZbnsJ6SfGZfkJdZLXTmdE5E7CAN0l9zGs=;
        b=lHFY4sks8xJIe8LJEPUeC90NA+Se2dGupf0LWEP9TOq8TBVarkDwZlVAXDNcw8O36e
         7rVi5NP6YwUNNkKoCX2wiFdHCKne03+upUbn8sX+KMceLsU3UQH+3a5wUBjMZDfBGq5a
         PaBBe6O8ZzFG3VAsmM19oRBaoaa2ez+2euYFw51m5EgsoFebI2P4Fl2aFP41m3VYwncQ
         bHAUGuAuBS4b5r1ikzE4xBAbX2FymEsUElfNmfmA4jH8vjShdK8/1Gy/Pg54vJrCWKkv
         kZoO8WEBVCVTkDTlRRcDrzy5Ixd6B1++sObg1LCc+6unyLfwTx262auIPKpmxW3O6JsS
         GoDw==
X-Gm-Message-State: APjAAAX9Nfb4Xq0CTZErwk1zbsRk26HVmFaFwvEl11xW5ecmwzkOTmaI
        cQPXMFoDIxl1fiui4fYtyyXnX0Ao1L7ovimVrFxuLw==
X-Google-Smtp-Source: APXvYqx4nWj+eAEbk35IMVkYUmMOK2BiEKPGwuO4Ri0S0ybvpc8yNzjzRZFXSETBp1i0VPTzCgZ1Kms4ugQwQcdPBaI=
X-Received: by 2002:a92:475a:: with SMTP id u87mr12844914ila.26.1571433147021;
 Fri, 18 Oct 2019 14:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <1501554327-3608-1-git-send-email-wanpeng.li@hotmail.com>
 <20170803134636.GG32403@flask> <CANRm+Cw9+zBrk24MZo5YSw4j2KxyRsuk+dh8QNT9q0orVo7egA@mail.gmail.com>
In-Reply-To: <CANRm+Cw9+zBrk24MZo5YSw4j2KxyRsuk+dh8QNT9q0orVo7egA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 18 Oct 2019 14:12:15 -0700
Message-ID: <CALMp9eTrhnWJpROGiCuR4TDHzW+CqRpBm4YV5hXQEdAbPN-fzw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: nVMX: Fix attempting to emulate "Acknowledge
 interrupt on exit" when there is no interrupt which L1 requires to inject to L2
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Dan Cross <dcross@google.com>, Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2017 at 6:23 PM Wanpeng Li <kernellwp@gmail.com> wrote:

> Thanks Radim. :) In addition, I will think more about it and figure
> out a finial solution.

Have you had any thoughts on a final solution? We're seeing incorrect
behavior with an L1 hypervisor running under qemu with "-machine
q35,kernel-irqchip=split", and I believe this may be the cause.

In particular, VMCS12 has ACK_INTERRUPT_ON_EXIT set, but L1 is seeing
an L2 exit for "external interrupt" with the VMCS12 VM-exit
interruption information cleared to 0.
