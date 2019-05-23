Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87028E10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfEWXvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 19:51:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41721 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbfEWXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:51:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id d8so5662759lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fhBZncJ2MpAJBlQB8zRObQZP1s/1ENOk1yYHyMaqLDc=;
        b=CwBpnrcYLEefMJFuxPFCRN4iTwN5WamdydpeCsRT71D0rSxVvB/+yh7YpZYxb0y/st
         5uIc3/aNLUiHEsPWzhZUOxFhlgrSOswawfDUiHAURx0ICrBTwtC4fGeRzeK+bQ9fxzO2
         AUqaFa327tG+7cjZlXV0TpFwev6e76lpur/kCU2/RB8eCN98srXtjhNhv3+3AfiHhVYt
         VOUOoJ5Pj7J83Mghc5cBnVxIjhyDuj/U6gaRNjvAzyqixszSffdBW835Yysw9I2gNvPW
         YuzNr3ULFt2eu7hOGS1lkEYi8akIZfNoRkPNDZvD25cMEQQZ5axf+KYvtbiHXAS7lkDn
         qbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fhBZncJ2MpAJBlQB8zRObQZP1s/1ENOk1yYHyMaqLDc=;
        b=lutgcQo9i2PCExsx4KXacj2lUy2JCK7lDKvSr7dUTBslG9XS4o5d24MBJJJulDUSvL
         XCsjAnjNDwpzOioj0XA5R004FX1kQxyFDrqPFIf+RC/+NnM3nasptd/lU1Bcby6BIP15
         VzkfV1F6akN7BG370bMIlvxY85j8GV/38HfOW8x7Iuw306XnDC0+7XnbvdVAH914rJ54
         UT8MkQ03QKqQKueau8Eu+H/mzzE8rOWk8z0+OKWNedU1IHHgSvee5twE4SdWxdLeK4RW
         wZV2KuUef3ifQYyS44SLgPxPq4T10LWglbQrMVoBgAr8Q18dfx+c7uYSCPlAtefsS/ts
         J8Ww==
X-Gm-Message-State: APjAAAX8EP7afjQ8KFrvcDwcKiC9wVPADqJQKsFxJK5Ma4G/5Q6avb1F
        4y/PiOzxuMe8HVy1QieDmt1itM988ulHk4vEM/dJEA==
X-Google-Smtp-Source: APXvYqxOUSWUQ3jLt0ClnRsVTHOlGj4gBaUGVeolp0BKGbX6O77PYECRjhSrrEERuRToBxdhUEoYFivoa6PmBkssuh0=
X-Received: by 2002:ac2:4286:: with SMTP id m6mr7494929lfh.150.1558655461095;
 Thu, 23 May 2019 16:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 23 May 2019 16:50:50 -0700
Message-ID: <CABEDWGy8PhHqqRPpZjVrd3VtwxmtxV+Gs-8442e9EvKjFQLELw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Clear BAR before freeing its space
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gustavo.pimentel@synopsys.com, wen.yang99@zte.com.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu


On Thu, May 23, 2019 at 2:57 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
> would be cleared in pci_epf_free_space(), if called first, and BAR
> would not get cleared.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 27806987e93b..f81a219dde5b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>                 epf_bar = &epf->bar[bar];
>
>                 if (epf_test->reg[bar]) {
> -                       pci_epf_free_space(epf, epf_test->reg[bar], bar);
>                         pci_epc_clear_bar(epc, epf->func_no, epf_bar);
> +                       pci_epf_free_space(epf, epf_test->reg[bar], bar);
>                 }
>         }
>  }
> --
> 2.7.4
>
