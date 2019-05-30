Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197CC2FC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfE3NNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:13:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46589 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE3NNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:13:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so4840063oid.13;
        Thu, 30 May 2019 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVw41Ow1r6jG1wObyyoJYpkoAAUD3t3fN+eCufiqrBY=;
        b=a1+eTlYv5fCUSXqzjFtmUWsuwOMbcLioJ1dPAn+yY+KKo6e1UMFzErx78it3OCuOvU
         gfNOPhVQb59uvkiIAOmJScz5KQrytbjbZzyxPuhbpnv9phXTgf2yB1rNE1d/pyxNv+cS
         Jvhf9X1BLF5F89JKIfRLEvkPY2iMVQpuCqHSeO1frm373XOdoPhuyUL9I+5RYrfUAAB9
         coqSXyn1e1gewR9bHIIIrP5KV+UTiJJEqkLm23YJe63o7qG5U3/f5rzzovZXGcXnRad9
         UfzdJI/Z6aRmH+R6ul6/VKulH8iI03kRAuHPl1woek5MdLHYSEYrOXXbKS9VwnXoOzfD
         oGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVw41Ow1r6jG1wObyyoJYpkoAAUD3t3fN+eCufiqrBY=;
        b=nkrgU8Emby2vqmx+eTvMXCEDC/zzUvCxs9Eg9fFkWRUsCqnekVMseCXOTL9+iFev2q
         VzmWO8k+4ZFhsUvV8urRrUoLKz2WUP2wl4ztOXmXgzDhqu2Hcin+6c9OJ0Xm22V+q3yx
         w94LdiL+z2vdJ71grggLBD2REAcwUkVTokjXww9cgx50c35XYJwiwhjH/VV+2p4LMXSA
         Tw1CPBoRD87j16lwwBSBEc6mK5sp6ZJAQ9qSxNnn/CgeyDIiMVF6MX50va7I2TAgJQvP
         deib5WLGXpfTxvTvuBj+f0v/Kqxr/6HFLPlBEA8bzS0mS/w7R5tFuNBtMgwVJ8HhiBWO
         169g==
X-Gm-Message-State: APjAAAVHvBlR9w2MDGZGg9AWMl0X5uFn4nxacx6Mvd7u6/mF0zlRv+yS
        7V90KYhNXneiByIWZ+mv9GVKFR55PJs5IhiHgX8=
X-Google-Smtp-Source: APXvYqxFsOY6Adco5hfS1UmkDb8pDszZbtE71IqHD45Squ3aAOVUAvmuYZ2Rt3zKJDQ1J/FREc2FFRQiPN7QRUy2CqI=
X-Received: by 2002:aca:ad8f:: with SMTP id w137mr2509131oie.77.1559221985587;
 Thu, 30 May 2019 06:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
In-Reply-To: <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 30 May 2019 09:12:54 -0400
Message-ID: <CAGngYiWMSwjQ2jGH6cbUzdPWpg6RAk1A8+Nh4Ljc=R8L_xB=fQ@mail.gmail.com>
Subject: Re: [PATCH 22/22] docs: fix broken documentation links
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 7:24 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Mostly due to x86 and acpi conversion, several documentation
> links are still pointing to the old file. Fix them.

For drivers/staging/fieldbus/Documentation/fieldbus_dev.txt:

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
