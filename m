Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0F10E533
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 06:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfLBFH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 00:07:27 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:55286
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbfLBFH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575263246;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=rMxOBw3aWlogGDBT6R+kAoQRRttCZ1c1uAUUr62RFII=;
        b=Zr90MDkWKgarPyvpUaLv5w7irNxJ6XjyrlR1maynIYyg49fnCNAU4uQFfdHG0J0j
        C/edjTb97VsgtdKuzhXLN8hRN3IB1vsRszcVPvONYmmy3Vugba8dTkRu0+JLCwz4f7R
        Q/g7azXsJwO+sV8tnRsGT6mhP1Qq3Iv+iy4V2wrE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575263246;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=rMxOBw3aWlogGDBT6R+kAoQRRttCZ1c1uAUUr62RFII=;
        b=G6Qx7h/jdDEwK15NRDJ/+4tlpGRMkgRD1LcF0zjVybR7WjB7hXUUkF+1ARNIqTaV
        JJsdUb8UT7vR1Ni1Vw2Xy8ow4A/eoiaylZVy4Fz16jm8S+dB17XzryneO/H26WKXiSC
        KL5ljcjEU7I2PfbgzxFv5N0X1muttOCiBKdMvhQo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8C0FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sgrover@codeaurora.org
From:   <sgrover@codeaurora.org>
To:     "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Marco Elver'" <elver@google.com>
Cc:     "'Dmitry Vyukov'" <dvyukov@google.com>,
        "'kasan-dev'" <kasan-dev@googlegroups.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Paul E. McKenney'" <paulmck@linux.ibm.com>,
        "'Will Deacon'" <willdeacon@google.com>,
        "'Andrea Parri'" <parri.andrea@gmail.com>,
        "'Alan Stern'" <stern@rowland.harvard.edu>
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org> <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com> <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com> <20191014101938.GB41626@lakrids.cambridge.arm.com>
In-Reply-To: <20191014101938.GB41626@lakrids.cambridge.arm.com>
Subject: RE: KCSAN Support on ARM64 Kernel
Date:   Mon, 2 Dec 2019 05:07:26 +0000
Message-ID: <0101016ec501966f-4b89bcda-49ba-45d3-b226-62538b901b04-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkPOdSLH2Qcxx8ygFmLWl3/QxVtgJ871EyAngelYcCVg8vwqbOydmw
Content-Language: en-us
X-SES-Outgoing: 2019.12.02-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there any update in Arm64 support of KCSAN.

Regards,
Sachin Grover

-----Original Message-----
From: Mark Rutland <mark.rutland@arm.com>=20
Sent: Monday, 14 October, 2019 3:50 PM
To: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>; sgrover@codeaurora.org; =
kasan-dev <kasan-dev@googlegroups.com>; LKML =
<linux-kernel@vger.kernel.org>; Paul E. McKenney =
<paulmck@linux.ibm.com>; Will Deacon <willdeacon@google.com>; Andrea =
Parri <parri.andrea@gmail.com>; Alan Stern <stern@rowland.harvard.edu>
Subject: Re: KCSAN Support on ARM64 Kernel

On Mon, Oct 14, 2019 at 11:09:40AM +0200, Marco Elver wrote:
> On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> =
wrote:
> >
> > On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > I am from Qualcomm Linux Security Team, just going through KCSAN=20
> > > and found that there was a thread for arm64 support=20
> > > (https://lkml.org/lkml/2019/9/20/804).
> > >
> > > Can you please tell me if KCSAN is supported on ARM64 now? Can I=20
> > > just rebase the KCSAN branch on top of our let=E2=80=99s say =
android=20
> > > mainline kernel, enable the config and run syzkaller on that for=20
> > > finding race conditions?
> > >
> > > It would be very helpful if you reply, we want to setup this for=20
> > > finding issues on our proprietary modules that are not part of=20
> > > kernel mainline.
> > >
> > > Regards,
> > >
> > > Sachin Grover
> >
> > +more people re KCSAN on ARM64
>=20
> KCSAN does not yet have ARM64 support. Once it's upstream, I would=20
> expect that Mark's patches (from repo linked in LKML thread) will just =

> cleanly apply to enable ARM64 support.

Once the core kcsan bits are ready, I'll rebase the arm64 patch atop.
I'm expecting some things to change as part of review, so it'd be great =
to see that posted ASAP.

For arm64 I'm not expecting major changes (other than those necessary to =
handle the arm64 atomic rework that went in to v5.4-rc1)

FWIW, I was able to run Syzkaller atop of my arm64/kcsan branch, but =
it's very noisy as it has none of the core fixes.

Thanks,
Mark.

