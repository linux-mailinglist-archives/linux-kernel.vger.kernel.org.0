Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178D37B51D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfG3Vig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 17:38:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43901 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfG3Vig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:38:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so49074770oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
        b=wPargsCx1nCKwYgN+UmNJ+Ig2yIDukdOFYcafHAoe3HixxhzXwRMveW8WJbYjiLDVB
         XbzprVIA35u37LGeX54iP4ILaKrn2ZhsHJ7HWatfCu+Dy3AK04gYp0qsDNO5JINxbU66
         793vBLMC/2q9GjCzIncgSDaS52sZ95bS4q3yUIBVFG0BqK7kBkiiL0rUkTy1gy785b/G
         HixoGYJN0KZsmAs7IKt+3EffEecPzG3ht9NV6iRwONmKHhzWMdcK5ojktOyBien+IE2z
         ZnpdPMHhrkvdWxeuLBaHFjco1kw0VqWIzURD3Kv3X0Zi1Xvi85u1GhDy0eXKzpdjXw/K
         RMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
        b=ahj3lgl/YYHRf0pktUyT0AqVAzau5p9EIZRB+dOQfdGQ6rw9X5UKVLrf0CmgG6qXOc
         zU/VLsV6Co2khT7pGnkhKQ+xrKEpwXHMD0dpvRulgY5dWhYFY7CaLE/PMFpNTbhwS5Ed
         9PEGOdhYnXzHyGfmaWpFpE9SZ6JEacNsunbt6DvaxSNqLVSm2FFRvMOn0R3BRDP08skv
         jcLHo7TpaihwWuH+qIqpwvXcV8coEyMlAmkT35vKauJwNDxTqR7Wn3IbPaWBWOjCGcnF
         SKqmSG0p+6vZwo0PAoLHEtuDaiZZbH9ehcpISQcUvY6uk1MObWx4ZUE/ZW4oUFT1SU7a
         hWTw==
X-Gm-Message-State: APjAAAUvw83C4grGfIsj93xHNWvd3ULpptqtAgWAf1atJsbTT5hI7UVC
        jmrwyVk47OzrdvzWp1Uf52gSAkeBo/mjmuX+uypS+g==
X-Google-Smtp-Source: APXvYqz/vebOGKyx5iJtOjMRLpWnJO3JxlqPxCgJzVvyZc/nI/IYK9bwftHIvxiV8iym6ilmxvWFcSB3C9ypYO/5uNs=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr58049607oig.105.1564522715513;
 Tue, 30 Jul 2019 14:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190730113708.14660-1-pagupta@redhat.com> <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com>
In-Reply-To: <20190730190737.GA14873@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Jul 2019 14:38:24 -0700
Message-ID: <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
Subject: Re: dm: fix dax_dev NULL dereference
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, jencce.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> I staged the fix (which I tweaked) here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e

Thanks for picking this up Mike, but I'd prefer to just teach
dax_synchronous() to return false if the passed in dax_dev is NULL.
Thoughts?
