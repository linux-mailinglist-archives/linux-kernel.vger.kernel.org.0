Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE92FEC36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKPMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 07:07:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfKPMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:07:06 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iVwqr-0002bU-Ba; Sat, 16 Nov 2019 13:06:53 +0100
Date:   Sat, 16 Nov 2019 13:06:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <Babu.Moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: next/master bisection: boot on qemu_i386
Message-ID: <20191116120653.akqtisn6tl4uazlo@linutronix.de>
References: <5dcf1f39.1c69fb81.409da.a39c@mx.google.com>
 <alpine.DEB.2.21.1911152327020.28787@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911152327020.28787@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-15 23:28:49 [+0100], Thomas Gleixner wrote:
> Does the patch below fix it for you?

I can confirm that -next from yesterday with i386_defconfig doesn't boot
on qemu and boots with this change. (I had to disable selinux because it
did not compile otherwise here).

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Thanks,
> 
> 	tglx

Sebastian
