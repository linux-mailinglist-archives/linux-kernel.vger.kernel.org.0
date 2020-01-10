Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E48313712C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgAJP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 10:28:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgAJP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:28:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2401646wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXkYk1wr3xOcC4kmVHKlnMGgZqSHONG6or7V3cMRBfw=;
        b=F33T91L+0exJkm4W6ymnTYAWlH6C8rI++wYC55+vSK+32TVCw3utrIIHPL9gWWuR4z
         Ooq0VqOPl3V1PZOQCVH3wmxk0C3bUiD8MhUezkehT3gFsnucpt/tuSILyO27GZyOpdZV
         xb0Y2RP5w4A8Lh7Rvv8nzlGJNO4J12Pj6NZ+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXkYk1wr3xOcC4kmVHKlnMGgZqSHONG6or7V3cMRBfw=;
        b=XZJiE5xrbKfHk/kBFoZJZqzn+33fJsKlup9Iy63xfx1TgkbF5Z/+iKCyyP9isOeZjx
         NQTjHGcF5gng7EY6XmkekKRA76c+bkkM3kDkZe5OnVu7JQ1NEaYm7sPbhS0RWuXnSaWS
         4kBQ+c7zK/9zu3WWkpK+BTRGqVNq7KjTC8tHc+RdmW7XB7ovCtpUIsCBLxc87vwvG5IX
         oTZ5AXtyy3897p0Hbv9q7oUrJ87dP91Sn5dbTEsUmnJuLP4sKfWTbTRXbatiNCo4W18U
         4VNs2CwUIUI702SCzFEOCQtDMvw0INxkco/4HTJZI8NRYPISG1I9Xg6SlLGRsbG2adKf
         VHgg==
X-Gm-Message-State: APjAAAVeR/N1BOjTbTCfpEGl50iUVUoEs8n7i2/LCLBJtKHRT9yB7CpA
        agX83ke/Tq6lt1jjjQXqkaEJlQ==
X-Google-Smtp-Source: APXvYqw0ag02q22hPKuOzI3/vkzH86GFjij0AS1uLwSH4KQPjjBom3rLw/8TFnXp5EIU2M4mQ97Qxw==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr5205966wmb.137.1578670081018;
        Fri, 10 Jan 2020 07:28:01 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id f1sm2560213wro.85.2020.01.10.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:28:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 10 Jan 2020 16:27:58 +0100
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200110152758.GA260168@google.com>
References: <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Jan 14:47, Stephen Smalley wrote:
> On 1/9/20 2:43 PM, KP Singh wrote:
> > On 10-Jan 06:07, James Morris wrote:
> > > On Thu, 9 Jan 2020, Stephen Smalley wrote:
> > > 
> > > > On 1/9/20 1:11 PM, James Morris wrote:
> > > > > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > > > > 
> > > > > > The cover letter subject line and the Kconfig help text refer to it as a
> > > > > > BPF-based "MAC and Audit policy".  It has an enforce config option that
> > > > > > enables the bpf programs to deny access, providing access control. IIRC,
> > > > > > in
> > > > > > the earlier discussion threads, the BPF maintainers suggested that Smack
> > > > > > and
> > > > > > other LSMs could be entirely re-implemented via it in the future, and that
> > > > > > such an implementation would be more optimal.
> > > > > 
> > > > > In this case, the eBPF code is similar to a kernel module, rather than a
> > > > > loadable policy file.  It's a loadable mechanism, rather than a policy, in
> > > > > my view.
> > > > 
> > > > I thought you frowned on dynamically loadable LSMs for both security and
> > > > correctness reasons?
> > 
> > Based on the feedback from the lists we've updated the design for v2.
> > 
> > In v2, LSM hook callbacks are allocated dynamically using BPF
> > trampolines, appended to a separate security_hook_heads and run
> > only after the statically allocated hooks.
> > 
> > The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
> > still remains __lsm_ro_after_init and cannot be modified. We are still
> > working on v2 (not ready for review yet) but the general idea can be
> > seen here:
> > 
> >    https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
> > 
> > > 
> > > Evaluating the security impact of this is the next step. My understanding
> > > is that eBPF via BTF is constrained to read only access to hook
> > > parameters, and that its behavior would be entirely restrictive.
> > > 
> > > I'd like to understand the security impact more fully, though.  Can the
> > > eBPF code make arbitrary writes to the kernel, or read anything other than
> > > the correctly bounded LSM hook parameters?
> > > 
> > 
> > As mentioned, the BPF verifier does not allow writes to BTF types.
> > 
> > > > And a traditional security module would necessarily fall
> > > > under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
> > > > gateway for proprietary LSMs...
> > > 
> > > Right, we do not want this to be a GPL bypass.
> > 
> > This is not intended to be a GPL bypass and the BPF verifier checks
> > for license compatibility of the loaded program with GPL.
> 
> IIUC, it checks that the program is GPL compatible if it uses a function
> marked GPL-only.  But what specifically is marked GPL-only that is required
> for eBPF programs using KRSI?

Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
specific verification for the v2 of the patch-set which would require
all BPF-LSM programs to be GPL.

- KP

> 
> > 
> > - KP
> > 
> > > 
> > > If these issues can be resolved, this may be a "safe" way to support
> > > loadable LSM applications.
> > > 
> > > Again, I'd be interested in knowing how this is is handled in the
> > > networking stack (keeping in mind that LSM is a much more invasive API,
> > > and may not be directly comparable).
> > > 
> > > -- 
> > > James Morris
> > > <jmorris@namei.org>
> > > 
> 
