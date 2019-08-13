Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0EC8C0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfHMSmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 14:42:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35726 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:42:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so69160399oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JfFAdKP3yDSu1gNfDNgmsT7umfmkTpl2VNpXjzZ5xck=;
        b=N5dR9jNnD0q+2lM6s+HP+eZYAg/eqdrBMuFa2aoycdfaRp6hPQ1r76mAmPA9WFtf7C
         FVeX+9/vZLw/7uirWJK+AMswAYg5iSsrWBzwhZ4s75HM7IYVi9rVMfsEPAc//XbVAaf8
         P+WZF4jW40HC3uAhSCjjp8x12iASCNKu2FLcEddXa+v0wRmGNBiT4Sh5rBulRPTEAKgS
         OT58hSyX4FcyWN4oSmNp1Xcj6hswmOkgsLDGI00QZZwejiOS88qkfT3ZbtrOht9xzGsb
         oBPcCqBkBH0qCvKOOP9lwPWh1OaVSmOI5pQh3+qYcbI7MV9MqxOih+k0PxzZ249JIrDh
         +tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JfFAdKP3yDSu1gNfDNgmsT7umfmkTpl2VNpXjzZ5xck=;
        b=omTE7iAl32VD3f047P3WpZhGC4g89DLyJK58fvVbGFic+3D0QwXlozKHQoWv19QTVW
         CdJHRiPRKM8orSRJaV92Ool38klj16zZBhW1zsEOsWE8wcirxvymMrByr+KbZKCWaA+p
         B4Ag71HQk/uKGTOeN1Kb+X/Cx8LPojnRBnAw/C1FQOJzm8IXSTP14tNJZc7u9nvRtRWT
         I5i62yEEF/nXM7lnCaYPftDUPyKtQylijclqaZcCWX110K7c+WgKDlC/gaJA3PbawHPG
         KSOODwsQ8Vqvmo7E6JCEK44tFVxhyxJqfD4C+Z07ysmeXIiqx6Y6sjHQ4TTxMLH9eIty
         yHjQ==
X-Gm-Message-State: APjAAAWNf6xTKMzZcKsIkwwUjQ61NgvF48E62cspg5bo46CxZJpuKHUr
        z8M364iX+D8sEN4nk6I1muiHMA==
X-Google-Smtp-Source: APXvYqyXdgJEdteZbftC+TJcIScPp+GF+ZzWtMuBywPHiEKat1r09dmv1SgHAm3azSTaqEwZv0TuMA==
X-Received: by 2002:a02:9644:: with SMTP id c62mr39674483jai.45.1565721770066;
        Tue, 13 Aug 2019 11:42:50 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v10sm101180934iob.43.2019.08.13.11.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 11:42:49 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:42:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>
cc:     Yash Shah <yash.shah@sifive.com>, Rob Herring <robh+dt@kernel.org>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?ISO-8859-15?Q?Petr_=A6tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 2/3] macb: Update compatibility string for SiFive
 FU540-C000
In-Reply-To: <CAJ2_jOEHoh+D76VpAoVq3XnpAZEQxdQtaVX5eiKw5X4r+ypKVw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908131142150.5033@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <1563534631-15897-2-git-send-email-yash.shah@sifive.com> <4075b955-a187-6fd7-a2e6-deb82b5d4fb6@microchip.com> <CAJ2_jOEHoh+D76VpAoVq3XnpAZEQxdQtaVX5eiKw5X4r+ypKVw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, Nicolas,

On Mon, 22 Jul 2019, Yash Shah wrote:

> On Fri, Jul 19, 2019 at 5:36 PM <Nicolas.Ferre@microchip.com> wrote:
> >
> > On 19/07/2019 at 13:10, Yash Shah wrote:
> > > Update the compatibility string for SiFive FU540-C000 as per the new
> > > string updated in the binding doc.
> > > Reference: https://lkml.org/lkml/2019/7/17/200
> >
> > Maybe referring to lore.kernel.org is better:
> > https://lore.kernel.org/netdev/CAJ2_jOFEVZQat0Yprg4hem4jRrqkB72FKSeQj4p8P5KA-+rgww@mail.gmail.com/
> 
> Sure. Will keep that in mind for future reference.
> 
> >
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> >
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Thanks.

Am assuming you'll pick this up for the -net tree for v5.4-rc1 or earlier.
If not, please let us know.


- Paul
