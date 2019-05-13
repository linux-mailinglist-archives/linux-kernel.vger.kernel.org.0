Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380801B957
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfEMPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 11:00:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfEMPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:00:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so7334358pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YI4apKyiwzoFZU9dVSAV6s8pxksTddQsWQQ+ARnfARM=;
        b=JBtb+af429BMLQX05LwJk8JyOCUcuisqVMvds2IepDPWQ4T7iQPRmjoxCt+OzbTyZA
         0OzkFc8aVQDvX8kZDPvpWf4bCLcg3KesiorRr38oxdLqSD+B00cwewrGLz62bHlIpKUc
         TMCN7hCmIYAe3sIpuihGBXXQgciC2o59CibnfIgrDHmFQn4vD/G9H5OiXqA5XRCj2QDS
         9X7aU7C35jI+R16YqXYqvNvuF0VcbkLTK5kAgod/EdCsJVluWmQsu8HeDr6smtazlAND
         /pM51IjnI4tDc26JdRz6qjBm71/PeQ5CEFBbgIkiRNe/tNw2h73hJ9XX4WtrJ3xpRXxs
         WkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YI4apKyiwzoFZU9dVSAV6s8pxksTddQsWQQ+ARnfARM=;
        b=rcFjOaW/s+KEHdvDHcnoHa1AhIE3uYesvRZ2Iklu3ogRfeXIg7H/WnSE4E0892q3JC
         XTBj3G811Fh9zZnWSHU0Yl86eD28zqx3jUBSm12h/VvmTplpNF9ReTwkSQIlbALxN/Yh
         A4MHGz17V+zEKwTJs2io4S7mrcZVLJD/jLJdt3ac8V04f7dLkX+y5JcUdx5HZG5XMN/R
         rlmoIi5rsHZTR/pAvipnumu3k/ChVsVUUpVJhOC+HVg+TCqN2635pO4Z/441m4H/oCHJ
         /e/oBH2mE17iLtPcXpQerm6R3eerhbwuMOaPWu1PfOwhb6s0Jl1zABEYnAYXeouaPWLS
         gE0Q==
X-Gm-Message-State: APjAAAUBLNwOMH9kXqbC763tMMi5dVVFewGbCGuGVOWictuHys67YfNn
        mO1iMEHxgTRc7DFiY5u0aeFabf4+QSpTmonVEpU=
X-Google-Smtp-Source: APXvYqzJ6A54mX7dVEAFcM8N5fVArCSi1kuwY1aghL9QrCXbIKtdp2qyX/J4n9J6kPT3aYHMfMCq/YUVsmN9YLAsCQg=
X-Received: by 2002:aa7:9214:: with SMTP id 20mr33381833pfo.202.1557759603675;
 Mon, 13 May 2019 08:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <CGME20190512155533epcas4p110edff15ebf5b2efae32e43f0f10ab59@epcms2p5>
 <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com> <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>
In-Reply-To: <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 13 May 2019 23:59:52 +0900
Message-ID: <CAC5umyjrYddqtQY8LdoXG8S7s7xaAO3oZz7WRDkfnjrkUj2AcQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] nvme-pci: trigger device coredump on command timeout
To:     minwoo.im@samsung.com
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=8813=E6=97=A5(=E6=9C=88) 16:41 Minwoo Im <minwoo.im@sa=
msung.com>:
>
> > -static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
> > -static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
> > -static void __maybe_unused nvme_coredump_complete(struct nvme_dev
> > *dev);
> > +static void nvme_coredump_init(struct nvme_dev *dev);
> > +static void nvme_coredump_logs(struct nvme_dev *dev);
> > +static void nvme_coredump_complete(struct nvme_dev *dev);
>
> You just have added those three prototypes in previous patch.  Did I miss
> something here?

These __maybe_unused are needed only in the patch 5/7.
Because these functions are still unused before applying patch 6/7.
