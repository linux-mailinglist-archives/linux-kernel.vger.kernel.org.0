Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4262AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405275AbfGHV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 17:28:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37443 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfGHV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:28:25 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so16807357iog.4;
        Mon, 08 Jul 2019 14:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyFOrXJ0ZCaydHvv7j9V+11xxKKVYbCkZvk7D9LRrEU=;
        b=q7P0fU6LmtEX1CGv04hTVlFSdBvw72ytRTFbfu3L3Xa/s6VHPyOMEqa8/ZZsL94E5w
         b0WhIzzG9T+weaio+Wk4KCUu65/bxgYl9XYo93HabDdHj02vhSDph2lPDo6+nYHEg51o
         2luNQAaazhPP+cnApC/w1tHa3Alwt+Qy/SGg3/hMzz1SyhymORbylvxlUzlu2E9e5Vks
         5EbUT3LmVYsrL/eoDByjuJ0nBKXNTbjdZhLjBwDiOIpJ+YY0GV7CDEHn5uTjZkDh/56a
         O0+zlLqd9rKatamm+sEWxWaLvFwDfb2yDBJ0EItL6egE8MD0lHZQEZ8H2lKJLXfD0Egf
         8mvQ==
X-Gm-Message-State: APjAAAWpD7aE7acRCJidmht8owJ79Xagwb8T4EJjcbnebtif3G6g+IMT
        TeJgZI5BtDtMFai5MGPvKmQE8Uk=
X-Google-Smtp-Source: APXvYqzJdTtN/060l4DQuzW5grkWgmoMWdJA7hzXcB+9y7WkoCv4AS+TQJjI0rjtiJqCvp2o1fntgQ==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr6374266ioj.23.1562621304983;
        Mon, 08 Jul 2019 14:28:24 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l11sm15099797ioj.32.2019.07.08.14.28.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:28:24 -0700 (PDT)
Date:   Mon, 8 Jul 2019 15:28:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/fdt: pass early_init_dt_reserve_memory_arch() with
 bool type nomap
Message-ID: <20190708212823.GA28550@bogus>
References: <20190530103927.20952-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530103927.20952-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 19:39:27 +0900, Masahiro Yamada wrote:
> The third argument 'nomap' of early_init_dt_reserve_memory_arch() is
> bool. It is preferred to pass it with a bool type parameter.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/of/fdt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Rob
