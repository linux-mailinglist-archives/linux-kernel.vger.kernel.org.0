Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9E15683B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 01:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgBIAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 19:19:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34782 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbgBIAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 19:19:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so1760721pfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 16:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sstt02xcY3tWivWVDeG5iBViBhgDcepwGoXIUUCRlj4=;
        b=BPbxcNj6SmiZxSbe75MPs5wgysL/4VNC8ywY9+pPcNVd5S2M8SRDxNwfWfTJyj150R
         WQNu4RB/bLoGYnZ1Nd3Qpa+8CuWSZ/wHtK7Cc+qKa/R9nhfZ0JQlCMUgiXW/yzDslyH1
         qlJ7tJ99NjX78Y25d1bG98cJx0SsfoCyM6YYa9vTS3kbi/yJHYXhFSYRBKBIelZVy2Ke
         0xt6+sGby2W7BOs6AHGa/bFBlKEeUqCFLP2K/rGjPont15exh5IYLTWMj7fmOThiUkOR
         vmq0E+9ag/9g55KPMYeaLVEVsKewAGhZwpFYWX8twWDStuo+6l0p2FiBwqNDAGV6tbCw
         UyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sstt02xcY3tWivWVDeG5iBViBhgDcepwGoXIUUCRlj4=;
        b=hscSRPMTc0SR7G6gn2T9Jyb45SCUs3+MsgBA5coVo+L0XPgcR/mMLN5sTUiUGQZObG
         8HaKg7LfmzF5GTwjevV/QFxWI4VB8mDRyEq9+B3OKwaQr1mN47eP9G8c7u3bMAMqfH8h
         izyDBYLTazCKMVC/Q34LdpTPjjKtN10ZscEbGRgZif8YDBL9TFMo/fhcnreD37b1zZu8
         vIaapVAQ6eNu4tKorG9GvqJRe/aLhkCWcah/MylRInc0EiOK0J4d3CRLUi09aZ6Z5BYV
         XhxgqJpCnC5BKbCHrfVWgKuP6TPYQipJrvCm2bIVwwf5RAx7QXGCINeJ/UQUOIq26U/v
         qLig==
X-Gm-Message-State: APjAAAVCmKSIa3dI6NRe6a2eDcOCftAwoWbljPVRZbEPvWSGyct5Y7+f
        4LFOmZGWmfoBhXm9IRssCUj5Xw==
X-Google-Smtp-Source: APXvYqw/gMmQQJ9ir/gx3iHXpaMoj2RQ1ibv3ZsMai6SyfW/JiBS/hZuYBtLZ3iWedSC6HJ3BYXvpA==
X-Received: by 2002:a62:1402:: with SMTP id 2mr6355873pfu.126.1581207564844;
        Sat, 08 Feb 2020 16:19:24 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w11sm7385129pfn.4.2020.02.08.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 16:19:24 -0800 (PST)
Date:   Sat, 8 Feb 2020 16:18:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
Message-ID: <20200209001838.GF955802@ripper>
References: <1580886097-6312-1-git-send-email-smasetty@codeaurora.org>
 <1580886097-6312-4-git-send-email-smasetty@codeaurora.org>
 <CAD=FV=Ux9XjUQMy4zzaz9JxZzyuZJvNB_W9ANzE140W_pDmixA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ux9XjUQMy4zzaz9JxZzyuZJvNB_W9ANzE140W_pDmixA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Feb 11:24 PST 2020, Doug Anderson wrote:

> Hi,
> 
> On Tue, Feb 4, 2020 at 11:02 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
> >
> > +                       power-domains = <&gpucc CX_GDSC>, <&gpucc GX_GDSC>;
> 
> I should note that this is going to be a PITA to land because the
> patch adding "GX_GDSC" should technically land in the "clk" tree.
> Without extra work that's going to mean waiting for a full Linux
> release before Bjorn and Andy can land.  It might be worth sticking
> the hardcoded "1" in for now instead of "GX_GDSC".  That's what we
> often do in cases like this.
> 

I'm fine with the patches using the GX_GDSC define and I will replace it
if necessary when applying the patch - but either way we this is
dependent on the clock tree picking up the patch that defines the value.

Regards,
Bjorn
