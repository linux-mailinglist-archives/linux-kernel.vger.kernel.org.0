Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC53AE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 06:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfFJE0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 00:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFJE0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:26:42 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00A520862
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 04:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560140802;
        bh=lmI0sZejbp2xYhDVjKl/Q5Dwr+bxp2gKalOSjoOpxBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0H6l5ByiM3XzUA3HAdElS2xBnIJ/Qhuf0hAF3geV0QXH9d/5cJBXeurBhV7Bn0e/
         wecIUkn/9erAPS6HwBo0O+6VaWddijmAyljW0jKxwEkKj9frmSZGlC+hn68I7stJk7
         NQJ78umYFf+kwKgsiFORfSt2SZyhOr4oOvQK6ij8=
Received: by mail-wr1-f49.google.com with SMTP id x17so7637923wrl.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:26:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXlyrULHXYSvqlsx5rz7HyLFvlTirvtUfHqdAykBNjdNYSB/xmR
        QpUEfadt1Zmkn9OWsVFAClIRiqM0SF/fbBazPVVPFw==
X-Google-Smtp-Source: APXvYqyxbqO+yh5Rk7UOMlfERUvHJVKTyRdi1+MlRWSFzS4a8deSIOHtteeG3mvT7W/nonBM1am49tuiBVnr5EoO5DQ=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr27360248wrj.47.1560140800368;
 Sun, 09 Jun 2019 21:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
 <20190610040449.GB162238@romley-ivt3.sc.intel.com>
In-Reply-To: <20190610040449.GB162238@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 9 Jun 2019 21:26:29 -0700
X-Gmail-Original-Message-ID: <CALCETrWZukWNeiCCwSMPxSHnn6YB_jJeiv4wd2MZAU9pwXf80g@mail.gmail.com>
Message-ID: <CALCETrWZukWNeiCCwSMPxSHnn6YB_jJeiv4wd2MZAU9pwXf80g@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 9:14 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Sat, Jun 08, 2019 at 03:52:03PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > on a processor through IA32_UMWAIT_CONTROL MSR register.
> > >
> >
> > > +static u32 get_umwait_control_c02(void)
> > > +{
> > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
> > > +}
> > > +
> > > +static u32 get_umwait_control_max_time(void)
> > > +{
> > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > > +}
> > > +
> >
> > I'm not convinced that these helpers make the code any more readable.
>
> The helpers reduce length of statements that call them. Otherwise, all of
> the statements would be easily over 80 characters.
>
> Plus, each of the helpers is called multiple places in #0003 and #0004.
> So the helpers make the patches smaller and cleaner.
>

I was imagining things like:

umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_C02;
if (whatever condition)
  umwait_control_cached |= MSR_IA32_UMWAIT_CONTROL_C02;
umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
umwait_control_cached |= new_max_time;

You could save 8 characters by just calling the variable umwait_control.
