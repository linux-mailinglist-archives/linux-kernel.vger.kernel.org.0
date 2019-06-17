Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34C47835
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 04:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfFQCg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 22:36:58 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:37926 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfFQCg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 22:36:58 -0400
Received: by mail-qt1-f169.google.com with SMTP id n11so9027067qtl.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xwrHaBAQ4PIiRjCN9maPW3zKVAW4fgT9GFpBySgS+vY=;
        b=j3znGaqLHpxAXPt0s4/SrDpkcMy7T2JDq+EEDWJD4s4QtuS3VLMWAZmjRy7n9oy4Wc
         dH+E3+9btVundeHnOaSGutca3y/qhy50InZrUpC3RUN7L0Fx0EWaDQSOf5nIPT5HqTCs
         fMk7+Tzw2t6UyMAUJMSUufnJHMAfuml+X4vN2Z1fbwtEL/qtgOIjB2FjIut5HX4SdgdI
         miseZDTyKh8CHrxLx4rThcdCKHZ1ID++2l6+ffdXrSytrQt9RuhCsRIVIHf/DIODluTH
         CV+HPWDOUau63sWxFq27zYYUU3IHB208rtCOUmfovpeJdgvzsi6ulusD941Dxh8Gyoml
         vKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xwrHaBAQ4PIiRjCN9maPW3zKVAW4fgT9GFpBySgS+vY=;
        b=Hs3CZ5YQb4o90k43LGvp878TycchQdaPmiwikZrE2TI8BveUOvGsHWEx/pk7W6oE1Z
         MWhChiKUqcK0ZD+yp1fbTDFGU85VQi0SaJ5IqpAHJTNlmR/TIQ0stG71ydSCXvJG3pU6
         UJZS+zqwV8kjLW9/1nrTphJTezrNLzAtJScci9BDoBGi1wqKS91HYP5iYzrP4IWgWWV0
         25HhOfBBXmZ9WhpUyFFXsh+l8zj97syz6AqZIMCTe0x1o8tpmw9Ak8j4h88JtPNjvvn5
         phRe4vNUsWKWC2rw5grUcnR1Ttqf5GyDI3i8BYQaJB5JXtl9Oa5T5F9KE2ZxmU4zGAVB
         1M7g==
X-Gm-Message-State: APjAAAUZtoZ49SXMkZeUmECXVvfL1mivC6TN2QAPqEil2qPtgx0xpEAO
        4AOdJGFiZQvRBcMeSekmTIIdHG3ih1F1tArXP/c=
X-Google-Smtp-Source: APXvYqzbJo9WCOEEnG1M9nfUvIjqxeMua1zxAfEuad5OV5asbi5wLhwB+ceabWvZWzSYLjm+HHbpp+1QfmTgdmdfs3Y=
X-Received: by 2002:ac8:7c7:: with SMTP id m7mr87020793qth.28.1560739017151;
 Sun, 16 Jun 2019 19:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190614100928.9791-1-hch@lst.de> <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
 <20190614122143.GA26467@lst.de>
In-Reply-To: <20190614122143.GA26467@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 17 Jun 2019 10:36:21 +0800
Message-ID: <CAEbi=3dv=bfuFt0f3Pp4W8Cgir3zOO8gXO-5AYPgfZQF-g+yHw@mail.gmail.com>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B46=E6=9C=8814=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jun 14, 2019 at 07:35:29PM +0800, Greentime Hu wrote:
> > It looks good to me. I just verified in nds32 platform and it works fin=
e.
> > Should I put it in my next-tree or you will pick it up in your tree? :)
>
> Either way works for me, let me know what you prefer.

I prefer to put in your tree. Thanks. :)
