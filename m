Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2D1919A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 20:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCXTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 15:00:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38501 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgCXTAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:00:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so4821752wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+VmbkfsT1KjaPpUv2GYJYAkZEjslGkNEys2uqLVH4a8=;
        b=I1JIzZbmAE/7Sm9CnUYkniPqNwTQUFAbj18IvZY175AaEyOOvifEd0Ikhn/8p0TBnH
         zhRMY6Q/X3yH8ImPKdnMzi3/QVwI4wk4IEKTVezQW6bdojsRfUv7zQHmY+DlXxCWhk9U
         gfBu+IK/QpE0prEEC1hytMbvQBLn7zmg3sBFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+VmbkfsT1KjaPpUv2GYJYAkZEjslGkNEys2uqLVH4a8=;
        b=OztCrGhcBQjScxTOUoymnphMiHUugZCOWpPOsag8119KGWCQXV4if1w9DzoR59xWb7
         emAHHdtffhP3rJ1qDVbaCdIdFh6o9XaUHK4WtXRQkyXvQAKTXvMU54JruDU+uJx+Qugo
         Y/4aGMIoJNnmlDfnVmmKqvIm9VD2EWm4tlVMf76C8VVK3mLqXcJYV3I4Uisu3s3vchGG
         +aFz+tmZWlnSN3MB28wXrcg9SVA//0hcQrx+D3PPQOHHmF9WS4ekxo/+qsWUx7JZxo5t
         Qp/mIH+cDFkzJhdJnnY5njH3dUZR3w0SmLzT3bhBVqhlvlCenbAtDU2VibFS/59TC/bo
         1rAw==
X-Gm-Message-State: ANhLgQ1oO/4hKtmEgyMYDBDE9QczVLJZV6n2/z5h4H0aazqKLC1f2YiU
        95B6DSqIJwyUWTabWBn/9NJ0RQ==
X-Google-Smtp-Source: ADFU+vsYkNg+QyHBO+1j4K8rmwcnnuIfPno8vCqgZxz5Nna0aZEyBeIzBYp0svbINkrhxcthu+dLJA==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr6873823wml.172.1585076447444;
        Tue, 24 Mar 2020 12:00:47 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id k133sm5351316wma.11.2020.03.24.12.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:00:46 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 20:00:45 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200324190045.GA1891@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEf4BzaceUCEw+-s9EM3rvz+KbLrvBbUfa5e0CSbtkOytF+RsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaceUCEw+-s9EM3rvz+KbLrvBbUfa5e0CSbtkOytF+RsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-M�r 13:18, Andrii Nakryiko wrote:
> On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > JITed BPF programs are dynamically attached to the LSM hooks
> > using BPF trampolines. The trampoline prologue generates code to handle
> > conversion of the signature of the hook to the appropriate BPF context.
> >
> > The allocated trampoline programs are attached to the nop functions
> > initialized as LSM hooks.
> >
> > BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> > and need CAP_SYS_ADMIN (required for loading eBPF programs).
> >
> > Upon attachment:
> >
> > * A BPF fexit trampoline is used for LSM hooks with a void return type.
> > * A BPF fmod_ret trampoline is used for LSM hooks which return an
> >   int. The attached programs can override the return value of the
> >   bpf LSM hook to indicate a MAC Policy decision.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  include/linux/bpf.h     |  4 ++++
> >  include/linux/bpf_lsm.h | 11 +++++++++++
> >  kernel/bpf/bpf_lsm.c    | 29 +++++++++++++++++++++++++++++
> >  kernel/bpf/btf.c        |  9 ++++++++-
> >  kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++----
> >  kernel/bpf/trampoline.c | 17 +++++++++++++----
> >  kernel/bpf/verifier.c   | 19 +++++++++++++++----
> >  7 files changed, 102 insertions(+), 13 deletions(-)
> >
> 
> [...]
> 
> >
> > +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > +
> > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > +                       const struct bpf_prog *prog)
> > +{
> > +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > +        */
> > +       if (!capable(CAP_MAC_ADMIN))
> > +               return -EPERM;
> > +
> > +       if (!prog->gpl_compatible) {
> > +               bpf_log(vlog,
> > +                       "LSM programs must have a GPL compatible license\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
> > +                   strlen(BPF_LSM_SYM_PREFX))) {
> 
> sizeof(BPF_LSM_SYM_PREFIX) - 1?

Thanks, done.

> 
> > +               bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
> > +                       prog->aux->attach_btf_id, prog->aux->attach_func_name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> 
> [...]
> 
> > @@ -2367,10 +2369,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
> >         struct file *link_file;
> >         int link_fd, err;
> >
> > -       if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
> > -           prog->expected_attach_type != BPF_TRACE_FEXIT &&
> > -           prog->expected_attach_type != BPF_MODIFY_RETURN &&
> > -           prog->type != BPF_PROG_TYPE_EXT) {
> > +       switch (prog->type) {
> > +       case BPF_PROG_TYPE_TRACING:
> > +               if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
> > +                   prog->expected_attach_type != BPF_TRACE_FEXIT &&
> > +                   prog->expected_attach_type != BPF_MODIFY_RETURN) {
> > +                       err = -EINVAL;
> > +                       goto out_put_prog;
> > +               }
> > +               break;
> > +       case BPF_PROG_TYPE_EXT:
> 
> It looks like an omission that we don't enforce expected_attach_type
> to be 0 here. Should we fix it until it's too late?

Done.

> 
> > +               break;
> > +       case BPF_PROG_TYPE_LSM:
> > +               if (prog->expected_attach_type != BPF_LSM_MAC) {
> > +                       err = -EINVAL;
> > +                       goto out_put_prog;
> > +               }
> > +               break;
> > +       default:
> >                 err = -EINVAL;
> >                 goto out_put_prog;
> >         }
> > @@ -2452,12 +2468,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> >         if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
> >             prog->type != BPF_PROG_TYPE_TRACING &&
> >             prog->type != BPF_PROG_TYPE_EXT &&
> > +           prog->type != BPF_PROG_TYPE_LSM &&
> >             prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
> >                 err = -EINVAL;
> >                 goto out_put_prog;
> >         }
> >
> >         if (prog->type == BPF_PROG_TYPE_TRACING ||
> > +           prog->type == BPF_PROG_TYPE_LSM ||
> >             prog->type == BPF_PROG_TYPE_EXT) {
> 
> 
> can you please refactor this into a nicer explicit switch instead of
> combination of if/elses?

Done.

- KP

> 
> >                 if (attr->raw_tracepoint.name) {
> >                         /* The attach point for this category of programs
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index f30bca2a4d01..9be85aa4ec5f 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/rbtree_latch.h>
> >  #include <linux/perf_event.h>
> > +#include <linux/btf.h>
> >
> 
> [...]
