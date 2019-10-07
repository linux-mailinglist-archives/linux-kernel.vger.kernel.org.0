Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B58CECC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJGTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 15:30:06 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:53543 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728079AbfJGTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:30:05 -0400
X-ASG-Debug-ID: 1570475405-0ea5be51261ee1dd0001-xx1T2L
Received: from mta-out2.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda1.shentel.net with ESMTP id 4xtCxOTZaGdB0xN9; Mon, 07 Oct 2019 15:10:05 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out2.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 8D2961D;
        Mon,  7 Oct 2019 15:10:05 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-rt-users" <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: Re: [ANNOUNCE] 4.19.72-rt25
Date:   Mon, 7 Oct 2019 15:10:05 -0400
X-ASG-Orig-Subj: Re: [ANNOUNCE] 4.19.72-rt25
User-Agent: KMail/1.9.10
References: <20190916173921.6368cd62@gandalf.local.home>
In-Reply-To: <20190916173921.6368cd62@gandalf.local.home>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201910071510.05101.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1570475405
X-Barracuda-URL: https://172.26.193.41:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 2681
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2019 17:39:21 Steven Rostedt wrote:

> Dear RT Folks,
>
> I'm pleased to announce the 4.19.72-rt25 stable release.
>
> **** <NOTE> ****
>
> As you probably have noticed, it has been a long time since I released
> a stable 4.19-rt. The reason for this delay is that one of my tests
> failed after merging with the latest stable upstream. I refuse to push
> releases with a known bug in it, so I figured I would find the bug
> before releasing. I only spend around 4 to 6 hours a week on upstream
> stable RT as I have other responsibilities, and I could not debug this
> bug during that time (after several weeks of trying).
>
> The bug is a random NULL pointer dereference that only happens with
> lockdep enabled and on 32bit x86. I also found that this bug existed
> before the latest stable pull release but now it is much easier to
> trigger.
>
> I have not been able to trigger this bug in the 64 bit kernel, and as
> I rather do a release than waste more time on this bug and postpone
> the release further, I am now doing that. As a consequence, I am no
> longer supporting 32bit x86, as it is known to have this bug.
>
> If you are interested in this, I am willing to send out the config I
> am using and one of the dmesg crashes. Just ask.
>
> **** </NOTE> ****
>
>
> This release is just an update to the new stable 4.19.72 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v4.19-rt
>   Head SHA1: 9cd04ab6a9a162ac4189a80032261d243563ff45
>
=====================================================================
> Or to build 4.19.72-rt25 directly, the following patches should be
> applied:
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.72.xz
>
>  
> http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.72-
>rt25.patch.xz
>
Unfortunately, this does not work for the pi3-4 family. When its all 
pulled in and patched, there is no arch/arm/configs bcm2709_defconfig or 
bcm2711_defconfig for either a pi3b or the new pi4b.

I'll go find the 5.2.14 announce and see if its any more complete.
>
>
>
> Enjoy,
>
> -- Steve


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
