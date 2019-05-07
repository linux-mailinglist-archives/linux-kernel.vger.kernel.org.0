Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6516B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEGTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 15:31:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46584 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfEGTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:31:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so4681715pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 12:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BHeCC0KibMuGQaQ13pNV0ld+sIiRc+E9RP4V7KGKCA=;
        b=Q1YrYJpXT9MBan21dF1kPXPMxK+4UC9tm28uThoafTKqnmyq8UBTjS54hj5rcsldY0
         P0D2YT0saOyxdIIHlFwb8nU0jKsNlb8yZqeHCiwDPPm+wbGLfxCImHcyCjYwoQTrAUl1
         vymh6m06u/85Az/Mx4uPZ1Aw2pFYdS8uIIjAV6GlXPl3gCx+9BH3YnOgrZNqakzVCTqY
         lZr8zbiJm2Ldew5hcuDyoJw51sNR8aHeycRR2FrUklpSitDI5zLcCr9uU13R2VP6ktzm
         8IiNjMbbaMrocDZ1Cd2x05h/MHIL6WqvhD4uWlGnID9mkvP4PO6ddor/MulWdZ36Gr8k
         6/Bg==
X-Gm-Message-State: APjAAAU2hkJG2F3PCoUCRb9kA3jlKFWejjCI6PPqwrnHq5B/0PUu/Ykl
        bHKKUWPpRSw3VI4+f5//HEzyaA==
X-Google-Smtp-Source: APXvYqzBLzsZYmzhOtRcPH8guMtfDVgap2dm+RKSPAKoX63LYVwZrff17koc4QYNdq+YQtiKmPRMzg==
X-Received: by 2002:aa7:8dc7:: with SMTP id j7mr42767214pfr.82.1557257516723;
        Tue, 07 May 2019 12:31:56 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id q17sm35415411pfi.185.2019.05.07.12.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:31:55 -0700 (PDT)
Date:   Tue, 7 May 2019 12:31:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Message-ID: <20190507193154.GB30078@archbox>
References: <20190507170257.25451-1-mdf@kernel.org>
 <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

On Tue, May 07, 2019 at 02:11:06PM -0500, Alan Tull wrote:
> On Tue, May 7, 2019 at 12:03 PM Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> >
> > Fixes the following static checker error:
> >
> > drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> > error: 'eemi_ops' dereferencing possible ERR_PTR()
> >
> > Note: This does not handle the EPROBE_DEFER value in a
> >       special manner.
> >
> > Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> > Xilinx zynqmp")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index f7cbaadf49ab..abcb0b2e75bf 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> >         char *kbuf;
> >         int ret;
> >
> > -       if (!eemi_ops || !eemi_ops->fpga_load)
> > +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
> 
> This if statement also happens in fpga_mgr_states
> zynqmp_fpga_ops_state(), so we'll need this fix there also.

Good catch, will fix in v2.

Thanks
Moritz
