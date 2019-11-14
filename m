Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC4FC4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 11:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 05:52:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:52:08 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVCjA-0008Ez-UZ; Thu, 14 Nov 2019 11:51:53 +0100
Date:   Thu, 14 Nov 2019 11:51:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH 20/23] y2038: move itimer reset into itimer.c
In-Reply-To: <CAFqZXNu4Tk4H3b_FS8=EA5QMi10kEgT22uD=61aDryHp-fXnig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911141149050.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de> <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com> <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
 <CAFqZXNsp3JxqW-ahCvtiZBECX5PWonpzMRK0MOn=6a28WzF4cA@mail.gmail.com> <CAK8P3a2FZ2_v6uUJJOurMAE7xYG6wq7T7ZvpLVAPA6FG2pm0dQ@mail.gmail.com> <CAFqZXNu4Tk4H3b_FS8=EA5QMi10kEgT22uD=61aDryHp-fXnig@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Ondrej Mosnacek wrote:
> On Mon, Nov 11, 2019 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I don't see that as a problem, we rarely put declarations inside of an #ifdef.
> > The main effect that would have is forcing any file that includes linux/time.h
> > to be rebuilt when selinux is turned on or off in the .config.
> 
> OK, but with this patch if someone tries to use the function
> elsewhere, the build will succeed if SELinux is enabled in the config,
> but fail if it isn't.  Is that intended?  I would suggest at least
> clearly documenting it above the declaration that the function isn't
> supposed to be used by new users and doing so will cause build to fail
> under CONFIG_SECURITY_SELINUX=n.

Come on. We have enough functions in the kernel which are only available
under a certain config option and if you (ab)use them elsewhere then the
build fails. So what?

The #ifdef documents the limited scope and intended use clearly. If
something else really needs that function, then removing the #ifdef
shouldn't be rocket science either.

Thanks,

	tglx
