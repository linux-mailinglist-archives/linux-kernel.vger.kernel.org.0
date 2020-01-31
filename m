Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4514E76E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 04:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgAaDSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 22:18:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41681 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgAaDSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:18:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so6211182eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEOcbam6lkpewzM/QAeXoI3lqiVgnug3kiCPMonrhtk=;
        b=qLxxa4iblEFXTNkhpXnrUE2jEwWkTF32sgj/WripjIkzr3FN5HhP+oxWGrK5LPpeuX
         BdXC/ta5pWwYxoPmPnwjyLYrwwhu7PdqsdsxD3QJRTXNF9VLcur/Uj0QPrDJcKIFK8WD
         Inivp0E1OGD97QK5cDwi9NeziJ+2uXu9lI+OXOSAm0+8v2S6H4KOsHn8wuuNXLazSbUE
         J6UGrQcl0tp7vQIZZp9zz4E90wuPARtwIjqUV/+PA+6v0Iurpdm3MMtRHB40DfNWd/ee
         C9jmr/5Z3KydS+TdtygpRDTCkMiW2RKiaolxrMJkE9uV7rR8TdU5widouDLZI3z9nH7O
         LUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEOcbam6lkpewzM/QAeXoI3lqiVgnug3kiCPMonrhtk=;
        b=RVK4RE7iiZcwYvFrhDvWSxZhkCKNrj9FpFLyh7qBrs41nWjqsk3d1UD0mBKjl4Y4Ko
         1EQ5GvByiZu/DAsgn2L3O3P9Uz3MYbhmxPZY6oNTrO3CnSB/LaZG/Wfi9lR0cE7nQuH5
         W7RdrSma1UN3vgzIdcwbx1oUeCtg/HJ7bUz80eyD3IH0RD7ZBfhA7g+vrH3I3whdwk2+
         1bAn+ju7dcfj9EXNVw0peX2vOIa3VqayTR/FB0Cl2cU8u2cdzu0bJ9LaGM0forPyD0ef
         K209yxzqNE24/vzM/nfDtbcuo7FOWLx7YdlLC57Nkby6ZEQAW31bmEUBIIdTLRM9+mrU
         rBNg==
X-Gm-Message-State: APjAAAUfOpLcSUQGzIiqttxQyfktNYrZSPM79pOvygOHpKpdRb2+k6d5
        9sV+Tsp4y3FG+Yuh08h2qTD0Bg/t5uFc7fkUaBfg
X-Google-Smtp-Source: APXvYqxufqzKyb49egpBrJmvUXyLRz88Mm+V9y+cHsgviO9ZYjgLZ0WhxG3Xh0NApIF+UruakQs1vxR25nSGP/fXa80=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr6798194ejb.308.1580440712079;
 Thu, 30 Jan 2020 19:18:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <9f16dee52bac9a3068939283a0122a632ee0438d.1577830902.git.rgb@redhat.com>
In-Reply-To: <9f16dee52bac9a3068939283a0122a632ee0438d.1577830902.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:18:21 -0500
Message-ID: <CAHC9VhS4Cz1T=hycPVz3aCzOpPX-EDzwh284YQ2V5rUM7BJkzg@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 7/9] netfilter: ebtables audit table registration
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

On Mon, Jan 6, 2020 at 1:56 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Generate audit NETFILTER_CFG records on ebtables table registration.
>
> Previously this was only being done for all x_tables operations and
> ebtables table replacement.
>
> Call new audit_nf_cfg() to store table parameters for later use with
> syscall records.
>
> Here is a sample accompanied record:
>   type=NETFILTER_CFG msg=audit(1494907217.558:5403): table=filter family=7 entries=0

Wait a minute ... in patch 4 you have code that explicitly checks for
"entries=0" and doesn't generate a record in that case; is the example
a lie or is the code a lie? ;)

> See: https://github.com/linux-audit/audit-kernel/issues/43
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  net/bridge/netfilter/ebtables.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 57dc11c0f349..58126547b175 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -1219,6 +1219,8 @@ int ebt_register_table(struct net *net, const struct ebt_table *input_table,
>                 *res = NULL;
>         }
>
> +       if (audit_enabled)
> +               audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries);
>         return ret;
>  free_unlock:
>         mutex_unlock(&ebt_mutex);
> --
> 1.8.3.1

--
paul moore
www.paul-moore.com
