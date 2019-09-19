Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99C5B7710
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbfISKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:03:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41059 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfISKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:03:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id 129so1012695ywb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGmzlodVkbk9PuySdktLAlK2VmjoJpMiz8CiaztLcU4=;
        b=nFGvNcgj0OHpxFJumDa2Ovs/fwImiZSydMwB0fQRs7Sj36jRVuZJIIuOO5ApAelTOA
         41+k3YSD8KWYA0+DVMYrkmlQRtQahxf2XdExNPg9QM9grRok/u/IQoYo600PTY4wWx+w
         8eq6uhF8zpANSTkrQSDA572dz+LQkyERbhqLuyLAwqV/o9AWj+GT+DggQxWWYUq0dzW8
         NiDsJu2Apx9YRyJnT3xoWduKO1f7SqvRB3mwcqRl4fcVYevQMizOvGS9UutDE/KcJ+l2
         30zf2EUg/wS6+NLvy6ErnWgqBTXHt9nYVujDa3qHC6Ro4Lak5s9hZdNJpMI66rRY2HsT
         vq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGmzlodVkbk9PuySdktLAlK2VmjoJpMiz8CiaztLcU4=;
        b=bH0Zru/FDljXNZlP/4WHitGUQa+2LjdBAQDl+69Pb2/1B4go+QyRC+/LUO0Sn8zF+J
         zUSmNv/XpcPxSH7xuL0pvVfH10GmhKxNhUsen1YNjD0csFe38HqRrRNQrO1O7OaxZLa8
         RD+6wuHndMAY69wxu9zvkP34ehsYAnuiF7hfZMCcfcBdk7eOxNvlPmgfG9dyDxS2lyfh
         VCIU7/m8HOPfYS2Dx2CBUhPYv9NDz9tSyNaUyFvCTGpDsoskydNrjgrFjR0h6ANK/MQX
         g85t1tEOOBp9hZioR45znddEtoYaRbwthXv+3vvjMIwmPUPxNAv49UuJemtuTLyRlG2p
         lDVw==
X-Gm-Message-State: APjAAAUeAyhvzlIG8n1ALPJlnmySsQNmwt8b1MUM0C5NRpHaYj1wXiH2
        pM8pg4RPglDjFUxN9GUpBBGrMWqLuWfJNft717I=
X-Google-Smtp-Source: APXvYqzlpdC3yeqplykvZUm//SAQW27RajjuVHyWzNxKhwFHeDyDXhAPtXBfeBzqnd8lPooPdr3YBu/vcWAYZyJ984I=
X-Received: by 2002:a81:a401:: with SMTP id b1mr6807528ywh.280.1568887402177;
 Thu, 19 Sep 2019 03:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com> <20190910061449.GC10968@infradead.org>
In-Reply-To: <20190910061449.GC10968@infradead.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 19 Sep 2019 18:03:11 +0800
Message-ID: <CAEUhbmU+DhdSO729hGExs4uE3iufOFC2LEWPCug9hqvu21aM_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive: Add ethernet0 to the aliases node
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 10, 2019 at 2:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 05, 2019 at 05:46:14AM -0700, Bin Meng wrote:
> > U-Boot expects this alias to be in place in order to fix up the mac
> > address of the ethernet node.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

What's the status of this patch? thanks!

Regards,
Bin
