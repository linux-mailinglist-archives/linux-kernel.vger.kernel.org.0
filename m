Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBA16C38C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgBYONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 09:13:14 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:45715 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgBYONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:13:14 -0500
Received: by mail-lj1-f181.google.com with SMTP id e18so14171216ljn.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1gtW27emNxhkEvoW7LMTQPRK73zPNYulw9W2zBEvQc=;
        b=dwp3pAkCzhSX1gkv3YsyzMnUWM/SPW8vV5s/wgkDGcp+1NUaSRisLLfUhR3tE09rpy
         Emy1v90yhBNH8sDG1yPDhDr4xD5Y1lxJDAaw+JR0iTwxewE1Uuacunxv5Lqa83BO1jtS
         cX7769lwR0HJGV3deo8cw2RtiZYJ7BiwOFC7VHpLt/vDuEpEzYH/Rbi4CqG6zcdaDG14
         8fMMBHW4MEdBDycMTYh+8jsR0LByNTdD0By2Bslw9bFaM5oafxgfISZDzE55kNVbhgr6
         jMLi4EZtyx0FV/OpQngVFsELNUHk4x24kvqfR0oki7T+wkg+6qFgbcN/MYy7DypUWw8a
         MM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1gtW27emNxhkEvoW7LMTQPRK73zPNYulw9W2zBEvQc=;
        b=bZeUUn+hm1PB/AsPCZyR9x22sHT7vEnumGbRt5+BcaSSYHd+L1o6RFXOw9qXPOP2Z8
         2jldsTa+Bxg2Lu/isnvoILStcNjsRDX7XQXcI0eXJ1wghWzZT4y5UACPanBYs45QS9xx
         48NqafMT5KVpE1cdZvMdjCJSM0HgI4lPNWVPe0pPwV8kh3PPspvM+NP/3EDP1nPeVzX/
         en2TBkG5h5nInMJgc5vOUdRvPWxeNQ4fTrczHOb6tjSi1BBh2Ms0UqmzA1jLa6Krvvme
         decxG+0S/nQmfhYhUJzordA4wp7kAgdrxbqwkWhxnpLpBdB1TFNhHPiuTIVfATntJiWo
         D76g==
X-Gm-Message-State: APjAAAXn8dq5GcIBKMiBAia2yCceI3RIqUJO1ghXm0GaEIz9dodPZSGL
        TePcecUnxwx2qShZcgH0FrNuM6HJiPihBBCR+w==
X-Google-Smtp-Source: APXvYqxpmeZxilBsQaSE1pz6nIz3r89uH24bf28gGJt0sae5gDIhMklsuh11C699CzhVDk4OoGhc/1E3MeQUGCz3fYE=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr10477341lja.81.1582639990685;
 Tue, 25 Feb 2020 06:13:10 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
 <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com>
 <158257881650.26598.5580907010251811605@skylake-alporthouse-com> <CAPM=9twmxKz97jMNjMq7U47tZ_3QiZp73EZrcwrYuwLhApcx4Q@mail.gmail.com>
In-Reply-To: <CAPM=9twmxKz97jMNjMq7U47tZ_3QiZp73EZrcwrYuwLhApcx4Q@mail.gmail.com>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Tue, 25 Feb 2020 15:12:59 +0100
Message-ID: <CADDKRnC-V_WhaJH8KZiiXH6Lomk=9vH1izxZ2X5kicHvS2zhiA@mail.gmail.com>
Subject: Re: i915 GPU-hang regression in v5.6-rcx
To:     Dave Airlie <airlied@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 25. Feb. 2020 um 04:33 Uhr schrieb Dave Airlie <airlied@gmail.com>:
>
> On Tue, 25 Feb 2020 at 07:13, Chris Wilson <chris@chris-wilson.co.uk> wro=
te:
> >
> > Quoting Linus Torvalds (2020-02-24 20:18:03)
> > > Let's add in some of the i915 people and list.
> >
> > Haswell eating kittens. The offending patch will be rolled back shortly=
.
> > -Chris
>
> https://patchwork.freedesktop.org/patch/354775/
>
> is the patch that is working it's way through the system.
>
> Dave.

With this patch I get no more hanging GPU.  Looks very good for me.

Thanks, J=C3=B6rg
