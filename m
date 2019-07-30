Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21437A674
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfG3LFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:05:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50993 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfG3LFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:05:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so56748880wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpNdRkCzqUyYffw/7lLTRM9HVMvkB3KarB7VEUzjUVQ=;
        b=HIgSlgxwKYg8e/J3SjxYaKZCVZh/e/MD2QdamQO42v9zxKGtnEu/HA0ntpZVF0zSv3
         5En9GIlM1eq9727UDqzefzKNiiJR4QyN0HxkFlk8u68kGAD0zT8f4Z7cDhNi5xT8niBr
         bCfIJUpo4Mr0i7SwnLjBwQHAguu1hnkWjiqcMgMzvCG+9fwk+XvN+eldY7vXr7ZrjKPK
         wivpb2Y0BFiu6WCcExmPqG113bMRW5MkuLn/arqPWmorJfY+wlqBvjTuzGSRIZvOhWBx
         6ZSN2uLXvKdxPD5MIHC9pC4ZEinP8IxAVwb7Kj2RpdTKkmZpnFTFDvKbjFb+hlihBE5t
         dicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpNdRkCzqUyYffw/7lLTRM9HVMvkB3KarB7VEUzjUVQ=;
        b=lh8gnB0IvETAaCTrzmvdIwkPycBZjUfs9R8Py2WTJ/2bpzPBiT2oEPi+F0nFuhW7yi
         z7s0dXpFtzUwxQUU1jDX0CKXzlQX3O7KdtUXEC44VP9zZ9toY+5QfrE9AIhYoO8MTkBC
         6kq8SW/fMPyUm3nnC9usk3hZa8HtfyIfrdYEHjD9KcvEX7LkcDPXs+diR5dO42rtPMQq
         SVUxTi015g9XQWJOQPRJYmeuEixCa5fl8rM/KLa3SN4rIYK96ekkqCF0pP1fpzPhGX0U
         IIhsIjzDMwuhAbBciq55n/0g6cXd06+fMdQIXCDpPhyrJOaqnqqi9nNSt6jZJ4uemuit
         3JdA==
X-Gm-Message-State: APjAAAXppPGlWimgMxTVw+URuKbS4rCmcTMtA7SJtmA7EtDQWAHC4olp
        SAJr6yb3yCqIaFvzA6MQMDrnhk2pGdX3Qi7iqAQ=
X-Google-Smtp-Source: APXvYqzVGcu6yOiKZfaeofC+j2ZPARkP3m25uM7rRFZC05JiebgCN4lGL6Gxd7aUZzaBrterPRwnFMHxEEVBhXH47Xo=
X-Received: by 2002:a1c:be05:: with SMTP id o5mr106351335wmf.52.1564484709021;
 Tue, 30 Jul 2019 04:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-4-anup.patel@wdc.com>
 <309b9fb3-9909-48d6-eabf-88356df4bb3b@redhat.com>
In-Reply-To: <309b9fb3-9909-48d6-eabf-88356df4bb3b@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 16:34:57 +0530
Message-ID: <CAAhSdy1x-sWfqtqaBhFzHjgsv5p68UUg0LTyOCEZ7sOVcO=okw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/16] RISC-V: Add initial skeletal KVM support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:53 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 13:56, Anup Patel wrote:
> > +     case KVM_CAP_DEVICE_CTRL:
> > +     case KVM_CAP_USER_MEMORY:
> > +     case KVM_CAP_SYNC_MMU:
>
> Technically KVM_CAP_SYNC_MMU should only be added after you add MMU
> notifiers.

Sure, I will move this case to MMU notifier patch.

Regards,
Anup
