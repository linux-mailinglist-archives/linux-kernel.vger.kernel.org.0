Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265C4A1A32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfH2MhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbfH2MhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE906AC67;
        Thu, 29 Aug 2019 12:37:20 +0000 (UTC)
Date:   Thu, 29 Aug 2019 14:37:16 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Allison Randal <allison@lohutok.net>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicolai Stange <nstange@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
Message-ID: <20190829143716.6e41b10e@naga>
In-Reply-To: <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
References: <cover.1567072270.git.msuchanek@suse.de>
        <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
        <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 14:19:46 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Fixes: aff850393200 ("powerpc: add system call table generation support")  
> 
> This patch needs a proper explanation. The Fixes tag doesn't seem right
> here, since ppc64 has had llseek since the start in 2002 commit 3939e37587e7
> ("Add ppc64 support. This includes both pSeries (RS/6000) and iSeries
> (AS/400).").
> 
> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index 010b9f445586..53e427606f6c 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -188,7 +188,7 @@
> >  137    common  afs_syscall                     sys_ni_syscall
> >  138    common  setfsuid                        sys_setfsuid
> >  139    common  setfsgid                        sys_setfsgid
> > -140    common  _llseek                         sys_llseek
> > +140    32      _llseek                         sys_llseek
> >  141    common  getdents                        sys_getdents                    compat_sys_getdents
> >  142    common  _newselect                      sys_select                      compat_sys_select
> >  143    common  flock                           sys_flock  
> 
> In particular, I don't see why you single out llseek here, but leave other
> syscalls that are not needed on 64-bit machines such as pread64().

Because llseek is not built in fs/ when building 64bit only causing a
link error. 

I initially posted patch to build it always but it was pointed out it
is not needed, and  the interface does not make sense on 64bit, and
that platforms that don't have it on 64bit now don't want that useless
code.

Thanks

Michal
