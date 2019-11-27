Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D758210ACE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0JtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 04:49:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfK0JtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42736B1DF;
        Wed, 27 Nov 2019 09:49:06 +0000 (UTC)
Date:   Wed, 27 Nov 2019 10:49:00 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/35] powerpc/perf: remove current_is_64bit()
Message-ID: <20191127094900.GA11661@kitsune.suse.cz>
References: <cover.1574798487.git.msuchanek@suse.de>
 <83795e9690ad8b51a2d991919bc102351a3bbb20.1574798487.git.msuchanek@suse.de>
 <ecceebf5-391a-c75d-28a7-44623adc06e8@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecceebf5-391a-c75d-28a7-44623adc06e8@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:41:09AM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/11/2019 à 21:13, Michal Suchanek a écrit :
> > Since commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> > current_is_64bit() is quivalent to !is_32bit_task().
> > Remove the redundant function.
> > 
> > Link: https://github.com/linuxppc/issues/issues/275
> > Link: https://lkml.org/lkml/2019/9/12/540
> > 
> > Fixes: linuxppc#275
> > Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> This change is already in powerpc/next, see https://github.com/linuxppc/linux/commit/42484d2c0f82b666292faf6668c77b49a3a04bc0

Right, needs rebase.

Thanks

Michal
> 
> Christophe
> 
> > ---
> >   arch/powerpc/perf/callchain.c | 17 +----------------
> >   1 file changed, 1 insertion(+), 16 deletions(-)
> > 
> > diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> > index c84bbd4298a0..35d542515faf 100644
> > --- a/arch/powerpc/perf/callchain.c
> > +++ b/arch/powerpc/perf/callchain.c
> > @@ -284,16 +284,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> >   	}
> >   }
> > -static inline int current_is_64bit(void)
> > -{
> > -	/*
> > -	 * We can't use test_thread_flag() here because we may be on an
> > -	 * interrupt stack, and the thread flags don't get copied over
> > -	 * from the thread_info on the main stack to the interrupt stack.
> > -	 */
> > -	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> > -}
> > -
> >   #else  /* CONFIG_PPC64 */
> >   /*
> >    * On 32-bit we just access the address and let hash_page create a
> > @@ -321,11 +311,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
> >   {
> >   }
> > -static inline int current_is_64bit(void)
> > -{
> > -	return 0;
> > -}
> > -
> >   static inline int valid_user_sp(unsigned long sp, int is_64)
> >   {
> >   	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> > @@ -486,7 +471,7 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> >   void
> >   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> >   {
> > -	if (current_is_64bit())
> > +	if (!is_32bit_task())
> >   		perf_callchain_user_64(entry, regs);
> >   	else
> >   		perf_callchain_user_32(entry, regs);
> > 
