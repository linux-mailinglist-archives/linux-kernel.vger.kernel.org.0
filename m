Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14BD18FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEIRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 13:52:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38646 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfEIRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:52:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so3526484qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lH72M3Hita3vNYjhWmRQRabLMqOvistLOPTMK/cvq/8=;
        b=I1mJdpfbFLz8X1Ere2zK8JTY6yohWapqgzinFYh1S0T0g5CBPXRy4AqKtxHugAb400
         VgltN87HyHfrTWAzZU4UZ+5Z+2/bV70PtBEJnAqwWdcbdKt3Rp6m80Q7t2LbgeN7AS3I
         2+QVtb8ZSjb1eessV0ZinKvpiXNS7pbKWZgDekOTjBef+iV5tIvkDX7VT+vDOOInFD6b
         GtSAJuu1iyxHjJdrxlmbRjzejXUaBGXLotHLZHbw29c1F+s77qzmuuJjl0dz4XvrfQpu
         WGycMD+k4ueRE87qx/bA8gU19HQlcr2oVEuZPNelMMz51LR1A05SzBqIFCZxeFKxBOAa
         xJvg==
X-Gm-Message-State: APjAAAVesB6kTO7v3pNMnq3JXqa143Wb3VriLdEbY4fyeDw814iVrbKm
        S2tzgQFyvF+Qb/nNgOQ4eSu/EE8Z1XQS0Q==
X-Google-Smtp-Source: APXvYqw0FZ9lKaB+gI059RTM0inBmVqfBSEu4Vf/THKD4Xq3OmOyEYrjO9XIK0J+/E8PWNq09QAOMA==
X-Received: by 2002:ac8:2bb9:: with SMTP id m54mr4986179qtm.303.1557424367029;
        Thu, 09 May 2019 10:52:47 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::584b])
        by smtp.gmail.com with ESMTPSA id y14sm1579011qth.48.2019.05.09.10.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:52:46 -0700 (PDT)
Date:   Thu, 9 May 2019 13:52:44 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/4] percpu_ref: introduce PERCPU_REF_ALLOW_REINIT flag
Message-ID: <20190509175244.GA27607@dennisz-mbp>
References: <20190507170150.64051-1-guro@fb.com>
 <20190509165343.GX374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509165343.GX374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 09:53:43AM -0700, Tejun Heo wrote:
> On Tue, May 07, 2019 at 10:01:47AM -0700, Roman Gushchin wrote:
> > In most cases percpu reference counters are not switched to the
> > percpu mode after they reach the atomic mode. Some obvious exceptions
> > are reference counters which are initialized into the atomic
> > mode (using PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD flags),
> > and there are few other exceptions.
> > 
> > But in most cases there is no way back, and once the reference counter
> > is switched to the atomic mode, there is no reason to wait for
> > percpu_ref_exit() to release the percpu memory. Of course, the size
> > of a single counter is not so big, but because it can pin the whole
> > percpu block in memory, the memory footprint can be noticeable
> > (e.g. on my 32 CPUs machine a percpu block is 8Mb large).
> > 
> > To make releasing of the percpu memory as early as possible, let's
> > introduce the PERCPU_REF_ALLOW_REINIT flag with the following semantics:
> > it has to be set in order to switch a percpu reference counter to the
> > percpu mode after the initialization. PERCPU_REF_INIT_ATOMIC and
> > PERCPU_REF_INIT_DEAD flags will implicitly assume PERCPU_REF_ALLOW_REINIT.
> > 
> > This patch doesn't introduce any functional change to avoid any
> > regressions. It will be done later in the patchset after adjusting
> > all call sites, which are reviving percpu counters.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> For all patches in the series:
> 
>   Acked-by: Tejun Heo <tj@kenrel.org>
> 
> Thanks.
> 
> -- 
> tejun

Great, I've applied this to for-5.3.

Thanks,
Dennis
