Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4303162A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEaUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 16:35:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33640 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEaUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:35:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id x10so1757054pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bkHPoc5lC5mW7wR1FrM44fNwP3Z1d5MLik27r7NZcj4=;
        b=bt2atdtE4k6OMppdFqAhmK/USH9XSeZWrsrRZq6i50JOXfbnxCoW50vFJGVRI7gDXD
         hzYHx23O3lK6EyC7T+pr+vU9GR5eASj5urGbI1YeN8qNBo9fOM2RJkcIZFkr/axPGzYE
         RMiViv869M/Y8ipTA+gg8M5NY1vennR5o2EE0bwC72cL8pE1KDJ6sL9UZTYVqvB7zRQ2
         kZpYqTkg1rvIEEILOBUEySytnpd0c+JCZnkIjZl4O4Mv2wIrVWNj+0Vspdn4OrJXlsRn
         HawvmZKVF4CFWyZwN+HeViDSEDfgiSf8bItEzJQMBfBok5UjSepb5mt49w2685BwUIhc
         bTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bkHPoc5lC5mW7wR1FrM44fNwP3Z1d5MLik27r7NZcj4=;
        b=YzCXL12PXULqhc2kgONKWRHdQbsq/cWNCJXqgMlMn/7eQjduARYEldBmCSx6oOLP/o
         X6tSTGMb789Ub2hTTvMcKWlTtzB6fP5TaMJp/tHh2K6Bz+SC+R2DpYPl0tGYINM0DEJz
         N9CW/1w3k9bdDfd/vzwgOKJCaIZmyWwhR1d2ccOJaz5k/MMTkFpgv+bllyTRPOX+jpHV
         X4rINaUO8VYrMHhrTN8QOI+/s5ooCrF/ep86AdjQoR6Lhhha90RjpEapfxPoqG9iHyk9
         pMGDiTYalnMub3wUAHlCA8I48ljb0itLlKAUEUfbZSV1QFAH35mdYwWirT0LQyvouThw
         rnXw==
X-Gm-Message-State: APjAAAXa5dTPwYMrqCSDdPvwe236bh1CcHTjD7Qk2I7IsGuNqu4SC1AZ
        fgulc+dAOlTF17NLFxVU0WYANA==
X-Google-Smtp-Source: APXvYqwkwhkqir+dMhYXAG70FpSw4GwU+es7vuPNj1W5tYEbhjZ2VubCjYq4QiP6LRydAmYkVQvEew==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr12487802pfk.239.1559334942443;
        Fri, 31 May 2019 13:35:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d2sm5841218pfh.115.2019.05.31.13.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 13:35:41 -0700 (PDT)
Date:   Fri, 31 May 2019 13:35:41 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2019 13:31:53 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
In-Reply-To: <mvm8supd718.fsf@suse.de>
CC:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Anup.Patel@wdc.com, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de
Message-ID: <mhng-faba08ec-69a7-43b1-b2d7-c2e996751506@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 01:00:35 PDT (-0700), schwab@suse.de wrote:
> On Mai 28 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> My only issue here is testing: IIRC last time we tried this it ended up causing
>> trouble.
>
> I've been running kernels with these settings since the beginning, and
> never seen any trouble.

OK, I'm happy with it.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
