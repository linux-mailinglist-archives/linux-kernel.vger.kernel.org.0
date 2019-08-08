Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D626686197
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfHHM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 08:27:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45594 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbfHHM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:27:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id t3so162729ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJoQH6xbNoByXFD03CQzff1T1rg3XHHfexy4zm58VFs=;
        b=pK2Jy2aJCqvL6Zbsse9R6qW+16L7rOEkySHszCEBs5F0VKRotPrPyu44jyyDIClbQQ
         3DXllrjriP90L6RaVglWIEDATs2iioGY3o/+TzwopWNuXqtMPsTNpy1XfXKhSr8pH2AI
         PmKanKd9U5CeLi80hdvEiobNCfwIbFdEuMJ60bzrJ9LAfk/2OYiAurZUw0qcixF4M5SE
         YcUWAOtvqaMQSuC25S5dtrp2wI4qSjIkU4XQisSWyRh30It0AZ85X2drJbvJNBnGIRzL
         Z6OeCrSjtn5x6V4mqIwHu4iZR4MPFncMiR6jAKvSTmHx2mMzGxStUZG6zRF4OiFk7FmD
         /3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJoQH6xbNoByXFD03CQzff1T1rg3XHHfexy4zm58VFs=;
        b=o51tgP7dMi316R6lTjygLurJViugs/i+paVV75m3LSR/e2ZY17IwgVgXwl0QY+g+pj
         UZ6DtIEpJKLFYihHKX0aWa963qKxTPkMY1iQ7zmDk5Loth0Yb8jHdS+BWrveHSTtf6ZJ
         BX8Gmybtj8j3h+Ek+E8Dw4VkhGFUHKNyYjlXSgMB2maONlWbSW9YLmfcfMOdPZzjz1Qn
         OCy6YD/kQUravMtMGVUmrV8baY8/5IXZaej2ADzA/Dv+hSlOq8zOWcCY4fKpeHmWV5So
         991zxu+9PMlWlylA7OdkSai+Gq/OhgxWw5JcGUCZlgDNsM5S0UYMO0xhDCNLJtSb0OHY
         UO/g==
X-Gm-Message-State: APjAAAVlqilDI/Ge5VRZIkiPHCE+3Cvo/43c7vpYgxZrQppvXVRgC9RA
        vuyH9zvu74xKHcpn7lOgjrXqfNISyQAYkYU63yXebA==
X-Google-Smtp-Source: APXvYqynn5VMST3cneWTKIKRfdQOUrgp2WS4DuM61xZXzMCVt2m7Y/3Qm9PGybsLU6uCQeZXVn92r6kYkU7iqFaN4is=
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr7770792lja.238.1565267229165;
 Thu, 08 Aug 2019 05:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-2-git-send-email-sumit.garg@linaro.org> <20190807185921.lhdt3ek6tphj33bo@linux.intel.com>
In-Reply-To: <20190807185921.lhdt3ek6tphj33bo@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 8 Aug 2019 17:56:57 +0530
Message-ID: <CAFA6WYPsNuN=F9y+Q0r8-6MQAGGZeKUtRheQgKv3HmE1ViyviA@mail.gmail.com>
Subject: Re: [RFC/RFT v3 1/3] KEYS: trusted: create trusted keys subsystem
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 00:29, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:18PM +0530, Sumit Garg wrote:
> > Move existing code to trusted keys subsystem. Also, rename files with
> > "tpm" as suffix which provides the underlying implementation.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> The name for should be still trusted.ko even if new backends are added.
> Must be done in order not to break user space.

Agree. I think I need to update Makefile as follows:

obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
trusted-y += trusted-tpm.o

-Sumit

>
> Situation is quite similar as when new backends were added to tpm_tis
> some time ago: MMIO backed implementation was kept as tpm_tis.ko, the
> core module was named as tpm_tis_core and SPI backed implementation was
> named as tpm_tis_spi.ko.
>
> /Jarkko
