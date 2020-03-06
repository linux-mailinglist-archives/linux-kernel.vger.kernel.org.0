Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF417B3E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 02:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFBmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 20:42:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46410 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:42:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id h18so431289ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 17:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SO8SF0fRs4gm9zjgJ5npIDJ8ex1hHPJ1UNzxdktCWGU=;
        b=c1Lcx9ELcG0+k4Gd2AIRBYtY97tISFMaQp+9h1vDWLH6UoUJdJVvRhM0Fgp9B/8M7S
         PtTrzdPy44SWe6ROZIUTTrUxAzx694ibOZI6peNisdwdQJjVE20d09XZXTutZNkPX8nq
         i6QBe0/sN7nTyD6PhtFlo1XTgFSI6J0Us3GRPAu9HC+rcfjVbdOqQPDsqg48Oa1AkwxJ
         VfZv/EavO1Pqtfks3zXKvFxYEXZBk4Pedp4cks+Gm9xqlmB/TbLbLMH6wmPf8vs8SMhA
         AUNQaGF04ysOAnF8y9II99At1Mo8v8Qpara6YzgpxdmjDNdyEdQoVyDewS59z21y7Psy
         w8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SO8SF0fRs4gm9zjgJ5npIDJ8ex1hHPJ1UNzxdktCWGU=;
        b=QL6FZ7FJUFudj9CWYYgRt0w8iJfvKCfdsCeJJCNXrlJFmktEiDcCvtZ4xjItIpu+c/
         8GN/vU3nCutgGTmAmgjTAVys5E9cbfASf4QoCUXF2nWoOIffyT+rN+NfyJqU8N5abN6Z
         bDp3a0wljcuNO7yIkIOIofNAhjMD700NO6mM7CeZLXGrb2c/1jhvTjS3L9La0+Rxvkae
         VEACZpezNrI3ch7OND60xApiGpoO9zx30UONQeLiX4Ny14RhuGPIuKfjD8FFvx5cTEHh
         C3r05lQwmleCdcJ7giotswjWfOkcrxxADASTmRIJT+tl6rAtEBeUUNcQwMGQ0X4VvWLn
         WqCQ==
X-Gm-Message-State: ANhLgQ0CM+WlBjNdeFdJw3wnMoZKqojNjJ0Ww/++vVa8NRmJ3czkX/xP
        W4CrEalI1HzTXAHudXaJKaOffbHLmeRVP9794VKZQL3BHC8=
X-Google-Smtp-Source: ADFU+vsUzFDdnUIJRLlqBuiFTmXiQyPhd5qDYK/Hba2PjE1nOCdXigvTmsJiIGoQj37+lpc+JgCwMfHz60VPmy3mmOk=
X-Received: by 2002:a2e:9918:: with SMTP id v24mr525320lji.197.1583458941188;
 Thu, 05 Mar 2020 17:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20200305234822.178708-1-jaegeuk@kernel.org>
In-Reply-To: <20200305234822.178708-1-jaegeuk@kernel.org>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 5 Mar 2020 17:42:09 -0800
Message-ID: <CA+PiJmQzj0Lj2FKi3A4Z=LC_tcQ9i9xtb3dmXwa9fSsQ+YN_LA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix wrong check on F2FS_IOC_FSSETXATTR
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 3:48 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> This fixes the incorrect failure when enabling project quota on casefold-enabled
> file.
>
> Cc: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---

This fixes the issue I was seeing, I'm just a bit concerned with the last two.

>
>         fi->i_flags = iflags | (fi->i_flags & ~mask);
> -       f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
> -                                       (fi->i_flags & F2FS_NOCOMP_FL));
> +       f2fs_bug_on(F2FS_I_SB(inode), (masked_flags & F2FS_COMPR_FL) &&
> +                                       (masked_flags & F2FS_NOCOMP_FL));
>
> -       if (fi->i_flags & F2FS_PROJINHERIT_FL)
> +       if (masked_flags & F2FS_PROJINHERIT_FL)
>                 set_inode_flag(inode, FI_PROJ_INHERIT);
>         else
>                 clear_inode_flag(inode, FI_PROJ_INHERIT);
> --
> 2.25.1.481.gfbce0eb801-goog
>

Shouldn't these still be fi->i_flags? masked_flags comes from the
previously set i_flags, so this would change from testing the new
combination that was just set for fi->i_flags to checking only the
masked version of the old flags.
It might make it clearer to rename masked_flags to masked_old_flags,
or something like that.
-Daniel
