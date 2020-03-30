Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F9198825
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgC3XWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 19:22:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45659 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC3XWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:22:30 -0400
Received: by mail-io1-f66.google.com with SMTP id y14so2637385iol.12;
        Mon, 30 Mar 2020 16:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIWn5Ab3uVFI3qxzD5maLCo29537ULIcC0kUHsUxsj4=;
        b=TsDpzzgaEeMwkH9K3Cvf50j/0Jd0vAHBCk28hNH/Jx8Jmk89bSsXkkh4MtcfIzDcW5
         QBzoQg3Ha5+YM3cI91CiACFlfn5s8Y0KYU3MNMimXYq1ymcOzWPiNaLAnyiaVqBzim4K
         IO0LeXf8gJUCVpgERT+cOL1TjMMnV2CVvZaNLhvTm3QFH9h7Vw4/IwKnauKdGbJiVP9M
         VJmo3FQTABfZiKkHt3xIaourZ4RFD1wID1YpbidD5d5IifsC6BOt8oPZ1bvXS634QGxl
         ws3Exfgzuj4OGz9rcRv6cyp2K+ge1ZfoFjb/P9mP/N4yDOOfu9HFZdebuUCop5e28MQi
         DrSg==
X-Gm-Message-State: ANhLgQ1Shz3h0rDVnygmmYmCYNwVHu8MpTBsOdgq6iPY0lbWSOG8M8fR
        iWwng6UUsIAoCcWi2lsHCV9v260=
X-Google-Smtp-Source: ADFU+vuBgwRJJLNw8wMfUkmeopLiMj54ov/9v+GIxteeKCwFkd6CF3WrVK8pBuSYUYonDOKZAgHWSA==
X-Received: by 2002:a5e:c70b:: with SMTP id f11mr12837586iop.28.1585610549351;
        Mon, 30 Mar 2020 16:22:29 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f80sm5419367ild.25.2020.03.30.16.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:22:28 -0700 (PDT)
Received: (nullmailer pid 19439 invoked by uid 1000);
        Mon, 30 Mar 2020 23:22:27 -0000
Date:   Mon, 30 Mar 2020 17:22:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] of: of_private.h: Replace zero-length array with
  flexible-array member
Message-ID: <20200330232227.GA19356@bogus>
References: <20200319231058.GA18540@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319231058.GA18540@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 18:10:58 -0500, "Gustavo A. R. Silva" wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/of/of_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
