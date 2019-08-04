Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6880B79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfHDPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 11:33:41 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35499 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 11:33:40 -0400
Received: by mail-wm1-f54.google.com with SMTP id l2so70720215wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk19a8ASSSuM2jwkYX8J+fNwcj1AwTJ0k8cjspc7200=;
        b=j/Zi/XWi2Uti7Oso7ikT1HeCqSfgOfac4TeCpqjIZbiNrIsr0SOaPzQY6WRHTvZ+iL
         09Quurysk4OGq8Bc5EXXEKXveCnZXDErr3W4tok/IENV+KbJHtuKNchg/FmjdpChtcYD
         LSwlOhHrtCmpj6/py4lce4Qflu2rkNLgzZSohGpNTBEHvJE5lH61ViGVOn2zDc8l7PM6
         P7VxelBFkSmlB/iIjUEufIuDWTgzsRfnYgYxAEN0KNLu5h+zveBkvl6GTh77zlEJv+xL
         mH5YKDzPz+Cp+QrZdLGK2VcZg3O+sZOOkYBb3ySwX3etCFnpwoXBIW0EpCThroOSCxxb
         l4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk19a8ASSSuM2jwkYX8J+fNwcj1AwTJ0k8cjspc7200=;
        b=Nuv004/qhXck9GPsnuqO368UIviAGGfI/itezR+kLrwRxcA+fexQ7WQsErdZSZyw/m
         L+UdDE16KUt70UyuZlEDB/QS8iMW4CywKnCNLhsRcPVqMQt9QdaulbFlE/Z6fvEJNtdt
         CR/oOTndwcCRWOZbWAI9ogBZQdEuy0EBBZD3pd67ga6RN8wlNQNK8MADG7+LKrqRCzgG
         Rm502yycSq7lucZJlraes2UoNFWA/SC2bwDM+rcJ5ZdLHjKbE83jKaaiL+6WThCF67dE
         v95xZ40M+1DFVm27hzMcm6EunfS+FGe5oPMP4ejibGmNrE1hmAglwsUePIM5awuRR/mv
         C9RA==
X-Gm-Message-State: APjAAAVe7/I1+hymCnV/vIe4sGMnBJpUm2Q+iiVIME+F04icMRtMKDfa
        gROP0HyxmnKNjmPawfwKNzMYBaTKFjYjpdPHJTWywA==
X-Google-Smtp-Source: APXvYqwHIKZmLphHkdsru2/VzVTiiRCgoM1Cn/yg/n6Mj2Ykp2NVcKNPCSBJ0ugtQOjwMBGJFQfmqDNEV8Zf57gScXU=
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr13055824wmj.61.1564932818430;
 Sun, 04 Aug 2019 08:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
In-Reply-To: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 4 Aug 2019 18:33:26 +0300
Message-ID: <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
> tablet I noticed that it does not boot on this device.
>
> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
> events from the final event log in the TCG2 log")
>
> And I can confirm that reverting just that single commit makes
> the TW90 boot again.
>
> This machine uses AptIO firmware with base component versions
> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
> a Teclast X80 Pro which is also CHT based and also uses AptIO
> firmware with the same base components. But it does not reproduce
> there. Neither does the problem reproduce on a CHT tablet using
> InsideH20 based firmware.
>
> Note that these devices have a software/firmware TPM-2.0
> implementation, they do not have an actual TPM chip.
>
> Comparing TPM firmware setting between the 2 AptIO based
> tablets the settings are identical, but the troublesome
> TW90 does have some more setting then the X80, it has
> the following settings which are not shown on the X80:
>
> Active PCR banks:           SHA-1         (read only)
> Available PCR banks:        SHA-1,SHA256  (read only)
> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
>
> I have the feeling that at least the first 2 indicate that
> the previous win10 installation has actually used the
> TPM, where as on the X80 the TPM is uninitialized.
> Note this is just a hunch I could be completely wrong.
>
> I would be happy to run any commands to try and debug this
> or to build a kernel with some patches to gather more info.
>
> Note any kernel patches to printk some debug stuff need
> to be based on 5.3 with 166a2809d65b reverted, without that
> reverted the device will not boot, and thus I cannot collect
> logs without it reverted.
>

Are you booting a 64-bit kernel on 32-bit firmware?
