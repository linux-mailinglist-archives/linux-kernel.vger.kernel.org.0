Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A9843CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 07:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfHGFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 01:38:41 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:44448 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHGFii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:38:38 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x775cYpo059292
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 01:38:35 -0400
Received: by mail-lf1-f41.google.com with SMTP id j17so9032374lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:38:35 -0700 (PDT)
X-Gm-Message-State: APjAAAWgwneGhGtruqacsIsU6Q01h38tJyb1caQKc4JfrqciJyfsXEkZ
        ak+lBHvicNADDwn79lq+eh82V1qwAKPl1JMRv8o=
X-Google-Smtp-Source: APXvYqxn7QtGteg9YvLHOYoGnkl3CYUkFtn9ejBHDQojm0jJjJIbVpZPfk4ElTDYyWEwEe60vcFfHZndGWTZqq1jvOI=
X-Received: by 2002:a19:491d:: with SMTP id w29mr4833560lfa.149.1565156314615;
 Tue, 06 Aug 2019 22:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAa=b7ebEkQZhPCbJPK=dVC+cR8_pTE3OOxX+PV+MNx7-Y25Cw@mail.gmail.com>
 <s5hef1xo81o.wl-tiwai@suse.de>
In-Reply-To: <s5hef1xo81o.wl-tiwai@suse.de>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Wed, 7 Aug 2019 01:37:58 -0400
X-Gmail-Original-Message-ID: <CAAa=b7cOAONyFVd=s19d+00gb9_CtECP59ZR_sc6z4z=BOVjEA@mail.gmail.com>
Message-ID: <CAAa=b7cOAONyFVd=s19d+00gb9_CtECP59ZR_sc6z4z=BOVjEA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-midi: fix a memory leak bug
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 1:31 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 05:22:09 +0200,
> Wenwen Wang wrote:
> >
> > In __snd_usbmidi_create(), a MIDI streaming interface structure is
> > allocated through kzalloc() and the pointer is saved to 'umidi'. Later on,
> > the endpoint structures are created by invoking
> > snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints(),
> > depending on the type of the audio quirk type. However, if the creation
> > fails, the allocated 'umidi' is not deallocated, leading to a memory leak
> > bug.
> >
> > To fix the above issue, free 'umidi' before returning the error.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
>
> It's again a false-positive report.  The object is released
> automatically by the destructor of its base snd_rawmidi object.

Thanks for your response! Sorry for the false positives. :(

Wenwen
