Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8117527A13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfEWKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:12:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46892 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfEWKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:12:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so2547224pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U26hfEnzujUkh3KTuHOe5UmmcDFgXF3e4TaLMOxdmfM=;
        b=Ib+KgVqLDpT8MvHzygIpqSSllS0TetYaVrP7XgrFpZ4tAShr0RURzzglj6REWk93xQ
         WFFRiSJWx59+AH7KQcksdZE8FgH+kZ4UVcuDsg2fotamDs7PGww2jKz9UEuHZR4Ksluv
         BOuS0Q8pCI9SVeiK7/cYpZjkjBdon2Ib5kZ+pHSwkWt0y3CT9dSzcH2kXMpaKwjh90RK
         FG72cyNM327E21YkXcnhGrF3rgDAXbxiawmFFgR4JG3D0Qb8/Oc+O/0XxvPYKZkxu/9l
         VcXp5xzH2rgeygra1FJvVKVIVPaEJNrZMrr7BEDNsPl+9ZZaPDHjsFKtOn/guPNa5maa
         vuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U26hfEnzujUkh3KTuHOe5UmmcDFgXF3e4TaLMOxdmfM=;
        b=NdcVrPfCAF/6OvnGslKKQOTALLmNNhIpJdM7mvxbCuVRXTXAo1kWpahC5LfPMyAiD/
         ncyiyepAosAnOwjrIsx7iaGzSILcV9kd5tdmtwmPtniVernfXzd1+q/ppPSjdTjO6n8J
         oLsVAKAOUZiypozGoi8Q0wUHnH0fJ454xdwdn5Ciz82w6jAj44+amonScbivpQyrf1hi
         lfnURiA9hjYWsEgsnIeHnk0KcD0u+Kwg8UOC26axqyuBT8SXFAmVSrq9Q5fJeYpDyXLl
         CpnxACLm7RtaO/6mud0FFv6oXACI1iY2oGaFieoLRBKmE5Yc0FmFuj+RBhfbOXp9V2Lv
         EPRw==
X-Gm-Message-State: APjAAAUbOvGU/S0O+qpgOPH/wcqgWpQOZ5lOgsHNtSqAXnEAy6WbNtLN
        1R/rlbXpGHTAFh5AxZnx5Jg=
X-Google-Smtp-Source: APXvYqySDuPT7a7gghksq1od9CJZ2r1xxtVRGBUJt3XvoOYsZJiD4Eloj5sq2wLjCZ4i0lkxTdmMPQ==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr14867003plt.219.1558606335864;
        Thu, 23 May 2019 03:12:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c185sm32062477pfc.64.2019.05.23.03.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:12:15 -0700 (PDT)
Date:   Thu, 23 May 2019 03:10:56 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Message-ID: <20190523101055.GA28470@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu,

On Thu, May 23, 2019 at 09:53:42AM +0000, S.j. Wang wrote:
> > > +     /*
> > > +      * Add fifo reset here, because the regcache_sync will
> > > +      * write one more data to ETDR.
> > > +      * Which will cause channel shift.
> > 
> > Sounds like a bug to me...should fix it first by marking the data registers as
> > volatile.
> > 
> The ETDR is a writable register, it is not volatile. Even we change it to
> Volatile, I don't think we can't avoid this issue. for the regcache_sync
> Just to write this register, it is correct behavior.

Is that so? Quoting the comments of regcache_sync():
"* regcache_sync - Sync the register cache with the hardware.
 *
 * @map: map to configure.
 *
 * Any registers that should not be synced should be marked as
 * volatile."

If regcache_sync() does sync volatile registers too as you said,
I don't mind having this FIFO reset WAR for now, though I think
this mismatch between the comments and the actual behavior then
should get people's attention.

Thank you
