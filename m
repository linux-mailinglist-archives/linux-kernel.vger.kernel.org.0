Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115DF1039D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfKTMQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:16:15 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:44219 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfKTMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:16:14 -0500
IronPort-SDR: Vmuk84dVRqlMwN2RIF+Ga23pD2ZiIh0jqX7eUJhZrRpDlhLO6eEgT7FFIXzMr+FEMZdHcNn8Oc
 fYq9ctRpYBYOmU5PfvUf56DmEhXojYNY4QwLmimG7OxoBZcbOhA11YXrr9e+taWOwPugFNNte6
 wpHh2RqkI38hRQiCToicY5pOBIac+CRyCTpGs72DNeRxbF/cdIt17e0UEHNfpPUu9KuzF8gulq
 Mo3ykh/xjTQ5QGIr7QWlCYTSVxJJn3zaKntHG3XYe9ws6kTtpP1eZoKRNgsvv0FZUnP7xiX/mm
 US0=
X-IronPort-AV: E=Sophos;i="5.69,221,1571731200"; 
   d="scan'208";a="43350275"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 20 Nov 2019 04:16:13 -0800
IronPort-SDR: 1moC0hKuD1NbbRb8xhHVukNosiGHF7TfOPI+xQXvyxq6dFFmxwEFbXMKVHWLO7Ngof2/zD/f/T
 Yiw3oyFAlYr/ZSgM6PaBw733VapuF3Fnh4vF7wx/xFMlVsS3u3JbFuly0mwoMxjBIhcZ0YXm9I
 7HX0LquA6ARFkPd4y1PdA/D2BF39bT8s9CE6hUvczUH83jp/kS/F2R7X7+QMJgkBK1h4TmbUvS
 hobFOkTmEC9lLZcutQWJJZP60MEV3Z3fR48ZF4B6ybonmFwdgYYSSSJNV6oAzEQsG0ZnDjA9eK
 B+k=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com> <s5h36eql6xq.wl-tiwai@suse.de>
In-Reply-To: <s5h36eql6xq.wl-tiwai@suse.de>
Subject: RE: [PATCH v3 0/7] ALSA: aloop: Support sound timer as clock source instead of jiffies
Date:   Wed, 20 Nov 2019 15:15:08 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000001d59f9c$321e51a0$965af4e0$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVmIB51MVDpXn7r0e76hY1DU59ZaeK6/SAgAkagNA=
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, November 14, 2019 8:11 PM
> To: Gabbasov, Andrew
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Jaroslav
> Kysela; Takashi Iwai; Timo Wischer
> Subject: Re: [PATCH v3 0/7] ALSA: aloop: Support sound timer as clock
> source instead of jiffies
> 
> On Mon, 11 Nov 2019 12:08:39 +0100,
> Andrew Gabbasov wrote:
> >
> > This patch set is an updated version of patches by Timo Wischer:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> March/146871.html
> >
> > This patch set is required for forwarding audio data between a HW sound
> > card and an aloop device without the usage of an asynchronous sample
rate
> > converter.
> >
> > Most of sound and timers related code is kept the same as in previous
> set.
> > The code, related to snd_pcm_link() functionality and its using for
> > timer source setting, is removed (as rejected earlier). The changes in
> this
> > update are mainly related to the parameters handling and some cleanup.
> >
> > The timer source can be initially selected by "timer_source" kernel
> module
> > parameter. It is supposed to have the following format:
> >     [<pref>:](<card name>|<card idx>)[{.,}<dev idx>[{.,}<subdev idx>]]
> > For example: "hw:I82801AAICH.1.0", or "1.1", or just "I82801AAICH".
> > (Prefix is ignored, just allowed here to be able to use the strings,
> > the user got used to).
> > Although the parsing function recognizes both '.' and ',' as a
separator,
> > module parameters handling routines use ',' to separate parameters for
> > different module instances (array elements), so we have to use '.'
> > to separate device and subdevice numbers from the card name or number
> > in module parameters.
> > Empty string indicates using jiffies as a timer source.
> >
> > Besides "static" selection of timer source at module load time,
> > it is possible to dynamically change it via sound "info" interface
> > (using "/proc/asound/<card>/timer_source" file in read-write mode.
> > The contents of this file is used as a timer source string for
> > a particular loopback card, e.g. "hw:0,0,0" (and here ',' can be used
> > as a separator).
> >
> > The timer source string value can be changed at any time, but it is
> > latched by PCM substream open callback "loopback_open()" (the first
> > one for a particular cable). At this point it is actually used,
> > that is the string is parsed, and the timer is looked up and opened.
> > This seems to be a good trade-off between flexibility of updates and
> > synchronizations or racing complexity.
> >
> > The timer source is set for a loopback card (the same as initial setting
> > by module parameter), but every cable uses the value, current at the
> moment
> > of opening. Theoretically, it's possible to set the timer source for
each
> > cable independently (via separate files), but it would be inconsistent
> > with the initial setting via module parameters on a per-card basis.
> >
> > v2:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> November/157961.html
> >
> > v3:
> > - Change sound card lookup to use snd_card_ref() and avoid direct access
> >   to sound cards array
> > - Squash commits on returning error codes for timer start and stop
> > - Some locking related fixes
> > - Some code cleanup
> 
> The patch won't work with the latest ALSA timer code found in my
> for-next branch due to the API changes.  Essentially you need to
> rewrite as:
> 	timeri = snd_timer_instance_new(...);
> 	if (!timeri)
> 		no_memory_error;
> 	timeri->flags |= ...;
> 	timeri->ccallback = ...;
> 	....
> 	err = snd_timer_open(timeri, ....);
> 	if (err < 0)
> 		error;
> 

The updated patch set version 4 was sent to mailing list:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158896.h
tml

It is based on the linux-next repo master branch as of Nov 19, 2019.

Thanks!

Best regards,
Andrew

