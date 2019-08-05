Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9C81FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfHEPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 11:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEPLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:11:43 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1363021738;
        Mon,  5 Aug 2019 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017903;
        bh=RA39kesfjwZmG107yJcmHSvsCxQDBkR/lv9jiI8plOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJenClJ4US3+92hEuQdRAkUSkjBGqoSkp9mCiHbuvyaMpCOqRK81mVym7djZDHIiC
         Z0TMQwRDvWuTVaMmOEU/n53XG+1LhiTsObBd7F2H1vW6M9i/5C+E8vbDTAAvV0KosD
         /bwrYGIJ+DzwwC7vNDuwOx71/p3HQNWlnWZ8VGjM=
Received: by mail-qt1-f174.google.com with SMTP id l9so81201214qtu.6;
        Mon, 05 Aug 2019 08:11:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXb/fbCASe4R9fR2Gvfbeg2tZnDptljsrrHGrKn2KQTIYsU46Yh
        KeSheLiHa0Y6Du3lrEzY8cyt4cQ/W+BntTAhIA==
X-Google-Smtp-Source: APXvYqxVq5oF5EFOo9OXaEyDHPpxJaHA1vkEHqkpeisiCku1CrTzPjnWizZ73Y8FxtYhg1cFcBxnGhU1I8m1M1B28aY=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr111965592qvc.39.1565017902269;
 Mon, 05 Aug 2019 08:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190805023953.11231-1-zhangzj@rock-chips.com>
In-Reply-To: <20190805023953.11231-1-zhangzj@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 09:11:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXTK4RRuecX6K74qkw6mVUDzDDiKWbZN79vGejrv1XWQ@mail.gmail.com>
Message-ID: <CAL_JsqLXTK4RRuecX6K74qkw6mVUDzDDiKWbZN79vGejrv1XWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: Add Vendor prefix for Beiqi
To:     Elon Zhang <zhangzj@rock-chips.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, luowz@beiqicloud.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 8:40 PM Elon Zhang <zhangzj@rock-chips.com> wrote:
>
> Add devicetree vendor prefix for Beiqi.
> http://www.beiqicloud.com/
>
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
