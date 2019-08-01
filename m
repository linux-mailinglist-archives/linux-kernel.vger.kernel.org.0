Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CE7D3B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfHADfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 23:35:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42005 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHADfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:35:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so68812282qtm.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pbBP1a5vz9LXfKrpqmLYROgp0dhYosum5tb/DUbL2NE=;
        b=YfTqkkhedP+30s5tEYK+1pvWEbwvFULIzEK/DaGsig/1f0A6WsHk+ovEGa3iYsMmfe
         Nk/Jij7FxNUBbO2AdwscxfrXkWFQgEioqU5JydD+iqdEr0sHNsZziR7KGVkG1k15yPxh
         g7msAiNaIfHm8FkRugefuVTQH1atly5yDXy5axyInrIF1vgeCo8BZ8rTieQ2svHqjiBS
         z7U4203ve8JS7RlqvMuu53J+iT6cFxAXDf5dOPGPG1O3J0/Ra1i9LcLWsbV3xh1vR+Kp
         TUWREKLrZ6dy9IxGmlNh9nJieNnn4T5GEMMCEBbF6Gqydd1hhOtODlGHmKi/pEFl9L51
         gMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pbBP1a5vz9LXfKrpqmLYROgp0dhYosum5tb/DUbL2NE=;
        b=YULPGYyXRetJtZyaQ78F5rIo2Jiy5VwmB/6fTfazgCdOjT6vq23KqhGnTdfgtL5mmj
         1UUfvXhxGDsr3rMOqzaGvO6mCuBKMadSTlir1SCN7Q9GChDFIHhfAq3f3tCDwLw67/Rz
         g4w2tXiuTAfzayfChnuxmmBEWEfCOZ9wHjL5BoEfaiGwjd/PDfkILVsL8h0+u6RQPiUo
         LnkC8XzOwIfXTVR9yg4/vrSLtE1cic3XBXu2Z3ff1BgvrlboTFRe4I/y0zCqR+GdGkCd
         sIl/35dU+3VKMgQCndVVb4IDatiGXVja6ZP0MeZgSSeskHItFu9iQiX8qSnCJS7FemQl
         rzSA==
X-Gm-Message-State: APjAAAXm4QTcN/ONbcpdfttGX1UzzhVMoxMINtUPsYstVVnvwYzqFWwT
        Ns/emJ4qleSWa1E/LKgH8bnmRGh2TjdMiTJZnrU=
X-Google-Smtp-Source: APXvYqzhcZCTwiX7Qnv2duqf9sCENlg+TpJDs9LzbWZZkr/9Wer2rXkPvtIg+YgdewF22FLewWMVhnRRzxMJO/P9/ew=
X-Received: by 2002:a0c:8910:: with SMTP id 16mr91100016qvp.55.1564630513367;
 Wed, 31 Jul 2019 20:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com> <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
In-Reply-To: <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 1 Aug 2019 11:34:37 +0800
Message-ID: <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     greentime.hu@sifive.com, paul.walmsley@sifive.com,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 2019-07-31 12:30 a.m., Greentime Hu wrote:
> > I look this issue more closely.
> > I found it always sets each memblock region to node 0. Does this make s=
ense?
> > I am not sure if I understand this correctly. Do you have any idea for
> > this? Thank you. :)
>
> Yes, I think this is normal. When we talk about memory nodes we're
> talking about NUMA nodes which is unrelated to device tree nodes.

Ok, but it seems the second memblock_region may overwrite the first
memblock_region in for_each_memblock(memory, reg)  loop. It always
uses this API to set to node 0.
memblock_set_node(PFN_PHYS(start_pfn),PFN_PHYS(end_pfn - start_pfn),
&memblock.memory,0)


> I'm not really sure what's causing the crash. Have you verified it's
> this patch that causes it? Is it related to there being a hole in your
> memory, does it work if you only have one memory node?
>

It works fine if there is only one memory node described in dts.

I think it is related to there being a hole in the device tree script.
I don't actually have a platform with a hole in the memory region, so
I use device tree script to describe it.

The physical address layout will be like this.
2GB-3GB-hole-6GB-7GB

memory@80000000 {
    device_type =3D "memory";
    reg =3D <0x0 0x80000000 0x0 0x40000000>;
};
memory@180000000 {
    device_type =3D "memory";
    reg =3D <0x1 0x80000000 0x0 0x40000000>;
};

Thank you for the quick reply. :)
