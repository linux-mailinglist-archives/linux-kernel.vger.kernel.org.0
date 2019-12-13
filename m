Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773FC11E2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLMLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 06:22:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725937AbfLMLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576236140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxxAu2RAYAk9sdBPJuCvdYozDj3FKu5CoGp/NR/X1cA=;
        b=iGOHXm68ASaVKV8vZlZVPwsM84E4Y2rbdlLtnHkt3LU752V/EfJjnMIoh6OOLB0IPApEM9
        ZWSOlistFT5WxQQ6iTjqVMet4eTUxXWW3darlTWDllP1kcm3uwu88YazKfqucA/CKNeOMw
        sDD5TcH997lrkpk3oe58H7xSS98a1TA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-cYxRFOkaM9-7GvBSas-QWQ-1; Fri, 13 Dec 2019 06:22:19 -0500
X-MC-Unique: cYxRFOkaM9-7GvBSas-QWQ-1
Received: by mail-qk1-f200.google.com with SMTP id f22so1207506qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 03:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxxAu2RAYAk9sdBPJuCvdYozDj3FKu5CoGp/NR/X1cA=;
        b=VisswHR2b8D/rPUh2ie7Q/kyuf2K9NmefPA960lOK3Fu2R6XOo1l37QUX1xfKeDvOS
         No9hemC72WsWtT8BomeMUlOtQRufc6rePSxkHU/P0OiiQlL1dk1xQluJnYIdhoLXijyZ
         NZ5ULGMsssPjDd9SW73LGVimzweXD1NefVcEhuunyR8lCYP8y/r+u5+DEqqaQ6is62zc
         V2UfYBPX/1Jascqs+G/X2R4fluItq9hR3L/rjETJt95UPtQWai4W33UsqBeFLZxZ7K3+
         rj4KL7R20TeSmZV7RqAAmNLcqeHU4IT87x1IvGgw8ypPkaExKTA9EJb1sHryeuaO4Noz
         4ywA==
X-Gm-Message-State: APjAAAVjM9Wo/MJvxp+anDgrbSz6KSQJteiFOWhzngKr/Bi35vXdpPiz
        qJ9Bs6Xht1OEL2kLoO8Rstc2NAF9JzIAp7GcsfF9zop8ckevuKlhHWvaiUd+3UFBuWlj3n7o9lW
        y8kz30BKmCJFmD/Xyp0nbT3sGaSxv2ammYfGKdORZ
X-Received: by 2002:a37:a086:: with SMTP id j128mr12498615qke.459.1576236138830;
        Fri, 13 Dec 2019 03:22:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAYPudOqMi80avGrAsnU5YfbLoBVwBc0pNQRaO2mn3aYj0+EkSoGgcWI4VsISAktipjG4JSgnszMgG5O/OhVs=
X-Received: by 2002:a37:a086:: with SMTP id j128mr12498591qke.459.1576236138574;
 Fri, 13 Dec 2019 03:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20191207210518.GA181006@dtor-ws> <nycvar.YFH.7.76.1912131027560.4603@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1912131027560.4603@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 13 Dec 2019 12:22:07 +0100
Message-ID: <CAO-hwJ+8gwm28DTx2Lw8Gj+eTbOa8kVoFbc0tpqFtyu8+WOA8w@mail.gmail.com>
Subject: Re: [PATCH v2] HID: hid-input: clear unmapped usages
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 13, 2019 at 10:28 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 7 Dec 2019, Dmitry Torokhov wrote:
>
> > We should not be leaving half-mapped usages with potentially invalid
> > keycodes, as that may confuse hidinput_find_key() when the key is located
> > by index, which may end up feeding way too large keycode into the VT
> > keyboard handler and cause OOB write there:
> >
> > BUG: KASAN: global-out-of-bounds in clear_bit include/asm-generic/bitops-instrumented.h:56 [inline]
> > BUG: KASAN: global-out-of-bounds in kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
> > BUG: KASAN: global-out-of-bounds in kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
> > Write of size 8 at addr ffffffff89a1b2d8 by task syz-executor108/1722
> > ...
> >  kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
> >  kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
> >  input_to_handler+0x3b6/0x4c0 drivers/input/input.c:118
> >  input_pass_values.part.0+0x2e3/0x720 drivers/input/input.c:145
> >  input_pass_values drivers/input/input.c:949 [inline]
> >  input_set_keycode+0x290/0x320 drivers/input/input.c:954
> >  evdev_handle_set_keycode_v2+0xc4/0x120 drivers/input/evdev.c:882
> >  evdev_do_ioctl drivers/input/evdev.c:1150 [inline]
> >
> > Reported-by: syzbot+19340dff067c2d3835c0@syzkaller.appspotmail.com
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > v2: fixed up interaction with hid-multitouch according to Benjamin's
> > feedback
> >
> > Please consider tagging for stable.
>
> I'd like to push this for 5.5 (and tag for stable), but would prefer this
> to have gone through the full battery of Benjamin's testing infrastructure
> first.
>
> Benjamin, did you have chance to run Dmitry's patch through your
> machinery?

yep, this one was OK, so:
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

