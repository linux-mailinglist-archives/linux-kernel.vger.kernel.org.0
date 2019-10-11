Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1624ED4550
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfJKQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:23:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33996 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfJKQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:23:54 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so22808134ion.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYuysNNB34vzaF6MUbQvV/mVL9SXPUEqaT1Ho11Jg/o=;
        b=bXLzmGiSuLTMLfidfkYS1vUnwNdxVd+km70RJnz+dqfAgjauBU0zjA5JdvIEMyewI7
         wqlyR1rTaqbMzOsgbo6n0JE7XkxMcewbuecc6rc508ooaF55A1YWHILeasK8Kaa20ifS
         sT0Hu+s1h7+SCghDzdc7Kob+ust+/WzCJ8Ylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYuysNNB34vzaF6MUbQvV/mVL9SXPUEqaT1Ho11Jg/o=;
        b=f86Y2dIEaNG2lYA6kkoOLDrCPGtnSLXZKvxkSlSVIqir0DJlf1YMiIiShMxn35rw53
         Io0bHo1B4kl2XDwHNO4rk7JKtv4I52qO6SuquXBk85EIGKfcsKUOdjXOUj0yUJ2rh/oZ
         vKpYyaMLEuj7jzyvpa1r/Mh0dxrgTxIewPQlApBST2Nf3j5J6r7hsIhCrT3WI3Gn1CsU
         bVbiUBgA4Tuy+cSooPhXt9EPhxmEUSVt5RdKU/KQZ0HbYifWh4WexlpLeCW9UsH7i9ZB
         kXtmGLaHJ/dsQR48xpNbcs6mxtwVEhjdW7RFuefo1F0X6407Tu61DQuXiP9m9jySlwjP
         pItQ==
X-Gm-Message-State: APjAAAX6kzEaB4NBTnFD+UrwJVODKBWLCa0v4aX4yreDa2JNNEKtcbFe
        nJ1xHbjDHYQfNtiOCDVbdyIFmnZv8HqL7LRSYxkWU9Fk19fkwg==
X-Google-Smtp-Source: APXvYqwfcGD54cIT9+Q2+eIt3no1gPcfadM8IUYxCwOoMfEbn2W16jOyYXGVfRaoYHemabxkQdGpwocdLQxC6tsx0l8=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr18457775iod.263.1570811031794;
 Fri, 11 Oct 2019 09:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.352.1910102033050.30236@trent.utfs.org> <20191011100018.0e9fff37@lwn.net>
In-Reply-To: <20191011100018.0e9fff37@lwn.net>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 11 Oct 2019 09:23:40 -0700
Message-ID: <CAJ-EccOz+DeC=y1ToBhq2F-sos0g+_6iWK8vjXgxuENGsn7Few@mail.gmail.com>
Subject: Re: [TYPO] SafeSetID.rst: Remove spurious '???' characters
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Kujau <lists@nerdbynature.de>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, thanks for this. We had this fixed in
http://kernsec.org/pipermail/linux-security-module-archive/2019-May/013525.html,
but looks like it got forgotten somehow.

On Fri, Oct 11, 2019 at 9:00 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Thu, 10 Oct 2019 20:36:16 -0700 (PDT)
> Christian Kujau <lists@nerdbynature.de> wrote:
>
> > While reading SafeSetID.rst I stumbled across those things. This patch
> > removes these spurious '???' characters.
> >
> > Signed-off-by: Christian Kujau <lists@nerdbynature.de>
>
> I've applied this, thanks.  I did take the liberty of rewriting the
> changelog to adhere to normal standards:
>
> Author: Christian Kujau <lists@nerdbynature.de>
> Date:   Thu Oct 10 20:36:16 2019 -0700
>
>     docs: SafeSetID.rst: Remove spurious '???' characters
>
>     It appears that some smart quotes were changed to "???" by even smarter
>     software; change them to the dumb but legible variety.
>
>     Signed-off-by: Christian Kujau <lists@nerdbynature.de>
>     Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>
> Thanks,
>
> jon
