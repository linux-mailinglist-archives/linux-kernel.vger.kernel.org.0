Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F149182A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 01:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfEHXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 19:17:20 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38811 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfEHXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:17:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so346217ywe.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0XmE/SSKgdB2Zi6D0Xro94Z8cgKXXoHmAWbL6G9FWo=;
        b=sLmnrLoj9lksRIXKKwys/IS3j0vPyEkYExfwLWVWdBx4HZSJVlsq6V+Vcf0ziNQQXz
         tLNKweEYQZF5GPp1himBK4SukfKMRv8LNyieGXS9Q4p1HiRGZOSAgzaLM70MkdANCFQw
         AQoOZauRkNQ7f08wPTDIbVVbeXycI6ItQ4bsLu4BBd48f5j66b4Q2cy4cY30dpXqvtmI
         3rDnWpAwEynr3nOGBGWDrWG+3tscb8+2mNShKm9w2EsL4pzymELY3CkHRmw95lrldL7E
         m6zskT1VxOvRzv1Bisnr3WAbliDNqSKsBQDpuoy5IoynKxtd6+D8jt/dxoaccO1izrH7
         GMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0XmE/SSKgdB2Zi6D0Xro94Z8cgKXXoHmAWbL6G9FWo=;
        b=Qkz6ur8nQw/0LpfSvRATcKaPeGLD8zWcT8cU9ZgkUUJnXnlVuURSI5wXbzEd5TkTYu
         Jn9FJbkriMzOGK3nC19ilVHx8p7bFyXkCzyw7ffkm+pbTBN3SYKd2BeyJdVAdryL1E+i
         pncfc3YGaOZhOl26CYRb85WIgytM8mhn2LLZvP/J254d7eRaVMiwHeOSw76DARannP7w
         m/l2Lj7lGF/t9w1KvEFWnQb1cSBeR6GqZWEnP1ufOwReNHsIG/6phBNq5L+sp+hQnmzr
         P9z2K6xrs9/zXcHSqZK4OOFcdKAyYXlc32k59rlx4zsDK9+2IXBTubJ9jZolAvFmczE3
         fzXw==
X-Gm-Message-State: APjAAAVrUGW3xpfZjp787yBQKXV3c/64/F+yGHs8opFL7TgrKLgPkrGu
        UKUKF+2JIQHmUQlxWBSyyY6FWQ==
X-Google-Smtp-Source: APXvYqwCScrOtsn/r0nbplNIVpXXh8yEgVNfGi8tKe9k+OX0Y8w8/cROWDlp9BASceZ1pGqP2kWGog==
X-Received: by 2002:a81:170e:: with SMTP id 14mr232136ywx.238.1557357438787;
        Wed, 08 May 2019 16:17:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id v128sm110717ywd.24.2019.05.08.16.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 16:17:17 -0700 (PDT)
Date:   Thu, 9 May 2019 07:17:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        xuwei5@hisilicon.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        agross@kernel.org, david.brown@linaro.org,
        linus.walleij@linaro.org, liviu.dudau@arm.com,
        Sudeep.Holla@arm.com, Lorenzo.Pieralisi@arm.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        guodong.xu@linaro.org, zhangfei.gao@linaro.org,
        haojian.zhuang@linaro.org, cphealy@gmail.com, andrew@lunn.ch,
        lee.jones@linaro.org, zhang.chunyan@linaro.org
Subject: Re: [PATCH v2 00/11] dts: Update DT bindings for CoreSight
 replicator and funnel
Message-ID: <20190508231706.GA5840@leoy-ThinkPad-X240s>
References: <20190508021902.10358-1-leo.yan@linaro.org>
 <9c56323b-7b14-c662-b824-ed60fbb1638f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c56323b-7b14-c662-b824-ed60fbb1638f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:29:12PM +0100, Suzuki K Poulose wrote:
> 
> On 08/05/2019 03:18, Leo Yan wrote:
> > Since the DT bindings consolidatoins for CoreSight replicator and funnel
> > is ready for kernel v5.2 merge window [1], this patch set is to update
> > the related CoreSight DT bindings for platforms; IIUC, this patch set
> > will be safe for merging into kernel v5.2 because the dependency
> > patches in [1] will be landed into mainline kernel v5.2 cycle.
> > 
> > In this patch set, it tries to update below two compatible strings to
> > the latest strings:
> > 
> >    s/"arm,coresight-replicator"/"arm,coresight-static-replicator"
> >    s/"arm,coresight-funnel"/"arm,coresight-dynamic-funnel"
> > 
> > Please note, some platforms have two continuous patches, one is for
> > updating static replicator compatible string and another is for dynamic
> > funnel change; and other platforms have only one patch since it only
> > needs to change for dynamic funnel.
> 
> This is now misleading ;-), but that doesn't matter.

Oops ...

> For the entire series :
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for reviewing!
