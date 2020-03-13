Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9218184C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCMQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:22:49 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55463 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgCMQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:22:47 -0400
Received: by mail-wm1-f51.google.com with SMTP id 6so10647718wmi.5;
        Fri, 13 Mar 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyBmDCgZ8uYUx/tXy78bJ2J5Y1NhGOC7ce7yPgKrfvI=;
        b=GF8gv1FEwooSfzQKpStBbtBOdSqazE2H9nslRPWKIRHQGSfQJDjwZ+a9u28tCxukUR
         xA5Al4QanP8WDDY5hBBjHCgirulfY7CvDsOAvLf+/Yku72bcSjS0yauOP5BLh+6DHaMc
         VQ4BBrJ5K7JWGGigNmfR6StuPI+NZ0T9FT2vZOz4lTpgqfW1xD5QXoNU8xlG1yDitsVm
         ngJdofvxs5zJHiTeHVSabmzk/rqdNuxgFxT7CP2teeCzwdbZSrfvIAxbOsoJggudLpgd
         IlhsfBcg+NfEmF20KgdPxN1Is0x+CNWQlcX+zNeMznHdJ3wrJdBW8fFK3Qpc2+1Vh6F4
         vfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyBmDCgZ8uYUx/tXy78bJ2J5Y1NhGOC7ce7yPgKrfvI=;
        b=Gig1NMrost3ZJ0ubidpx7WZssHVRt/Mkabzhzo/KHV0Fy97aumQWdpdpBtc2LjMdlL
         aKqPRinXZPgxRl47h5MQM3aCA73C1QH51Xaagtm7FXQZmh5RPf6Oc7L8z0xqYOTxNEis
         Pjv86FWfFq5HfmVlJRRBvw2xvsEDH1OBbIL/O7oUN+3wdF/CSPP+J8AxTUIWhB55olCQ
         b5vRkbDmmKRQZxTVYoOOlu8yU1aBoXO94K6zdjjjc+8dfBVQKokN0H7NrAEjbxh9w2vc
         GLelrt2M/mGxfWi2giRhekBDpbfjhLBCCnX/1pLDdCgk/rKiDDd+A9DdFyLIMVH+2uqA
         ARmw==
X-Gm-Message-State: ANhLgQ1QwfyjVQktUhVTswUR4axu4WAuLQNeVGGE94TprxPCjKaPssIO
        EmWkB+mgicOmtnXD/TlDxcCNOzr/ZVWYLsV2IaljKO7mnL8=
X-Google-Smtp-Source: ADFU+vupxXWENSjqJudpb5FD1DcWZ65empCX4DOEyWuUXvChPHF/jZGByQes5gjjwlHItme0TP5nbZEtkAKJe73w6hY=
X-Received: by 2002:a1c:7209:: with SMTP id n9mr11457309wmc.188.1584116565313;
 Fri, 13 Mar 2020 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
In-Reply-To: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 13 Mar 2020 09:22:33 -0700
Message-ID: <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
Subject: Re: [RFE] Who's using a module?
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jessica +Steve +lkml

On Wed, Mar 11, 2020 at 6:33 AM Konstantin Kharlamov <hi-angel@yandex.ru> w=
rote:
>
> Once in a while there's a need to remove a module (for example because yo=
u rebuilt it, or to reload it with different parameters, or whatever=E2=80=
=A6). And then doing `rmmod modulename` and `modprobe -r modulename` gives:
>
>         rmmod: ERROR: Module modulename is in use
>
> If you're lucky, firing up `lsmod | grep modulename` will get you offende=
rs inside "used by" column. But often there's nothing except the count abov=
e zero. It is very easy to reproduce if you check `lsmod` output for your g=
raphics driver. I checked it on `i915` and `amdgpu`: when graphics session =
is opened you can't remove it and `lsmod` doesn't show who's using it.
>
> There's very popular and old question on SO=C2=B9 that at the moment has =
over 55k views, and the only answer that seem to work for people is insanel=
y big and convoluted; it is using a custom kernel driver and kernel tracing=
 capabilities. I guess this amount of research means: no, currently there's=
 no easy way to get who's using a module.
>
> It would be amazing if kernel has capability to figure out who's using a =
module.

Yeah, right now this would need some work on the kernel side to record
the callers of try_module_get()/__module_get()... usually done e.g on
fops-like structs in a owner field.
The only thing we have there right now is the trace. The trace is not
so bad since it can be added in the kernel command line, but would
usually only be enabled while debugging.

For implementing such a feature I think we would need to add/remove
module owner into the mod struct whenever we have a _get()/_put().
Maybe it's worth it, but it doesn't
come without overhead. I'd like to hear what other people think.

Thanks
Lucas De Marchi


>
> 1: https://stackoverflow.com/questions/448999/is-there-a-way-to-figure-ou=
t-what-is-using-a-linux-kernel-module
>
> P.S.: please, add me to CC when replying, I'm not subscribed to the list.



--
Lucas De Marchi
