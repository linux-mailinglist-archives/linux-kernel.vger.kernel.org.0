Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF974399
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbfGYDEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 23:04:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34285 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfGYDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:04:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so18804336ywc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nrbk7bQLskXts/zN28tmN3yp8oUVQIhnquHI+u1+rrU=;
        b=P2FV77oa65p+uZuWlQRKhCU+fsKjGfcfvFEmoKLqa5om2N7vSy9QKvqy13EdjCOFsb
         wd/+JuIsqBO2sarMfxgkzGx1upakvFLfYNtbutK8plfj2/7ik3D7z+BHmVI65H36YFY2
         Qu+ZhwwkZq2nCOoIqSFSRpJW1Y0o1+qkep75SeTDA7tnHl6VFTEBy/FO5IGUaP+hXl73
         oS4+HM4o9kGYjbUPmZppvpXvGNQd9WS9jWvuxStpLHoZuB6Z3xpL8nkzM0BcBdmSSyN6
         EqOfM38IoiG7xH/q+8RDJ4CNw3LhQ2OoFArHpQg88IlCaJ//Tx4Kv+qu2vmMcJweWjvW
         nq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nrbk7bQLskXts/zN28tmN3yp8oUVQIhnquHI+u1+rrU=;
        b=L2ImqATfXBCnn5G37bftVVhZ9vEExwxDvPYnRkfbSSRTzatBlGb/wbOmX6rB8sxQoQ
         0VGqLelnbH7S/Xqes9Pq5+JCXG3oKWGtIJA/zzcxGNvXIMye1fslBMs43O7bqYc8rwmN
         XZCHpEXGjGH+7Vh0fPO91zfDNWZAt9ktpxvo7ZWwQkxqrz8zS4pRUZid0QwoQwecPckj
         EcXABtKyVzKrKCGS7aOOcOktNXXUIyHBjnXO6yzgx7dxZJLqyxcE2wLk76XGG4Crp1H4
         6nLMJLfKFZ+NJ58XwyJmoE6CQpB37lVIaefXRiKo7vqiHpx+LvINe+4saXwoZpmKvneK
         iktw==
X-Gm-Message-State: APjAAAWx/1cooUMpN95pXQSGL6gbBSc2rP6rqYm/nm4++An9IbH0fJvi
        c71wspCXc/C3VNigADdqRxgwzr8ccq6au0pY7QI=
X-Google-Smtp-Source: APXvYqzpy8AKgUa7JslgdCRM5mJYzjaH3LwuEiZjPk1f4K1Ck/sKn1S+vC0IwuBx7SSJAURffMLJOX4C3MzZ+DX6hEw=
X-Received: by 2002:a81:6d07:: with SMTP id i7mr54324963ywc.112.1564023870299;
 Wed, 24 Jul 2019 20:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <1563977432-8376-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1563977432-8376-1-git-send-email-rppt@linux.ibm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 24 Jul 2019 20:04:18 -0700
Message-ID: <CAMo8Bf+d39UKeUHLcjBcT40Zwr4j9BY7uKaS23vn+nyyVZCMhw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove free_initrd_mem
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:11 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> The xtensa free_initrd_mem() verifies that initrd is mapped and then
> frees its memory using free_reserved_area().
>
> The initrd is considered mapped when its memory was successfully reserved
> with mem_reserve().
>
> Resetting initrd_start to 0 in case of mem_reserve() failure allows to
> switch to generic free_initrd_mem() implementation.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/xtensa/kernel/setup.c |  9 +++------
>  arch/xtensa/mm/init.c      | 10 ----------
>  2 files changed, 3 insertions(+), 16 deletions(-)

Thanks, applied to my xtensa tree.

-- Max
