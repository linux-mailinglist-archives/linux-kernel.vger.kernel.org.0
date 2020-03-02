Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260B5176363
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCBTB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:01:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:21654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:01:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:01:57 -0800
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="273846472"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.8.183])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:01:56 -0800
Message-ID: <41d7049cb704007b3cd30a3f48198eebb8a31783.camel@linux.intel.com>
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Date:   Mon, 02 Mar 2020 11:01:56 -0800
In-Reply-To: <CAG48ez2SucOZORUhHNxt-9juzqcWjTZRD9E_PhP51LpH1UqeLg@mail.gmail.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-10-kristen@linux.intel.com>
         <202002060428.08B14F1@keescook>
         <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
         <CAG48ez2SucOZORUhHNxt-9juzqcWjTZRD9E_PhP51LpH1UqeLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 20:27 +0100, Jann Horn wrote:
> On Thu, Feb 6, 2020 at 6:51 PM Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> > On Thu, 2020-02-06 at 04:32 -0800, Kees Cook wrote:
> > > In the past, making kallsyms entirely unreadable seemed to break
> > > weird
> > > stuff in userspace. How about having an alternative view that
> > > just
> > > contains a alphanumeric sort of the symbol names (and they will
> > > continue
> > > to have zeroed addresses for unprivileged users)?
> > > 
> > > Or perhaps we wait to hear about this causing a problem, and deal
> > > with
> > > it then? :)
> > > 
> > 
> > Yeah - I don't know what people want here. Clearly, we can't leave
> > kallsyms the way it is. Removing it entirely is a pretty fast way
> > to
> > figure out how people use it though :).
> 
> FYI, a pretty decent way to see how people are using an API is
> codesearch.debian.net, which searches through the source code of all
> the packages debian ships:
> 
> https://codesearch.debian.net/search?q=%2Fproc%2Fkallsyms&literal=1

I looked through some of these packages as Jann suggested, and it seems
like there are several that are using /proc/kallsyms to look for
specific symbol names to determine whether some feature has been
compiled into the kernel. This practice seems dubious to me, knowing
that many kernel symbol names can be changed at any time, but
regardless seems to be fairly common.



