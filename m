Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4981738A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfGXTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:31:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43772 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbfGXTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so2351698qto.10;
        Wed, 24 Jul 2019 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEYXRfxDMQpSRlqGw7giHzXrwzZ2wZjC978EK9xyRN8=;
        b=IW0iJnlwU+6BMKYqPwgjATPX6yxEn+xYUz4mTlOK++buj0vNE9wEj6n7Yrt8oo04S5
         wPVopwjUos7Dz7G140Un3YHFfOXH8Ap1fzGPJUtNa0kN5lVN+RmsqrazCesSUiOIIoYL
         dzUy6IzCmseJagRl6IzaRYnXoSAEMwTWaOPZjcqisMcDdLEXfQ6vwXXomW93jCj1DxZq
         O+s0DuJviB9cM7gwsrLIPGprb2xwxVDHXBhG4C+rxZ6y+qIHLN/fxxW3NrJ9jBA4S9eL
         EHzPKYi+YHlyBWQ/XEJSghTqoI3fv7lwjxz9eUlhMrtJk/UR9I1p7rply/d0STOXjWz0
         FRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEYXRfxDMQpSRlqGw7giHzXrwzZ2wZjC978EK9xyRN8=;
        b=Efx3oxCpqjwmEWwTq3OSORHZXexJorHBMaeQt+KYm9b+At2mXauoabaJ4pQeW4Xoqq
         QfvEeVzIyVPEVwe0JYG2AyMUwO1Wk8c56vwXxNRitWruQsY8VSBTwGNuefnbkxBNE+6w
         5hblUBHCInwoceUUN3uAJg+rYHGZ84/TOutJ8b80TVOLD+zQm3kDhSL5HHOZ1GD/4tDg
         rK7OK05jm8J/C1TJOyXk22O2UJGRMqvyta6tTDdp/moLIsbEs8TpjGbRXLq+5wKPAyE7
         Er0bYXqOmvCypTGfPepryjcrWCeYuGTyWFQqqoaowZE7QNTSRZkHXzYfiH5ZjKyhRFRB
         NIWQ==
X-Gm-Message-State: APjAAAW+yw+Shn1Opd7JUY/oVMKJU3iOfJDtE0CCd9f0l8jor+IXH0cp
        gDRKSfKA/6I032AFyXCvZLEPTzTcf5H0w81B0KEd
X-Google-Smtp-Source: APXvYqxGbYe1CZBM/SrFvkzjBSGjnnbVZJe2Zqf9jXR0AbM4K+io5m5Hz53gzDF9ngRUORUDeMHA3BNJtGpu9i8++QU=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr13764090qtb.224.1563996703415;
 Wed, 24 Jul 2019 12:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190724130252.7c29bba9@canb.auug.org.au>
In-Reply-To: <20190724130252.7c29bba9@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 24 Jul 2019 13:31:30 -0600
Message-ID: <CAL_JsqKoAG9iu7CfuivtfDXE5Opf8sq8=tRPPWQGT4FPOxiyhw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the devicetree tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:02 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the devicetree tree got a conflict in:
>
>   Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>
> between commit:
>
>   355fb0e54e85 ("dt-bindings: input: sun4i-lradc-keys: Add A64 compatible")
>
> from Linus' tree and commit:
>
>   3f587b3b77b9 ("dt-bindings: input: Convert Allwinner LRADC to a schema")
>
> from the devicetree tree.
>
> I fixed it up (I removed the file - the additions from the former
> have been incorporated into the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I've updated my for-next branch to 5.3-rc1, so this should be resolved now.

Rob
