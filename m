Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F77131996
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAFUqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:46:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:50709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFUqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578343537;
        bh=AXpGt6vP1miQ02Ok8X67tzEHDpIlBVB845mWvjv5ADY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Unb+4F7Ij6/bVNexShtXbEUPfcoBefbQgOX9fakK6GPKEREeZg/opgspH7CTQZiUu
         VuhJAteg9YWGOOBkzKbKS3NhEZs5VUvAKPKPZ1pMiWABXKAoGFvHiyNJKXCuDc/SNv
         MazE7c4JPEVQlikrT2cbI6lPtX79IutDZbuKZhyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.53]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1jiJCv3Q21-00uYAY; Mon, 06
 Jan 2020 21:45:36 +0100
Date:   Mon, 6 Jan 2020 21:45:34 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read error
 gracefully
Message-ID: <20200106214534.39378927@gmx.net>
In-Reply-To: <20191227225204.GQ27497@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
        <20191227225204.GQ27497@sirena.org.uk>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8R6Ak8r/kkVJO4HyPxZZFP9/PXIR7PCZyESALXOFPRi68v7X8K
 Y51A8wh/vU6IJRJTrJUaeuolxbvHXNetGMJuD/c3yQBhsH+HX+kZUL63YN0Npzm5vmS+bXb
 7VLbRl1zkMDVnxuG6VpZGKkPSIueDuPcny3VzoL9cB7dS3z6sWmPZKZpGR5DMzQh0xSAD+R
 ZZgKW70iW2e+PrUXeXePg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tc85brVL/yI=:+mntAPO7HQ0u5djZTpfWwA
 hOkc5txGLKc2hvKUyzxbQML2ajspkqepir54aVulJuV2tf10AfrksFoSVDBaTTDgJnxBYG0od
 vyLVM0er68ip8mvExdT7MAG+U2WAS1v/9rmcmokV6lq1Tv4lHdaL4kkswxsdjHPWkrbTrxH28
 pu25K5lIJtTRm99vIIxmNqEYtQcNyUb7ax3wMn3UuqIsx1XLpX01ZbLOvL7tUJb8cNEoZNQR0
 /+JOAs2QvCUWSy4O0gAhIFNBnh97pZe9g5xXt5pKN/pciGrsCJvAN1DFAoX52PejTx0t/1U6x
 Lx7W4CCBZ9vXs2trQta5DnVsayqW0qVl34y386PAWx4BK/7eZw2uSUTr/KAyzvEmLmfrrMb6m
 K5N2Ncb5nI5KXeUtZMmXGjFTPpaamoH6TU97jHY6H5ZHYoVYZ69dScpur88E4bdBPnXA0wo+L
 uB3emQed+ICsCL06T1KV6oDzHgM/OttkkfCecamKC4Yv6VBbUQIdm+FRz847ELXG1F55gITjr
 hX6R8DykdVyljrNHc0LKqsCgOMgX0tjQAF2IEHS61luCv8o2zKpoQ602YzY5aOfW49X+q7Cjc
 o/tnqcljFcnk8BMvGggCHoK95dcQdmvfFgnExSefaI6Ie8Do1A5yZ1VFt/6fcUgaHHCcBxjmV
 +R+khm6TuiHh6F3yi2keKWMY6KE9Ys6R8I3jLp9OrXzL7m12iIL2UATz9AMFZEn1StYtK1w58
 vxF75a5watVTxfeCN8c3RSmnSJT8tp4bIQ/vUi4s7xgJ062HY5W8HKxigWcAifixd+eAiPy98
 P60AsyMc6/e+xDj8Akt1/Gr/aetUn8bwHWJX9c3etGb+njApHMD8AQlC1kNxrcx1iCQjGTY8y
 O1r/xPxxPNitcVdfxfZrT29szswy/RyQPBhv450al7fZDiLey09BPKYZDvuCE8+GNvgX9eIvy
 7YhR6O3+gO6bliqQ1y3SmfX5BYB64Wi40Zy7uqAcKE5oBzjD+RUnVbMkUt8rFqv81jNifCyfo
 OpkZ6KYNjbJUglHIwNHgGKqjTzeZfc4fzR2JbniMhm4L/wnKAw9J8SKF0VgCO4fkGGTdYWdGI
 JAfkjHQobHN2JNn0+oefdkRbHtpPxagBUPBbXY/izlHcpOYK187R1SUlP2JfOoLhVLt7NJsQI
 tI6C0mTMCXqHCQg+XPqEv3zqDytphlFz9CRWMF1gbuxPYIoD2ieq9A+QQrF200GzAJPUvasvm
 2P0S8btgCscQPCzJv2d7+HwslzT4NZLwTGm5KSX8OpT+rmhpCQyg7O/7iHpM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Fri, 27 Dec 2019 22:52:04 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> > Fixes:
> >
> > [    5.169310] Division by zero in kernel.
> > [    5.200998] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.18-201910=
21-1+ #14
> > [    5.203049] cdc_acm 2-1.6:1.0: ttyACM0: USB ACM device
> > [    5.208198] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tr=
ee)
> > [    5.220084] Backtrace:
> > [    5.222628] [<8010f60c>] (dump_backtrace) from [<8010f9a8>] (show_s=
tack+0x20/0x24)
>
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Thanks for review..., but a little disagree here, do not know much which
is more informative than a complete back trace for a division by zero (and
which is the complete information/starting point for investigating the
reason therefore) and it would be a pity to loose this valuable informatio=
n?

Maybe I should have added more information about why and how the failing
regmap_read() call leads to a division by zero?

Any hint for a better commit message is welcome ;-)

Regards,
Peter
