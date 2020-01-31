Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37114E76C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 04:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgAaDSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 22:18:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43244 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgAaDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:18:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so6186823edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKinvHI4TDJydSGpXy3MUxdAooObzKTfiZRkdcYYm2w=;
        b=q/MBBgiqBvfSEwYCFrokXYuzOaWmtv9KTkTYt8FtsAceTnBePkUWApZwN8xauZYTWB
         xe3Ju7K32IF+NNPgoBdCdYPFid+yIJqjnRidomLsxRAijZdWKco+ySxT93Ik4oNmZx/L
         c5izV7iBpxBJOHk37Mrm4kvsQo/55KduVaLKL7zG2xxzdxr/sOn9H14dTa4jDjSEtJXt
         JkDt14oRcQlDkG+PZUEtpp3Uhp79OFU2INCCcMKY4Uc506wOw2ITOeGzlrzhtdfBfzFe
         SNZxmkYnzJnroDZBTL3Za4kzysnrp+Ezetmus1qKRoWcN4Ms2wNpFWPdnkRBM2Ksz/ez
         DawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKinvHI4TDJydSGpXy3MUxdAooObzKTfiZRkdcYYm2w=;
        b=kp4XDefPIUmyzlNu2YW4ApuAEqxPucb0PWe1El0rh0AWWOoAFl+J1TuQuafBUrqXQ9
         HtV4zd3Vw9xMrmjtbdC2Q/UY8XhPylcezjuhLzsrgmI6qUXEn41cY4OmZOiRc5Y0xpfP
         FarQAGNwoy3sNc2lpPRcM1z+Bx43tDjpP+WC0zhdoBn6huadYs+EnHNQc8dLg1qWqb/G
         9C6t2cPElkBaujjSMNe9iSI+A8SwwEkat2slLlrK/dFtR7M00xDJ8vacD0M5hhHN+M1Q
         yhaCNEiDOzLj0jMpB51ecRNK5CIY4OZNy0/ACrbKjhG5jDYiSCDNydd19dbS+tP6pGiF
         ihSw==
X-Gm-Message-State: APjAAAW2MWNZrLT14/9D5bxA2UWuscUU+bQDe9YmPVu3h9rweHZlS2Vu
        mMj1fJyhE3b189eMH6Uu2sbGtktUdXAylztxgkvj
X-Google-Smtp-Source: APXvYqySKvh6n+nvv2uh7W6ky4Lsp823lPE9v8olzIGwgG1h8U6FCiz9KtyKcZ6Xssk/OPASBLREbduPcBcxWIpbSRk=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr7047956ejz.272.1580440698700;
 Thu, 30 Jan 2020 19:18:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <b1b2e6f917816c4ae85b53d7f93c10c3d1df4a53.1577830902.git.rgb@redhat.com>
In-Reply-To: <b1b2e6f917816c4ae85b53d7f93c10c3d1df4a53.1577830902.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:18:07 -0500
Message-ID: <CAHC9VhRSRggBD9QgXD7-YEx=qY7Ym_1D12y3anAihE=9P7r-6w@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 4/9] audit: record nfcfg params
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:55 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Record the auditable parameters of any non-empty netfilter table
> configuration change.
>
> See: https://github.com/linux-audit/audit-kernel/issues/25
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 11 +++++++++++
>  kernel/auditsc.c      | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+)

I can not see a good reason why this patch is separate from patches 5
and 6, please squash them down into one patch.  As it currently stands
the logging function introduced here has no caller so it is pointless
by itself.  Strive to make an individual patch have some significance
on its own whenever possible.

This will also help you write a better commit description, right now
the commit description tells me nothing, but if you bring in the other
patches you can talk about consolidating similar code into a common
function.

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index f9ceae57ca8d..96cabb095eed 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -379,6 +379,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  extern void __audit_fanotify(unsigned int response);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> +extern void __audit_nf_cfg(const char *name, u8 af, int nentries);
>
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -514,6 +515,12 @@ static inline void audit_ntp_log(const struct audit_ntp_data *ad)
>                 __audit_ntp_log(ad);
>  }
>
> +static inline void audit_nf_cfg(const char *name, u8 af, int nentries)
> +{
> +       if (!audit_dummy_context())
> +               __audit_nf_cfg(name, af, nentries);

See my comments below about audit_enabled.

> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -646,6 +653,10 @@ static inline void audit_ntp_log(const struct audit_ntp_data *ad)
>
>  static inline void audit_ptrace(struct task_struct *t)
>  { }
> +
> +static inline void audit_nf_cfg(const char *name, u8 af, int nentries)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4effe01ebbe2..4e1df4233cd3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2545,6 +2545,22 @@ void __audit_ntp_log(const struct audit_ntp_data *ad)
>         audit_log_ntp_val(ad, "adjust", AUDIT_NTP_ADJUST);
>  }
>
> +void __audit_nf_cfg(const char *name, u8 af, int nentries)

Should nentries be an unsigned int?

> +{
> +       struct audit_buffer *ab;
> +       struct audit_context *context = audit_context();

This is a good example of why the context of a caller matters; taken
alone I would say that we need a check for audit_enabled here, but if
we look at the latter patches we can see that the caller already has
the audit_enabled check.

Considering that the caller is already doing an audit_enabled check,
we might want to consider moving the audit_enabled check into
audit_nf_cfg() where we do the dummy context check.  It's a static
inline so there shouldn't be a performance impact and it makes the
caller's code cleaner.

> +       if (!nentries)
> +               return;
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_NETFILTER_CFG);

Why do we need the context variable, why not just call audit_context()
here directly?

> +       if (!ab)
> +               return; /* audit_panic or being filtered */

We generally don't add comments when audit_log_start() fails
elsewhere, please don't do it here.

> +       audit_log_format(ab, "table=%s family=%u entries=%u",
> +                        name, af, nentries);
> +       audit_log_end(ab);
> +}
> +EXPORT_SYMBOL_GPL(__audit_nf_cfg);
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>         kuid_t auid, uid;
> --
> 1.8.3.1

--
paul moore
www.paul-moore.com
