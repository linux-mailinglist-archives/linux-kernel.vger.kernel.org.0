Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814C8D4B73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfJLAll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 20:41:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39318 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJLAll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:41:41 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1iJ5TX-00054h-Bu
        for linux-kernel@vger.kernel.org; Sat, 12 Oct 2019 00:41:39 +0000
Received: by mail-wm1-f70.google.com with SMTP id z205so4862461wmb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x9ApgVGO5FiGuEQV6JpJWfviTCfcCHIRUjK55oq8uE=;
        b=mjqiZjhMitm4eT1v+gdFkbXPdlIn2Oonk132iYcNNXvtSjOUHXTnj0E9oLmE46aAsQ
         O2F95XmTPsDhsV/46JwA6EqJgQQT1zgji5kFESeJvPy+KzPpMpJk4W7Caz86BRyl/+Qs
         BO5Ux7SEbDH3nlWQcYTNUZtNmdTt++uD2jDLibZhzE0f8qebq0ywy+tCad6BtsaGPx1C
         IfgZ1fWbsBFyr3n6akDqZQn+iyaicgbqHmaaYNJ4mCjsPI2u0WY2HTDr0NVvtkFIiYXB
         Mvf4CyZp3vyuhPI0R0anoha8be5XqCJS6BsGIhjD3w/X3o1JYJUxpzMrcjT0DZsg2rWT
         ibiA==
X-Gm-Message-State: APjAAAWDJhJwcaebUIBlyfNzBNVl9gknJ0Ld9/IydTfK1Y5HzCJlY+oD
        51/1MybHt3+xYbpz2ClwuXWkvaHTLkohr5GBDLS0DXTDbSqqdu4tGKBgSyZaaEt8kVWU3bdkQWv
        uPGHISDPB7bmyEGv4hvoi0ByyfrnisQC6CGi7dIfDnoivhy8fvDnxiXJqiQ==
X-Received: by 2002:adf:e688:: with SMTP id r8mr16508759wrm.342.1570840899148;
        Fri, 11 Oct 2019 17:41:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzC31d60/9oma6TIhR2sWZv5COX10hbmuTg4ttzGp7rzLnRd6iGntQOOBa9WPbJxgh3JgAHTuzTgw7mpoIsSP4=
X-Received: by 2002:adf:e688:: with SMTP id r8mr16508748wrm.342.1570840898964;
 Fri, 11 Oct 2019 17:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
In-Reply-To: <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Fri, 11 Oct 2019 21:41:01 -0300
Message-ID: <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages creation
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 8:52 PM Qian Cai <cai@lca.pw> wrote:
>
>
> It simply error-prone to reuse the sysctl.conf from the first kernel, as it could contains lots of things that will kill kdump kernel.

Makes sense, I agree with you. But still, there's no
formal/right/single way to do kdump, so I don't think we should rely
on "rootfs kdump is wrong" to refuse this patch's idea. If so, we
should then formalize the right way of kdumping.
Of course, this is only my opinion, let's see what people think about it!

Thanks,


Guilherme
