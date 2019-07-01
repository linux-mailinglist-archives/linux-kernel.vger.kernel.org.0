Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F4555C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfFYRTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 13:19:35 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45181 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFYRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:19:35 -0400
Received: by mail-pl1-f176.google.com with SMTP id bi6so9186270plb.12;
        Tue, 25 Jun 2019 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOwCBQyZRzVGfYg9SNTddzZDAkrsd0M2owTZiePG8Y0=;
        b=YgGXKq67re3Lt45hm2dx1e0cgK2kXEbyhwGGG/6S5n3yg+YKs0E1xfzmNt4gwDa3NU
         1Hi0CuBKLTcaoAR15Nv9umUB2s0C3ZWtGeQUXUa2Mj25ijLQ+rhuAJ0P01CrINH2PRlP
         cWQuhemKcXEnR7vuuUDnj+m4Cll7fn5d9Zov+7TX/Xnae/KIKQio6dPbJq39PAeO6nRI
         aLrQ+nrYUNFmKpdpRi0cJTXk+is/fJqFaS6FGZx4gaNcGsAqMC3Slq3USWHY/JKF88zN
         DZIdRTQiQsEdNo68FE4HbE423VCSaQCR5n/Z4sNf8/GZQHiqrGq5XNDP+D3nC2rU0FSo
         F74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOwCBQyZRzVGfYg9SNTddzZDAkrsd0M2owTZiePG8Y0=;
        b=pVIm1UuriS6dCnRjxN3SVd3yEu0q2JvnADB2ZMODpcb12qUYLMcyNCfZfg6Ajc7ArA
         yaXIwsdGzuZhhjArIiFXjPg2C3e4WIo/rPnQae93q7eoeEEAhCGRb/Jc3Qtqlmls8W/x
         DF01qaaO6ypmQrbNm0KyJELfwLhgVo64k4elbuxUKAjA7rVL0GxwXdvpOv4h2BRB0MGT
         DzbpSz43MhlDbLdYUahVFl8p5ewrsV3tuCEMlSe54qINw9GrqEhfi1oQScvCJBFwsMqt
         9SAdsBw4Spow75RjETEa7aX14o0CeEbeKDVHkyoWsCl5QMGUH0PQ//4mDtZf2D/VYK0Q
         g6og==
X-Gm-Message-State: APjAAAW6jE0wCk7EWoc8C5uYerHpqGBb45tofwv+wC1XU6DzSRZgGKpY
        kWa2jZwxHQXMMAQsJ4VcPFpFfonqPAJc2+5ZTlimbw==
X-Google-Smtp-Source: APXvYqw0kb2X1B48/T4JKum7mtgX1P5q8n7X+39Ox3+V7IHev2oOY8mTnadreHiVQbLC+pJrrj1pfTM91AHoY3/VOck=
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr23320790plc.78.1561483174312;
 Tue, 25 Jun 2019 10:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190625210821.6907304a@canb.auug.org.au>
In-Reply-To: <20190625210821.6907304a@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 25 Jun 2019 12:19:22 -0500
Message-ID: <CAH2r5msJzRBZSKua7VffD+dkHu+4xU=QQ3KGRKa34fm-6M9CRg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed

On Tue, Jun 25, 2019 at 6:08 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   c1ed2864526e ("smb3: minor cleanup of compound_send_recv")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
