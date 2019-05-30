Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887EA2F8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfE3JDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:03:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33889 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfE3JDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:03:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so4418770lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLUaFADyhBdgaomUFG+GWwKml6E6RSzearLMmFK4+nc=;
        b=jbDuzxLzWIDJhcdCq03363wwzMtTJarBsdxiCXrVFIaLk/5QV1o78EDw9cUGlYGMEX
         axwEL+ZWA0F6QAkVycQN2uAccXHge31QebxEaMHUdKCVj/kfHU/B9OYUp81yZM+5TzbZ
         xlwILMQrCpnvbNpgN9wofqeZC14XoSvnX8RwUVBiugJhQdjNCqtQz/wZ1+aBrFqYCxVZ
         rncPCOf25Zod25PN8/m3xrB9f5VXLegJivrrYZ/wqHn1fPEr72kmZjShKXFofIMQUvNg
         ioJ5RgSzZAVPh2mtSIn8vSBRM8iz80Aq0JCk/X9lV99mjXvuOrDu0xQ+jTLilAvWBtuy
         BkTA==
X-Gm-Message-State: APjAAAVpwgzY62fq86ZZ/UXENDnmfEKNw4JmHCjn4zz/RO9Njh1Lo+yP
        H5yNrP40JiKaIQKbpYOCB37wF3eJT7l/MNfImVjjqX/RTc8=
X-Google-Smtp-Source: APXvYqwOs6/Z7Zvsqe5zDtlUG9PheB0tKEtvnbwOQqxXzanlWfStYLSN1Znbi1tNczSSp/JsjeDxF6PKzDl6RVJgp9I=
X-Received: by 2002:a19:e308:: with SMTP id a8mr1438340lfh.69.1559206978774;
 Thu, 30 May 2019 02:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190530145525.3cca17cb@canb.auug.org.au>
In-Reply-To: <20190530145525.3cca17cb@canb.auug.org.au>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 30 May 2019 11:02:22 +0200
Message-ID: <CAGnkfhwQY6mw--2=QD+BR1ceOWb5E1Wnzp57dO-pbiNnYwS2PA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 6:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> net/tipc/sysctl.c:42:12: warning: 'one' defined but not used [-Wunused-variable]
>  static int one = 1;
>             ^~~
> net/tipc/sysctl.c:41:12: warning: 'zero' defined but not used [-Wunused-variable]
>  static int zero;
>             ^~~~
>
> Introduced by commit
>
>   6a33853c5773 ("proc/sysctl: add shared variables for range check")
>
> --
> Cheers,
> Stephen Rothwell

Hi,

this is due the merge of:

commit 4bcd4ec1017205644a2697bccbc3b5143f522f5f
Author: Jie Liu <liujie165@huawei.com>
Date:   Tue Apr 16 13:10:09 2019 +0800

    tipc: set sysctl_tipc_rmem and named_timeout right range

I'm making a patch to suppress the warning.

Regards,
-- 
Matteo Croce
per aspera ad upstream
