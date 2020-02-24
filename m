Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D39169E15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 06:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXF6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 00:58:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41567 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:58:32 -0500
Received: by mail-io1-f65.google.com with SMTP id m25so9008700ioo.8;
        Sun, 23 Feb 2020 21:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ufJMM0QaLOMhL1j2geAiG59L13NPUluVWRQu2saPmA=;
        b=kjU2dmUQprPvO5BuHONcUrTw+r2bwi8N/4v6dpmlgf7PZlUjaOSy5i88yoTNx4VoDO
         T4bBH+XtDa3Ehnvlq0Q4HO+3JO2GGal8IteiOjHBSeEtohWaaDLBIPijc6GYQjE7VS/x
         ei4scHKsinbjiISvPp4i6Qk+koKe//0ASQ1ZgIeht3r3epOyIkZ226YGoY1oVu7qLa3y
         F5vkV5ni7op42bdBiN2GotTVtJzeASQB7jcVig4XYcKQpUQEbN47gNnXN8pU4oz75ZtM
         KIIsFAOlRjZIVSUXR3QH0WQyw6znD0vUY7kGMqkh9wZ0joCpDaHw3fMEbX/ktBFnIins
         /e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ufJMM0QaLOMhL1j2geAiG59L13NPUluVWRQu2saPmA=;
        b=WA6xfpI564J5OxUL93csayQ/NxGTIZrQblhuFpjQiDgbfszWcuySpZjy6/gChzc6Ah
         Cd9lgeUFdkBGFUdyr9cxXZ2BCWg+vsXVcrGFzkxvlOVW+INdVIirGE1ZTQiswDAYGLHw
         rEwhh6lxG1E6rZ+VmJSsaPWWrEIVLbx4aAJEwHltvqxOYnnSq3AiNuaUI0XXYXnhvD99
         tZ3Gx7qhrpEVMkFqwGkSJ3hIYyIhv43/76gMgfietbeft5hcOTniBVidXCx1DdMMV/vl
         1ZCDDOTk+EPOzxOLQiZ0Xhdkt1nx8fmPlgRQY8kCF2bR0pqFegQCXn4NHHGz4JYHc6LS
         EMUQ==
X-Gm-Message-State: APjAAAVvCHHB923wcXCo0GX1RTaH9CLu9mxMdkPiV7rwy3T71LVCNyO6
        t5nx+M5HDJpY/eY0TwknK0wV1oWrYwpeHVmx5MY=
X-Google-Smtp-Source: APXvYqzKexOhclDi2/RZ4ID7g8MfwAu7yEfMxwHnYyNLNkqkCMxWF9NUshT2rIjgYTMdr3rdEl4ttpI36enUo59JfQA=
X-Received: by 2002:a6b:cd0e:: with SMTP id d14mr47185867iog.272.1582523911931;
 Sun, 23 Feb 2020 21:58:31 -0800 (PST)
MIME-Version: 1.0
References: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com> <87eeuo5a2y.fsf@suse.com>
In-Reply-To: <87eeuo5a2y.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 23 Feb 2020 23:58:21 -0600
Message-ID: <CAH2r5mtvkVk4RiZB2pu5aymv0mv-ioV8jc4mhwuF4c3XRpxhJQ@mail.gmail.com>
Subject: Re: [trivial PATCH] cifs: Use #define in cifs_dbg
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     Joe Perches <joe@perches.com>, Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like a plausible debug (VFS not FYI) msg.   If delete is not
pending, it is a little strange if nlink is 0. merged into
cifs-2.6.git for-next


On Fri, Feb 21, 2020 at 7:46 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> Joe Perches <joe@perches.com> writes:
> > +                     cifs_dbg(VFS, "bogus file nlink value %u\n",
> > +                              fattr->cf_nlink);
>
> Good catch :)
> I realize that 1 is VFS but this should probably be FYI.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)



--=20
Thanks,

Steve
