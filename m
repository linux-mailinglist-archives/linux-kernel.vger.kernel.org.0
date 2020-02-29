Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9217458B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 08:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB2Hra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 02:47:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgB2Hra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 02:47:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so5848955wrp.13;
        Fri, 28 Feb 2020 23:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/LUz+UTHLwwlROXmy/x3cftQqidhD9BYUn0xrwvLmc=;
        b=txSyWcKjgszAoID7iV7ciBLMEePBbqWlV/a2pJmnCgmB36H9o462dkAlmtyqqeHiGr
         JAw5f/AjqKB5I7pyB6AYmZaFP9cFW33rqE/C7s9a4TQ4HApO8sASGkDYEqBylspTOOTF
         7uqLJNfhg8uuzGIPaQmHqIk1MxbAx9hbOtYxIHG+u+oqgDBvDLF6TRYb4Hr+Ok49gx4J
         BrhEgEphb2w1ZG+abujhP64sCubiBqhjwyVDfbdPAJQjIaV+gr2TRHey05OcBc+GUisE
         MRYUoUxYq27cdXV+l5r5LaVwslM/zCpsswJKB0FKeLvfBqzSvTl7SoFgwzKR1jRTG+rc
         mjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/LUz+UTHLwwlROXmy/x3cftQqidhD9BYUn0xrwvLmc=;
        b=rPoOLxZXIgeUv+j8ckRe73mmK+E68Nz2oc8+f5GVchJOiUtBgWnHIthGgIVvgnDuvb
         a2p63oKlBKXnkCy79WRGuxeD67ZY70lh6okUgtauDmcPn8ptEL2E0Yw2VNpjrQUnjdYh
         fh9qU5EGowP7Pxxy7cW3O+RPnSRdNC1dF5TNnuHU3UPTp6ay1uAXiq+8kj6ZbfMFtomN
         B2gkvDfTOk2Ew6/6H2rsoVyA503VcrQBX/TZILPGmVb6iFJbXfoRfteOI4goi3WtI4Lp
         9l8Uaxb5T7EHydWx+y+6Qx4GZk2C8WfpvPmLMHFBv3fPB6yEWx8DfJfRz87FsH1Nh0sW
         EYAg==
X-Gm-Message-State: APjAAAWdYlCEi4rU1yuK603XDP146//RyoePqtW5bzXoLuXBzxE/w0Uz
        StTYl+Fp9E5Em+ux/2e+aotMfCtf87GpPw7gczg=
X-Google-Smtp-Source: APXvYqxQFrUYzLR51muw6xWoYS1TtAN4x8hADnWygx76GqczT7kBq4N2F5PQMlWmipUpFCiARR144YhMae4ozdtNIBM=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr9242071wrj.196.1582962448152;
 Fri, 28 Feb 2020 23:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20200228235003.112718-1-colin.king@canonical.com>
In-Reply-To: <20200228235003.112718-1-colin.king@canonical.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 29 Feb 2020 08:47:16 +0100
Message-ID: <CAM9Jb+jrC0C0RGV+uM_bs5QMSFaYPHjqzOo8vQZ+y-WghQtVvg@mail.gmail.com>
Subject: Re: [PATCH] mm/memblock: remove redundant assignment to variable max_addr
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable max_addr is being initialized with a value that is never
> read and it is being updated later with a new value.  The initialization
> is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index eba94ee3de0b..4d06bbaded0f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1698,7 +1698,7 @@ static phys_addr_t __init_memblock __find_max_addr(phys_addr_t limit)
>
>  void __init memblock_enforce_memory_limit(phys_addr_t limit)
>  {
> -       phys_addr_t max_addr = PHYS_ADDR_MAX;
> +       phys_addr_t max_addr;
>
>         if (!limit)
>                 return;
> --
> 2.25.0

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
