Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47115B206
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgBLUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 15:42:56 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:42:55 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MryKp-1jng0h1Ror-00nyhj for <linux-kernel@vger.kernel.org>; Wed, 12 Feb
 2020 21:42:54 +0100
Received: by mail-qt1-f181.google.com with SMTP id d5so2719660qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:42:54 -0800 (PST)
X-Gm-Message-State: APjAAAV1U1giEwzzmbU1B7gyyBtRVBMCLMDrx4mfk97wJ7AXHEaqf0nB
        HQP6yUcGRl1znMlHT1vsRy9/rrEl6QK9RfhYwdc=
X-Google-Smtp-Source: APXvYqzbFFnehBBOdl6ZY9lePTyzs7xgHK+/WmKG0jLKpf92Ycgjhz0xkwyxD7PXcWaWveHda52HAv6MenIdAfvH15k=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr20979826qte.204.1581540173275;
 Wed, 12 Feb 2020 12:42:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581522136.git.michal.simek@xilinx.com> <f6bca66fa1c0c4f7321bbac3906fdf87652285d1.1581522136.git.michal.simek@xilinx.com>
In-Reply-To: <f6bca66fa1c0c4f7321bbac3906fdf87652285d1.1581522136.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 21:42:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0xH_ao_zpFV+sn1vB3Gai0RDXMfn7KgCB0fJh3oV06PQ@mail.gmail.com>
Message-ID: <CAK8P3a0xH_ao_zpFV+sn1vB3Gai0RDXMfn7KgCB0fJh3oV06PQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] microblaze: Make cpuinfo structure SMP aware
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EeepXst0+fc/JOzNh92gXY7nm4TgG7y6vUTId9yyaNrX7qybVPr
 pVOInvXiOoTFyyKXWj1olNL9t0dHIhiLyn0oelzFjTPmFBumZHeWvNcT6T0W53QA+sHUsym
 GRlRU/s1r9JZilxMvnskxjq0+IohqhutbKv2u1k/qBpYX2S4aPlIR9N7jmt1Zbme7iixPCq
 US9IbIEYOOPvei2yqOldA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4BiVOqfuY8=:bGWpvUa+1qjKX2j0N90l9o
 KmZftTqbJCuNgJNXYDZeL+sK9yAnES+Ww2pmgLfm/A4LhUyowkMjlyRE6Jxi/+UJgS8kvaGgZ
 M7CQAfgFmmEbsHCky8icbUpy144YeCDAV8r2mlmLcC9SzWCHZf90YVdg7NbMgz+MFR654MQnd
 ZpBexjqxHpv9+jskMCKoI0Uv68suK4518twxBeOiSC/NiX4lzSG5Uixi5DOK54x7Xd8GitRGr
 gYVl2htYC8yF/esDPk++STU8bGkWxrUwedbiInhrvlRXXnzEm825wjEt0+yHzwyvZCwRXKgfX
 dtzJgpx6YmtSJO5bVy7kTpZRw5aqv5hPQDpj0hPh2TBEmGtpSHHgIskwec2fdEFqunLe1OoYW
 Y19i7rH0F9AyQrfspqoMF4I2hv1F2qGFCQaHpWFzK4+/HDhInd+EhkeZlR32stmWolbV2Uk6K
 UbKCduFVnRcgjLKUQoPq7cligkbmQ0H2MR0GK317PCEqdQdzsKhCQ1eCoU9hcLiSPpn9N99hD
 VXuDBjrTEoZ+E2nWnU0qm4nPIiBpXXCqf/zpZdyydAToEeJ+clhEjEdtgdgS8io/d2ras9YIS
 mllcPQNJfoWoFPWIqWRkQzRZVurTtvSE4PMUAnabjrlgDptkPjSBKjWJlIDHUmHEyWJyScWZh
 V4fAZp98ZX78S4WqW3C268JURNcOtl7YdqnwEqOfvjxNrySG0YoeVLLBPTz3TGmb9nbBQAtq3
 27BeiZ/SR3uoVE6BtIsNfr8JDC42naWl6+TFlJT96eXkCjVWEvEnD4IqzBv8qzCM6T8fDaf8L
 xO42C7qpNI3DcaHuaK7NQB4ywHLyRcdjU2PK61yJU1pg+b0IZc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 4:42 PM Michal Simek <michal.simek@xilinx.com> wrote:

>  static void __flush_icache_range_msr_irq(unsigned long start, unsigned long end)
>  {
> +       unsigned int cpu = smp_processor_id();
> +       struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);

I think all the instances of smp_processor_id()/per_cpu_ptr() should
be replaced with get_cpu_ptr()/put_cpu_ptr(). Same for per_cpu_var()
 -> get_cpu_var().

       Arnd
