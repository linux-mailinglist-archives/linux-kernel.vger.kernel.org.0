Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03B180792
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCJTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:02:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44170 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCJTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:02:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so3362926pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NAa3TP3qmqkCd6PNCUT1JauvyaDaHlrCn+7zDeOrvYE=;
        b=cd8kwNwiBn5vnMkNIU6eb+wb68NiEiNOrTyqrFFIc30IZIqSHZ3cn3XYiuXkUw8nJG
         6+axNErT1qFr+d5aSzgYTPnPOrr4Ukcl8bs7uW44F3w/IiYhnWoVSZxauteCIEXC3hyf
         k1j+U+SpqBZyKOOZAoUfSEKOumA7xbuDjMJaprkM8V+DmPdXzEvWCC6oO7cB3683GRAb
         gaeypStz4UMSW3fn5/n8HoaOyTYEsaM6JNfWv9igJ4jP8vDiXDsFFcl8aMsXujhY+dhc
         9dloEuwz9po4tUyJx8LMoLGOEyVFEgXpv9jQbzKXgKUcQfYdSAQlNLVUwgamOIzF3M4l
         g0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NAa3TP3qmqkCd6PNCUT1JauvyaDaHlrCn+7zDeOrvYE=;
        b=BucSHPCVs3Hj/jnNaZWUKh7FJJSvBK91N7q1N0crGNBfyflqJVyK3nF3I/22Vif7+7
         54Krk6IEQCtUTiA1QDPnxtH/FTUbdKl5PFgWLrz+08syAmm7Zn8tzeCcJTtCewVdcMc0
         h2oGbpG3I8qk4jnVtzHZ6lh0QXz6vdFWabs+f0SAeEbFcFnhi9OITJj3kPYIfCNxLsTZ
         FF+xpW/u1Z178GYYx1+sZpkm231SenfygBK6xzQ0mB10RmbLWfavO0uhtVSKhOcKGYiy
         c6i3htQ0XnJTYoRQZEmumJE8r0d9iRDNDvWNLntQFBo1TWFVuer5CPhCljGPKk6RjDiW
         FDXA==
X-Gm-Message-State: ANhLgQ0D4lbxDi7rARGAlJayaAPck+xjF2urgOEdKxBk9H+bdxobgXOc
        orij+g2fIo24M/Arifv5ennEqQ==
X-Google-Smtp-Source: ADFU+vuaIwjDdUHgYLXTZxdXFZbT+dbWRIOiqUomqlbFYZ33UtbPbT7+s6A0XijUIDtZ65PpnauT8A==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr23301514pgn.251.1583866926779;
        Tue, 10 Mar 2020 12:02:06 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 9sm43568841pge.65.2020.03.10.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:02:05 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:02:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Bandan Das <bsd@redhat.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Connor Kuehl <ckuehl@redhat.com>, thomas.lendacky@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gary.hook@amd.com, erdemaktas@google.com, npmccallum@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] crypto: ccp: use file mode for sev ioctl
 permissions
In-Reply-To: <jpgpndkjmkb.fsf@linux.bootlegged.copy>
Message-ID: <alpine.DEB.2.21.2003101201530.90377@chino.kir.corp.google.com>
References: <20200306172010.1213899-1-ckuehl@redhat.com> <20200306172010.1213899-2-ckuehl@redhat.com> <b037d70f-c23f-72d6-3866-57cb1e501eba@amd.com> <jpgpndkjmkb.fsf@linux.bootlegged.copy>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Bandan Das wrote:

> Brijesh Singh <brijesh.singh@amd.com> writes:
> 
> > On 3/6/20 11:20 AM, Connor Kuehl wrote:
> >> Instead of using CAP_SYS_ADMIN which is restricted to the root user,
> >> check the file mode for write permissions before executing commands that
> >> can affect the platform. This allows for more fine-grained access
> >> control to the SEV ioctl interface. This would allow a SEV-only user
> >> or group the ability to administer the platform without requiring them
> >> to be root or granting them overly powerful permissions.
> >>
> >> For example:
> >>
> >> chown root:root /dev/sev
> >> chmod 600 /dev/sev
> >> setfacl -m g:sev:r /dev/sev
> >> setfacl -m g:sev-admin:rw /dev/sev
> >>
> >> In this instance, members of the "sev-admin" group have the ability to
> >> perform all ioctl calls (including the ones that modify platform state).
> >> Members of the "sev" group only have access to the ioctls that do not
> >> modify the platform state.
> >>
> >> This also makes opening "/dev/sev" more consistent with how file
> >> descriptors are usually handled. By only checking for CAP_SYS_ADMIN,
> >> the file descriptor could be opened read-only but could still execute
> >> ioctls that modify the platform state. This patch enforces that the file
> >> descriptor is opened with write privileges if it is going to be used to
> >> modify the platform state.
> >>
> >> This flexibility is completely opt-in, and if it is not desirable by
> >> the administrator then they do not need to give anyone else access to
> >> /dev/sev.
> >>
> >> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> >> ---
> >>   drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++----------------
> >>   1 file changed, 17 insertions(+), 16 deletions(-)
> >>
> >
> > Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
> >
> > thanks
> 
> Reviewed-by: Bandan Das <bsd@redhat.com>
> 

Acked-by: David Rientjes <rientjes@google.com>
