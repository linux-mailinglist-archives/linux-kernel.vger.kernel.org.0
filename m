Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00C3B7892
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbfISLhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 07:37:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41695 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbfISLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:37:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so3228135ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfwOF61OoR8M1e7Qa+ZZMY90GfOvjcgebJlSOMqBsC4=;
        b=tmRUxVccdHoZq6Alk7EDBGRJpqo7ps/lgBfHnrJDWLPzw3T14K2tlvbdO7/V1Xj+by
         X2O61E9xCs+4s5w+xOFaTY0XG52MIPGZ97lDfuwNbeq8KGuGHibjkgjq+KJ7vAA/J+3+
         Lwav++NhEBRlYPOQRN879gdJ6V8Oraakm6rPEVhr4HPWixCF/6y8s3iJcr+67KaBnvjl
         OhsyF7nEdI95+w0AW8qDdZwyX6Ckte34WoeIzgq/kW0lC8BSJvhMuNsC2GguDwD+mjtq
         ke3R7EMTP1RryZmqKPgPAkQOrRk7+eSafwLdrGeTlyewV/fxm/ul4OgvJn/F76Yj/rCj
         ixiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfwOF61OoR8M1e7Qa+ZZMY90GfOvjcgebJlSOMqBsC4=;
        b=hptrIuOqX1PX2QJ9EQ5qDHsiMt17qgwGlQRT6C0h7P/GYd1xorutI1xTGt9ea4JjWe
         4jhTWE8jYXU4qd2J4O0uQ0+tEYKZjGUXvz1RcIdTWpz3USXV4UcAvgi1qB7mQiJOiC7u
         Y1XkY/egtXFdzAw7hjqgk7y1seLbyOgt7v1goZj+xrpfZ1ogBRZ5eG5azJxlMM3Mcniq
         RDD3mHiWfs6FmsJ0HKKb3COCOCT58o9+92lda4MUp8YqfwDkPEETNo+k9++BHLkx6qGL
         /K1zkKDEYgvd0rfAxd/4QS8kI/L46ltTAmJzosD0j0e0tynzJBAwr+QEtVSYhBzlJ6Fi
         cr8g==
X-Gm-Message-State: APjAAAWotezIORPGmw9cQNUngo3tR4xAZZ+Q8YRYt6yKpWcaubAihdsv
        dOtyWvv4Lr6dpOy5UuZXTpkSiyg3ownXUVbVJBgRyYMo+Ko=
X-Google-Smtp-Source: APXvYqynVPBOnd/PXWX66hg1JF9lfC5l9S4O/FDzyttTjdhHtCiVN8anWr3f+Cmi+6Yv9m/24fve30Dlmgd04RambWY=
X-Received: by 2002:a2e:8184:: with SMTP id e4mr5231120ljg.240.1568893070642;
 Thu, 19 Sep 2019 04:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190919102319.23368-1-philipp.puschmann@emlix.com>
 <20190919104526.29851-1-philipp.puschmann@emlix.com> <20190919104526.29851-2-philipp.puschmann@emlix.com>
In-Reply-To: <20190919104526.29851-2-philipp.puschmann@emlix.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Sep 2019 08:37:50 -0300
Message-ID: <CAOMZO5BNvejzMxhZiaJ36E5XES=uVNn_G-+fXQfStzy5W+YbsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dmaengine: imx-sdma: fix buffer ownership
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.or,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, Sep 19, 2019 at 7:45 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:
>
> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
> buffer, when 0 ARM owns it. When processing the buffers in
> sdma_update_channel_loop the ownership of the currently processed
> buffer was set to SDMA again before running the callback function of
> the buffer and while the sdma script may be running in parallel. So
> there was the possibility to get the buffer overwritten by SDMA before
> it has been processed by kernel leading to kind of random errors in the
> upper layers, e.g. bluetooth.
>
> Fixes: broken since start

The Fixes tag requires a commit ID like this:

Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")

Same applies to the other patch.
