Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE57BB6FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 01:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfIRXkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 19:40:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37914 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfIRXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:40:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so1460127otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDQmKC/gOMi6sqZQA7S/aMJ9nwprCWZMCL6cDdDtiwo=;
        b=g8sIiTEUBjwC+jypUemhJSEmv702F9Wm/OQ2yvgmSceH+YZ9TxygCePbNrYI9DjIMI
         QSVrOoN8zmC6+1UX8tJ6WVHh4sA9vGCkaI7q7ebzxUnvEk/XNQxfZ9O9fiZ1mAAArD/F
         SNacoKkcB2wWT6XFmeZ6gPp7SkarL28rhJGFA8pVIZbbHN1xwRW1q/Y0WFEYWtTXLdD8
         xhUMR4yM79Gaiq79K8LkdUGo465NZ6oTNyiAQUBcqjo1C7zHU/fSvIV7MSqKuAHd4p1u
         Mzm5LHoHcYXkOiVGlntTvZzvSL9EKYpe3ec7uy1T493+iO8CiJlMJTa4zC/87w+4VKaf
         YQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDQmKC/gOMi6sqZQA7S/aMJ9nwprCWZMCL6cDdDtiwo=;
        b=iuH8yTM25vXP90tp1uKbzQTk44gYofQI7QpJTZOelVtmcifFkxo60XMUdSiL3r/Wl4
         Jyz4IgNMnHwuKB6Jc/BLXXC9ZjMZKy4TSlw5SJ+MjuXTe4Q2aOiANbyCad/6nj1issFL
         YxwEzsVT5uhykDXi5aHewWpsM4bpBuUlx5dtwiXnTyD96FhoOI6OJ+mRvwdxTqUBoTTZ
         VRPgOPtDf8SCkG8ngtq1l8nRtfAcm2SXm5sUXwYqwotgurl6/v+V2eodbdAJ59ml0kCo
         aYkiXvr5pPRY6ZgbOHZMlVu8ir4GZXb2t0UMSc/i06HLTS7X29AWkeA+9ugD2zCt+aQQ
         ZfTw==
X-Gm-Message-State: APjAAAXG7IVCjMjX2ZaknAk2yHC5PGz/RvAJYrSztut2W33piy+uGd5A
        Uhj8BrT9vAHmh3ogyv22uaRHSNkMfo49GrGMjFqaDA==
X-Google-Smtp-Source: APXvYqy/eeyRCXrtqIXQiK+EIL6EIZYEXp405qr/gxBJydI6Go09Ucme6OvwkC4jXQNVr3w/eolqtR0naKQMNido3N8=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr4419959oti.71.1568850030063;
 Wed, 18 Sep 2019 16:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190918042148.77553-1-natechancellor@gmail.com>
In-Reply-To: <20190918042148.77553-1-natechancellor@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Sep 2019 16:40:18 -0700
Message-ID: <CAPcyv4g-aCrn7pq967rFJ+K_ENifNkZ_azLg6S03V8TGuFdOhg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 9:23 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
> compile checks"), clang warns:
>
> In file included from
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
> warning: redefinition of typedef 'acpi_handle' is a C11 feature
> [-Wtypedef-redefinition]
> typedef void *acpi_handle;
>               ^
> ../include/acpi/actypes.h:424:15: note: previous definition is here
> typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
>               ^
> 1 warning generated.
>
> The include chain:
>
> iomap.c ->
>     linux/acpi.h ->
>         acpi/acpi.h ->
>             acpi/actypes.h
>     nfit_test.h
>
> Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
> remove both the typedef and the forward declaration of acpi_object.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/660
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> I know that every maintainer has their own thing with the number of
> includes in each header file; this issue can be solved in a various
> number of ways, I went with the smallest diff stat. Please solve it in a
> different way if you see fit :)
>

Looks good to me. I'll pick this up for a post v5.4-rc1 push.
