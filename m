Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC73457B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfFDLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 07:33:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43507 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfFDLdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:33:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so2266695lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASxZDvczStvZaA0VBviKVlooZ7GlgEB3+byQR32kp/k=;
        b=Ev3E4Q5ds8kRtofMeEhlq0dH5P79FuXtW5dzhqiD1UCOjKrYEcvIzNK0DvGVKlL/gC
         5hnLEsHWJJ8tVkSakD+W6TtRImmxmO8RvgRqp9+T+XAXrUiuhxGaSb06RGJbhfp7dFLR
         raODvceKMuOyY7COUAYvuHPNApTFJVK8fj7kUzCoiK2JLVj9irK79hHIVJONadMBJMpi
         mlrUgWIiIQ75wXya4DwCE5fDsM2pfnf1Iy4GpN4V3VQ01xvQ/tUdNhP/uDMjGEYWAZH1
         k8ko+TaCwwEnUH8a0NLoFKH6w9Ue5Zn75Ec7eWCiNvPb2Jy1zeiH2QnqUJu7+Q2iUGi8
         QHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASxZDvczStvZaA0VBviKVlooZ7GlgEB3+byQR32kp/k=;
        b=rmRn29NLHeruOgh6EAIw67cLtJwNflgtuvK1HnKUPO99030HOOGzOa89KGpoFolq3g
         KnhCsOnRtbwiXKAorigvIl5xVp5xhFzlbzZ+iiLLXU8AQpwOMrPpvwD8vsWz8m352o2A
         HTzx48XC1UOw2w+M+ylp4KRJsj6FGbgLsUXibB4F3nN3ScTYbOS7v4K/6JJMmx1aKo2i
         24lLN0cZZxRn3p8gyDO8kvEi8zIQCB6mawJn807BaTQX/XC1PgP9l7f0b9zk4+laxkXg
         h1zj6v39pEQLbUiSaSgjGdWRFaye7zjB0zavPehlWft/yEMRVUmbIuBKQGb/PasX7QuO
         yk9g==
X-Gm-Message-State: APjAAAVO9p9mh0CT5Tb1LxyYSZjyP03hI1Zu8dWfkZLjoI48AT34vwfT
        JBluEI2QSCnJIdKR00S5iuyUNA==
X-Google-Smtp-Source: APXvYqy2ewn+TJ31z8SQ+T9aaETF2ZblqkKMNvIWZBN6vbRH3jSlLfBfGhfFImz0Cn/uFgotAnyJlg==
X-Received: by 2002:a19:f601:: with SMTP id x1mr16378550lfe.182.1559648030291;
        Tue, 04 Jun 2019 04:33:50 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s19sm293564ljg.85.2019.06.04.04.33.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:33:49 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:33:47 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Message-ID: <20190604113347.GA13029@centauri.ideon.se>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
 <20190529163155.GA24655@redmoon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163155.GA24655@redmoon>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:31:55PM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 28, 2019 at 05:57:07PM -0700, Bjorn Andersson wrote:
> > This series adds support for the PCIe controller in the Qualcomm QCS404
> > platform.
> > 
> > Bjorn Andersson (3):
> >   PCI: qcom: Use clk_bulk API for 2.4.0 controllers
> >   dt-bindings: PCI: qcom: Add QCS404 to the binding
> >   PCI: qcom: Add QCS404 PCIe controller support
> > 
> >  .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
> >  drivers/pci/controller/dwc/pcie-qcom.c        | 113 ++++++++----------
> >  2 files changed, 75 insertions(+), 63 deletions(-)
> 
> Applied to pci/qcom for v5.3, thanks.
> 
> Lorenzo

Hello Lorenzo,

I don't see these patches in linux-next.

It appears that only Bjorn Helgaas tree is in linux-next, and not yours.

I think that it makes a lot of sense for patches to cook in linux-next
for as long a possible.

Perhaps you and Bjorn Helgaas could have a shared PCI git tree?
Or perhaps you could add your tree to linux-next?
..or some other solution :)


Kind regards,
Niklas
