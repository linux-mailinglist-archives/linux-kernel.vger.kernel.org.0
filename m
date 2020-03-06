Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789C017C745
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFUtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 15:49:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgCFUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583527750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vnq654icNMC3OPciKhsbNTJjnPlwkjnJ6PM6ZwzuRt4=;
        b=eep0UgrczUZwnbE+5nguzqVfj94v15Zxc6KMABuvfCy6RphpMMN61fVlKEhT1qFDCuTFl0
        uvMPQDVqdkc+yQs1gzm31l3dxUkaaVjyBtFyVgmUuKP0Wnn+A9h33dCZILMnIk5yP82emf
        2WQLldd3n1xT/o+9CpYwSRCROG5X7n4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-3DAFd2zjMLGg53YzHlyjhQ-1; Fri, 06 Mar 2020 15:49:08 -0500
X-MC-Unique: 3DAFd2zjMLGg53YzHlyjhQ-1
Received: by mail-il1-f199.google.com with SMTP id x2so2469991ila.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vnq654icNMC3OPciKhsbNTJjnPlwkjnJ6PM6ZwzuRt4=;
        b=W+hyii2cnYbqgd9AP9kWQrJz49pGp4/d+DmoGHz62P7kqi0MypfjGikB9lF7Oko/Fa
         nErHfBj0GAz2kfRcGYu4hxlzcDZ3gGFLY3YkbrYOxpJTFt+xhhnRhwKDNPMo1f1o/icR
         2RVgUAVuCvJ39fx05eIAMx/vTl6GXigFbAeA+d4ceuBBuGUa74B6CAg+fPZyu35MNHsa
         M5fYBH3vcxlCOqCfXCIOuJC3dkqRimfo4hCwQ3946ZjZUzCf/3XGAuyxjblwnufQQwLh
         ZDq+Nnv7f5+puP3OgkBfoixnUOA5Oick3qbDx7/1dFaFi0jG5vU+jEaqZcuVlHfs73Wd
         oi1w==
X-Gm-Message-State: ANhLgQ2IBkTk1bi3hTadeUYw2UAJUZpiGPX6Hr43QLWeUwfszuUqu1C+
        YVKy5nLMoLD6X4Xoy3zn9q0SjjD1P4TNVj216b6avKeRLsmDd26A0K72912mqhUwVP0mpp+CYAa
        VB6QxkqJ63cAt6dMutAfBoJgi3AX7X1JqXquyOVo4
X-Received: by 2002:a92:bb93:: with SMTP id x19mr4950277ilk.304.1583527748222;
        Fri, 06 Mar 2020 12:49:08 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuvo2iGyk+ibtmVDUTdwqXvKVvixks2GLwbkE+VjCSp2qcV2nb/q6bheS6OfL3JOE3orHdl1mjXyKrLN9a056M=
X-Received: by 2002:a92:bb93:: with SMTP id x19mr4950241ilk.304.1583527747749;
 Fri, 06 Mar 2020 12:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20200306172010.1213899-1-ckuehl@redhat.com>
In-Reply-To: <20200306172010.1213899-1-ckuehl@redhat.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 6 Mar 2020 15:48:57 -0500
Message-ID: <CAOASepNfDLFw_uxbB59hg7B8Rmfaroj9NB8Gw82SFrSOaPbtMQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] crypto: ccp: use file mode for sev ioctl permissions
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        "Hook, Gary" <gary.hook@amd.com>, erdemaktas@google.com,
        rientjes@google.com, "Singh, Brijesh" <brijesh.singh@amd.com>,
        Bandan Das <bsd@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 12:20 PM Connor Kuehl <ckuehl@redhat.com> wrote:
>
> Some background:
>
> My team is working on a project that interacts very closely with
> SEV so we have a layer of code that wraps around the SEV ioctl calls.
> We have an automated test suite that ends up testing these ioctls
> on our test machine.
>
> We are in the process of adding this test machine as a dedicated test
> runner in our continuous integration process. Any time someone opens a
> pull request against our project, this test runner automatically checks
> that code out and executes the tests.
>
> Right now, the SEV ioctls that affect the state of the platform require
> CAP_SYS_ADMIN to run. This is not a capability we can give to an
> automated test runner, because it means that anyone who would like to
> contribute to the project would be able to run any code they want (for
> good or evil) as CAP_SYS_ADMIN on our machine.
>
> This patch replaces the check for CAP_SYS_ADMIN with a check that can
> still be easily controlled by an administrator with the file permissions
> ACL. This way access to the device can still be controlled, but without
> also assigning such broad system privileges at the same time.
>
> Connor Kuehl (1):
>   crypto: ccp: use file mode for sev ioctl permissions
>
>  drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> --
> 2.24.1
>

One additional note is that this permission structure is more flexible
for general SEV usage anyway, and isn't special-case for our usage.
Currently, the SEV admin commands are mostly limited to public key
certificate management. I would imagine that it would be desirable to
have a sev-admin account which can automate the certificate management
without having CAP_SYS_ADMIN for the rest of the system. So we believe
this patch has broader applicability than just our corner case.

