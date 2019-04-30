Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37CFFB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfD3O0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:26:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41547 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfD3O0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:26:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id v23so11224127oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/LjxNq7HqcE4VRT2agDFK9XNaV7Csanx3gBGZ037XE=;
        b=vIhSjwu1EAwHvUvrgR1nv0zrga9vDgMtL3meLUWVuexpKUwIJIk3nESWdlRqmdMePc
         tCnp96IPqjvgL9aisKHK6CmTFk8CKiXwBDoEo+dIoC1FooKZ7aP0x92I4Bd0R7zuj9Ic
         CT1i027kpsFWtI/r1URiu9ZUh4H7dFJmf7Bw9ME9rUA7jitm+M79CiDcrS9s9eP8zfJY
         AQInHKnvqTwnw0UUpegLr4PqQGwsfe3cJ6Ze7K5VGMQgoYzl5ilDqXphA+6U7sor/Uh3
         2p+k9Azj+OWb9m0vYs9lo8nHyDyjrWg++OUuKaXN2SCo10G+yvtmXPzfio5MSccMYZcO
         G5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/LjxNq7HqcE4VRT2agDFK9XNaV7Csanx3gBGZ037XE=;
        b=cdJmSyAM7i8EXOlRgQBAXxuSYCH40rmYDh/37NnAj6qdG+cwzL7m6+ocuFrE3xkAO1
         Y0g+AMc0SqX508RYmotsV/aCCcfHupH1YL07P1fuEDgnMGwbjwOjgO0fRs8X/UiIoTmV
         MHxU9KlI9tg6hgE2hKSiO+Fqx4ADYRSun6IX6LYRTa0wPboouV1q2gVmMJrr6r4eK52V
         K2Cop59vskIp+3OS/lb/LhWNNy0Yu7SNFoxwUsWoR1J8s+YcUhyWHrnBUiFGufCqqLZ8
         sjCYJrROAQL5I+GNXYh7UBIH1T6w3mIpa1ccgkrSQe6i3DE4fKSSbfj3/a3HLIg6P0ge
         QeEQ==
X-Gm-Message-State: APjAAAXDhCBOrPh+6fyqUv2FmDeruhIq5XKyWgaQPyg3ZUKPVE/soLM/
        UDgyNn5ffnU1sgdQ/ihvrtXC1yJqzpAC95qiJKc=
X-Google-Smtp-Source: APXvYqyD26sEQFKVWSiVTMpA63i6t1Tph2LypIrP3KSbj45dx+ti8S7azt58i5F8S8PaJ767U/zMlGxSu0qbgVRvCQ4=
X-Received: by 2002:aca:4202:: with SMTP id p2mr2912687oia.169.1556634404727;
 Tue, 30 Apr 2019 07:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at> <20190430030223.GE23075@ZenIV.linux.org.uk>
 <20190430033310.GB23144@osadl.at> <20190430041934.GI23075@ZenIV.linux.org.uk>
 <CAGngYiVSg86X+jD+hgwwrOYX82Fu3OWSLygwGFzyc9wYq6AesQ@mail.gmail.com>
 <20190430140339.GA18986@kroah.com> <CAGngYiXbSBuce2HmbHH4kUbe2ShgheML=bp+AJ-3O+FE+37ZRw@mail.gmail.com>
In-Reply-To: <CAGngYiXbSBuce2HmbHH4kUbe2ShgheML=bp+AJ-3O+FE+37ZRw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 30 Apr 2019 10:26:33 -0400
Message-ID: <CAGngYiUfYxAaTRDc9HyWjcnuCHmosK=OqeV-nptRGgo=95GuBg@mail.gmail.com>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes annotation
To:     Nicholas Mc Guire <der.herr@hofr.at>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:22 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Ah ok, it's like a standard way of implementing a bus. Sounds good, I'll
> spin a patch to conform to it. And while I'm at it, I'll rename fieldbus_type
> because it can be confused with another fieldbus_type within the
> fieldbus_dev core.

Nicholas, this future patch will silence sparse. So you can drop the
patch you proposed at the beginning of this email thread.

Thanks for your help, really appreciate it.
Sven
