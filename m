Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8AF8956
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKLHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 02:08:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41777 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfKLHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:08:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so12673792pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zK78FnAOmv3761AstDJXelt5t5xR2XRW77fvH5frBqE=;
        b=EsEiW+5kyUCExkdffD7tH/HTw0VFRrIgj4HiXF8XKU+s8+YxXn15j5ZruCiQly6Mdb
         q7GX8wD3efvZPwCoSj7sgXxq6EuWXVchXS2z7IqZ6Qo1NVyCKPGhME4O6BACvUwJRwkm
         2N9+FGswolsCy1Dl5C1Xua2F9aQHKDYZEPwPr02tW8pUuelj9NQNUcZPBdofEnH1/bTo
         t/3DrJ3shlpgHJGaMlcvL9OzVafIt6V5fKWM/ObUzBh08LU/lTr5ciKtaj0wtFx0hyhz
         OvdFweNPtGmC0DTkjjKIXg3EFo4gDiMVrNmpQDThE8CG1+yZBKI7nLU7tAdZVnqhxFED
         FQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zK78FnAOmv3761AstDJXelt5t5xR2XRW77fvH5frBqE=;
        b=a+EIjpB5kPyWaoI7HZDQ5PqNlBanSbpOSGLLPVg/2NvppXxAiP6iTNUlsXDDqgZNC5
         QbT/xJzYVYuBfWAWrJYyYC6tMOXdUkdK18WWL1b9fbVxVjbTO8PjsVvy4bnobVW7FMC4
         A2Y2nOz8nr8AI8tkKI6FQp+zAIKCl5hgHygjBXW8j3KVn2WNUUagOunhj7MC9zGMQWjQ
         6KXTPO4eYc4ffsiv6CdguaYMvz2q2Z+PKnOGcDd1X+MJY6meyZuOKQdcOTfw+RKiecEH
         syh2Jwm248DxmfOIYiNw8ZieN7XXPlgeU2dnh9bjYLFmq6SIG9izrDXYJ0bFItJNMShF
         UjWA==
X-Gm-Message-State: APjAAAUvYdKmmzTiY6gDciMp8SsWjMVxOHQZn+fC6zf4qgdcfvZYaY5W
        uanrpB5nEQCRNB6kjNzVcDiFsA==
X-Google-Smtp-Source: APXvYqwE4C2wT2seRucgaO6gP6vKq4NKee7ygjFHmTDw+i/soL0w6a48b/EcGkDtS6QcPMZ7gFUutg==
X-Received: by 2002:a63:a05c:: with SMTP id u28mr35047901pgn.333.1573542527714;
        Mon, 11 Nov 2019 23:08:47 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o1sm15092669pgm.1.2019.11.11.23.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:08:47 -0800 (PST)
Date:   Mon, 11 Nov 2019 23:08:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v20 3/4] rpmsg: add rpmsg support for mt8183 SCP.
Message-ID: <20191112070845.GR3108315@builder>
References: <20191014075812.181942-1-pihsun@chromium.org>
 <20191014075812.181942-4-pihsun@chromium.org>
 <20191111231023.GD3108315@builder>
 <CANdKZ0frU9+dRYeMaJjjKm6emxj41c_jBk_RX3G7bXn_oXKp4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANdKZ0frU9+dRYeMaJjjKm6emxj41c_jBk_RX3G7bXn_oXKp4g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Nov 22:42 PST 2019, Pi-Hsun Shih wrote:
> On Tue, Nov 12, 2019 at 7:10 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Mon 14 Oct 00:58 PDT 2019, Pi-Hsun Shih wrote:
> > > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
[..]
> > > +static struct mtk_rpmsg_info mtk_scp_rpmsg_info = {
> > > +     .send_ipi = scp_ipi_send,
> > > +     .register_ipi = scp_ipi_register,
> > > +     .unregister_ipi = scp_ipi_unregister,
> >
> > These are exported symbols, so unless you see a need to support
> > alternative implementations in the near future just skip the function
> > pointers and call them directly.
> >
> 
> Yes there is request from MTK that they do want to reuse the mtk_rpmsg
> driver for things other than mtk_scp, so there's a need to support
> alternative implementations for this.
> 

Fair enough, let's leave it like this for now!

Looking forward to the next revision of the patches.

Regards,
Bjorn
