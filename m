Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A131920
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgAFURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:17:14 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36728 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:17:13 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so43661710iln.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxvwhJJ0uR0l3XlAR6Ya25i11ON7evDplvpGhKU4LZo=;
        b=NCc+tSWRs4DoBDCc2IweeZQ/X1n5EKwZ4hA9koLfWxjBZi0elUS+ckWbY4YxEZ/bKF
         TXE53YiO1FSF9lxsO+D5SpWLwFhJaGbfG3I6y6ihNxGuRDsByIXHBwnp8VQZV10ZrYPF
         JNGgY6LQXJIW9WYui/HJtuXmqAPzvTIQB2/jI6eL/AnfoMsSWPhErI4X4rEckqjVUsVC
         BmSRf7yOcomjqmZlfdK8Ly8fMnlt0H1ufQBoGYiQu6LH8gP4qT1rEOGiuDNVlwxfPqfq
         LN06g7d6u+1ivjvWNtPZFoSvydyU2MyCUuE4XXrUI4dTImUMwmh4/R+JkHYtefn12tCP
         CkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxvwhJJ0uR0l3XlAR6Ya25i11ON7evDplvpGhKU4LZo=;
        b=kksvax7G6xSONgPx4vfKAnh70bAjaCKzWY6CObMsuVnYt3vTg8Q2QwL2+oElEuYVSO
         FJGJ5Zo8KcoNnRNefeziTBItm3AYwpdkrRsr+1jruyQ/QCI8s5gRbeZb1eYHjPVuKd0L
         aZpysFXAf48zcHRPCa5E4mXNptgYxD75N2/YijmSdEQ2JpRth7yUKpm9wT4dboKIPDue
         XAr3CLr5aSbdPQuFrDARVnbiMQgvE9K4J7aADh4u1/kbBUUw6GW7CjXnPHcIoGJPsP4t
         yxkjgIxQqFl6RDg3MP8VRMxDWR6o0OmC+Qr4X1NR+Le6XdYBpJqChshQf8Y9KAMUAgMM
         ABTQ==
X-Gm-Message-State: APjAAAXY9cG2i/F/isZ3tavXI126DZfUsMZd9PGYTtqX3Nmr/Ae2RUOQ
        RarPGcWb6tHjnSJ8GWm5GYPAV60i48vXdHOpX2Q8/Q==
X-Google-Smtp-Source: APXvYqz+I+w1AKAX4I685EkhXLV0JGNj7Ig7L3KcjNLDo2lQBjrY4YdOG2hhx8MIKccUvvq8iyzLWgCunGxYEoz2vTI=
X-Received: by 2002:a05:6e02:8eb:: with SMTP id n11mr89886746ilt.26.1578341832825;
 Mon, 06 Jan 2020 12:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-4-pomonis@google.com>
In-Reply-To: <20191211204753.242298-4-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:17:01 -0800
Message-ID: <CALMp9eRVZpUMacu38Kpp5iQoSP=3Pcy3WQBO+wm9wDBpSmqSbg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] KVM: x86: Refactor picdev_write() to prevent
 Spectre-v1/L1TF attacks
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:48 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in picdev_write().
> It replaces index computations based on the (attacked-controlled) port
> number with constants through a minor refactoring.
>
> Fixes: commit 85f455f7ddbe ("KVM: Add support for in-kernel PIC emulation")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
