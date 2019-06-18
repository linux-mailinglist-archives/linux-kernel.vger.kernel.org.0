Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3A49F49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfFRLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 07:35:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43084 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfFRLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:35:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so8981321lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+aeRI9gH7Nt+4ScPIMUDC2N/RTKJKeWLRoi5znlh1Y=;
        b=TLRAx63y+9/iuvZc7HZ5Bbxji+bKznetpTz81C5NX/1KiBJ9aAh7hg3dPhXc/VEc8E
         aY7esmunh2x4uJR6Lj5rGAyMm9l3xya0NqT1ZiV5OcFahUE+R/6zQMTNK6dYoAyoK4B0
         +Zjq20Tr4tm7P2OxMs6QlGzfzfQoh83i4OLLYlPayMwniFGmsGC1jeTImO55PUgT8JGm
         v7WQv1qXDvd0wGvXegHvttshDuofrS56yZXvhxD7NEb6XSdyPZ/Wq8iYAyJQmGKJjXfX
         91mDzM1+qtDaWYJQPxpyEq11oRDmQbmrQUbQSL80JXqKZkGuyDavULzxsXKi09ToV/hW
         0raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+aeRI9gH7Nt+4ScPIMUDC2N/RTKJKeWLRoi5znlh1Y=;
        b=Jm5MzcecXlJ6OhXqBPTRobPjW8RRDc+7GQlVpQ5a9NDLUbnpPKtaQBh3MR46YxahOO
         dqtHMj6M6GJES+MmE6XptiuZRc6faEHchU2ceBEaxJ58MH60SgNvEM6JvtVrNNPRe3D8
         KdLpccRg85g5UvAAr/WdeE2LDF0sp/jqBU5dXE6qjrKohiq2/tOIfxrfCuekZwMhbV70
         vWlip3XIkrC6Ruv/dXUAlBI6u7UaVGQqZPmrtU/rxrgHrKC7YuCHeG9JEexHCpJxx9cc
         mENSABaG6vnoroI3Le9g7HNr6KYffZHfWv/RvFK7mZmPZJFd2l68YM5rDFHTIroaRyLD
         ADAA==
X-Gm-Message-State: APjAAAXdAMLOnmqZAcbrfeDcN4wbw1oY53TPsRW2xtwo0TnFo4z/2kQW
        8Hx7Hmbnzz602EgxJexf6BHOIYXEDkINvNjUSwjK1w==
X-Google-Smtp-Source: APXvYqxhKrM4omMyzQLzxXnmN0FXTw+DZYa8K6R5TXQB0N5fWRdMtzmU3XWM6NyuGULgrb3PP2rTzlkWZyITrDQ43Ew=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2527640lfh.92.1560857730949;
 Tue, 18 Jun 2019 04:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190613070201.GH16334@mwanda>
In-Reply-To: <20190613070201.GH16334@mwanda>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jun 2019 13:35:19 +0200
Message-ID: <CACRpkdaX66=g7dG7SFkgr5Dwmop-p4qe7ELkn0KERtqVvp0vNA@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx: npe: Fix an IS_ERR() vs NULL check in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Krzysztof Halasa <khalasa@piap.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 9:02 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The devm_ioremap_resource() function doesn't return NULL, it returns
> error pointers.
>
> Fixes: 0b458d7b10f8 ("soc: ixp4xx: npe: Pass addresses as resources")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you please collect my review and send this to the ARM SoC maintainers
arm@kernel.org since they are collecting a few other IXP4xx fixes?

Yours,
Linus Walleij
