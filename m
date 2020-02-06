Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96760154A88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBFRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 12:51:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:7570 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:51:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:51:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="404558389"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.96])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:51:14 -0800
Message-ID: <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Thu, 06 Feb 2020 09:51:14 -0800
In-Reply-To: <202002060428.08B14F1@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-10-kristen@linux.intel.com>
         <202002060428.08B14F1@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 04:32 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 02:39:48PM -0800, Kristen Carlson Accardi
> wrote:
> > To support finer grained kaslr (fgkaslr), we need to make a couple
> > changes
> > to kallsyms. Firstly, we need to hide our sorted list of symbols,
> > since
> > this will give away our new layout. Secondly, we will export the
> > seed used
> > for randomizing the layout so that it can be used to make a
> > particular
> > layout persist across boots for debug purposes.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  kernel/kallsyms.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 136ce049c4ad..432b13a3a033 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -698,6 +698,21 @@ const char *kdb_walk_kallsyms(loff_t *pos)
> >  }
> >  #endif	/* CONFIG_KGDB_KDB */
> >  
> > +#ifdef CONFIG_FG_KASLR
> > +extern const u64 fgkaslr_seed[] __weak;
> > +
> > +static int proc_fgkaslr_show(struct seq_file *m, void *v)
> > +{
> > +	seq_printf(m, "%llx\n", fgkaslr_seed[0]);
> > +	seq_printf(m, "%llx\n", fgkaslr_seed[1]);
> > +	seq_printf(m, "%llx\n", fgkaslr_seed[2]);
> > +	seq_printf(m, "%llx\n", fgkaslr_seed[3]);
> > +	return 0;
> > +}
> > +#else
> > +static inline int proc_fgkaslr_show(struct seq_file *m, void *v) {
> > return 0; }
> > +#endif
> > +
> 
> I'd like to put the fgkaslr seed exposure behind a separate DEBUG
> config, since it shouldn't be normally exposed. As such, its
> infrastructure should be likely extracted from this and the main
> fgkaslr
> patches and added back separately (and maybe it will entirely vanish
> once the RNG is switched to ChaCha20).

OK, sounds reasonable to me.

> 
> >  static const struct file_operations kallsyms_operations = {
> >  	.open = kallsyms_open,
> >  	.read = seq_read,
> > @@ -707,7 +722,20 @@ static const struct file_operations
> > kallsyms_operations = {
> >  
> >  static int __init kallsyms_init(void)
> >  {
> > -	proc_create("kallsyms", 0444, NULL, &kallsyms_operations);
> > +	/*
> > +	 * When fine grained kaslr is enabled, we don't want to
> > +	 * print out the symbols even with zero pointers because
> > +	 * this reveals the randomization order. If fg kaslr is
> > +	 * enabled, make kallsyms available only to privileged
> > +	 * users.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_FG_KASLR))
> > +		proc_create("kallsyms", 0444, NULL,
> > &kallsyms_operations);
> > +	else {
> > +		proc_create_single("fgkaslr_seed", 0400, NULL,
> > +					proc_fgkaslr_show);
> > +		proc_create("kallsyms", 0400, NULL,
> > &kallsyms_operations);
> > +	}
> >  	return 0;
> >  }
> >  device_initcall(kallsyms_init);
> > -- 
> > 2.24.1
> 
> In the past, making kallsyms entirely unreadable seemed to break
> weird
> stuff in userspace. How about having an alternative view that just
> contains a alphanumeric sort of the symbol names (and they will
> continue
> to have zeroed addresses for unprivileged users)?
> 
> Or perhaps we wait to hear about this causing a problem, and deal
> with
> it then? :)
> 

Yeah - I don't know what people want here. Clearly, we can't leave
kallsyms the way it is. Removing it entirely is a pretty fast way to
figure out how people use it though :).


