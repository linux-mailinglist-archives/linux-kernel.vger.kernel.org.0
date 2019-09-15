Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EDCB323D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfIOVib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 17:38:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40717 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfIOVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so18459821pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cRhIay7rP7qO7uPvAr8A+Remo+kZoigIWCA9uWQOOak=;
        b=AgydtWNmsm41EGzhfgHuXUQ2ogbP+pCCgNfSFc8BIUGd0TaaRzK+OiSf/lwqT26raw
         Od+y6fdGIORn1N6Jdj5+Tx43HrRH/X2CpQXzgrc/KoLDyzcOMTjjFiTRsCS0KE3WvCrd
         EmBBQfWiYVfX0y0L7Xim5ZozYink7dijZYfoZTYFwXhWQKEIrxsVxIo9yN06ll/9ghsW
         yYGTSGxiDXN9WZ0Vj0zi9xIr7ZQSvz35GPofw+9HEtkasqEPP6hY6ryGYYDVAwqdn9p2
         yOwbcJRrH21to4y6vVPDln+dj4nS4yaXRyuSkRBJl8Mx+3350DVb9k5Nw0B8cZsrqh7y
         vBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cRhIay7rP7qO7uPvAr8A+Remo+kZoigIWCA9uWQOOak=;
        b=qZUKhDd6nGPGLXqJd2PBwptA3kOfzfQR7A8GqaBfG+TVnbMc87+3ekoU0+WUTcBKBL
         hUyQTok/R9r27IDuc8O/25BpdlZCkicU7iPCdxkkkL1BDUNo2sQ5fJApe6DuG+MNZh4r
         6Jai9U7kYq2SVnD3kZqzAtWGPIKWgA56JnL+WvrSHOaxZDdPDuMKqUGQ+tpb+2soJdeN
         T5rmwq9DSB/GMAn5kdJKU9XfiHIR207aQbdbu+4ltBNEubARr0/0OTLfm9ctyog18nAS
         1Mo3WOk01IVXoXE89Xodhnul5SrMVLnM35MdJBV6b1Yf5ymZa7g4OlU9JxaQnBzsM63C
         ZQlw==
X-Gm-Message-State: APjAAAUEUbJRvEWoPzQnSXycZV2uQzJtGIQJYqWHjMCBu8JQGxO2/ytR
        zKq00b6TtF0/1n32WDETVl/Flw==
X-Google-Smtp-Source: APXvYqyhk4vV0f8Hg+AblRQKkdAxS/MnFT2usSrdn79SVyT7mHX1k295fod+5wbpEtY2yDvjcYu46Q==
X-Received: by 2002:a62:7710:: with SMTP id s16mr48666467pfc.139.1568583509899;
        Sun, 15 Sep 2019 14:38:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 7sm24804360pfi.91.2019.09.15.14.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:29 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 2/7] mm, slab: Remove unused kmalloc_size()
In-Reply-To: <20190915170809.10702-3-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151414050.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-3-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> The size of kmalloc can be obtained from kmalloc_info[],
> so remove kmalloc_size() that will not be used anymore.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: David Rientjes <rientjes@google.com>
