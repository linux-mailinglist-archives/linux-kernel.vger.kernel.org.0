Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C794DBCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393196AbfJRFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:08:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45587 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJRFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:08:23 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so5883240iot.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kdaIg1bmKvTuY1siBcuKtqxXXbNP+bO8qDJ8qtoHLrs=;
        b=alw6W5GQyFhcnDqfvGuR8ILsbtiVCq3gFNSbsc/XVCP/pbXcnDdCPf5Y8lhD+ZGjD3
         k70D30BaJyuuRDhkvJ+MYnPNjUNkDzOJObYzjLN9WjpGG6uwhVPce/MNyj2Gb3jpNE3N
         x12yIHzuETRu1nJA+I1boHpOvXikuy3MWOAVWs1ir7esAwfr2HFoVhDI34y1EhvUzbT9
         P313Uiqsbz9BN595bX4qtsM+rAYBUE7+jnI3adKsIbO3f+d+7d/aVjrY+PTr58X5PRO1
         dp2o6liHqfUAeu2MWjv+rB5i8j6bNLoTljIC3yYORBqQE44NGIUf6xD6JGxF0pKfbJjr
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kdaIg1bmKvTuY1siBcuKtqxXXbNP+bO8qDJ8qtoHLrs=;
        b=YcEBX/7IcfyImPd39O3K9fa2hPOGWwvhuNdBmN+eWIe8TKtQcFEQKPXu89Mlg5xcdT
         e5ARbk42WIGmv7DzvDTmYYVDbmy/9mwl0aygFYSw7f4o5kUF5JpWRQd1rcv3czgDI6zg
         ePGSCxtGGgiejdid1H3Um81Ql8Tm3CTBLotzcl/vNQKHltAQrCYbDu54ZE/O6tGNfrIr
         A8SGId1raqAI7u5E8NeGk+TzXDvLU6YjpqS154kTi0qziIacz3YplDqbaY3dsI8SCtPU
         yS33CJy8ZbjAG6RHUab8Iwm/zCVWbwWkUqEkiYdmoWwptd1lwUzk15xZJVi3r//S+9bi
         r3TQ==
X-Gm-Message-State: APjAAAUkCOxhooBu0Vje/5VWULuwshiLIAOdFJ5GZIrQkeaUZMS1p7Ct
        30CW+8nmCfQ/+C46H3jxsb6R0UqJEBM=
X-Google-Smtp-Source: APXvYqz+VSmPYFEehv0u4XSaZ4gGq/6ly+snn34TQolYszWZAPowUNkcflBsfouOqC+vsTbwwiqpnQ==
X-Received: by 2002:a5e:dd41:: with SMTP id u1mr6869403iop.112.1571373570538;
        Thu, 17 Oct 2019 21:39:30 -0700 (PDT)
Received: from localhost (67-0-11-246.albq.qwest.net. [67.0.11.246])
        by smtp.gmail.com with ESMTPSA id 26sm1545703iog.10.2019.10.17.21.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:39:30 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:39:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] riscv: ensure RISC-V C model definitions are passed
 to static analyzers
In-Reply-To: <20191018040619.o3qb5fyj4qdevwoe@ltop.local>
Message-ID: <alpine.DEB.2.21.9999.1910172138320.3026@viisi.sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com> <20191018004929.3445-5-paul.walmsley@sifive.com> <20191018040619.o3qb5fyj4qdevwoe@ltop.local>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:

> On Thu, Oct 17, 2019 at 05:49:25PM -0700, Paul Walmsley wrote:
> > Static analysis tools such as sparse don't set the RISC-V C model
> > preprocessor directives such as "__riscv_cmodel_medany", set by the C
> > compilers.  This causes the static analyzers to evaluate different
> > preprocessor paths than C compilers would.  Fix this by defining the
> > appropriate C model macros in the static analyzer command lines.
> > 
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > ---
> >  arch/riscv/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index f5e914210245..0247a90bd4d8 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -47,9 +47,11 @@ KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
> >  
> >  ifeq ($(CONFIG_CMODEL_MEDLOW),y)
> >  	KBUILD_CFLAGS += -mcmodel=medlow
> > +	CHECKFLAGS += -D__riscv_cmodel_medlow
> >  endif
> >  ifeq ($(CONFIG_CMODEL_MEDANY),y)
> >  	KBUILD_CFLAGS += -mcmodel=medany
> > +	CHECKFLAGS += -D__riscv_cmodel_medany
> 
> I can teach sparse about this in the following days.

That would be great.  Would you be willing to follow up with me via E-mail 
or mailing list post when it's fixed?  If so, then in the meantime, I'll 
just drop this patch.


- Paul
