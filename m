Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39BE6063
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 05:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfJ0Egb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 00:36:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41445 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJ0Ega (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 00:36:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id 94so4672529oty.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjdMJeeRCP/2LcU45GXk4+A0a869QbmUnH1wlVeAy7U=;
        b=hcBWa96p+3d+/J+Q3PwMdV7f03OTEcJFAowFkq/BvnWiMtnetgx7OWzl3ElW7zW5U5
         4w5yFpdH6SaxCpII/wYDSTihvywHFnoCttV2yuc1SnyEbBtfUy2BLbDXlqgN4qbQhkcK
         kUIWhAUsq6LD0GFqnWYB97hO07OckF93H2Q0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjdMJeeRCP/2LcU45GXk4+A0a869QbmUnH1wlVeAy7U=;
        b=SiA0iENOS65saBhx2r6471a6chHxJFtGMCGxAFbqKDcJNqvLozB2EOt4NYHirWI2LO
         UfNfGYIhT0K/zjyuIN9bpnOcvCBdhswva83VsiKvsipTZM3k+pgpGNIoSkcV/MoRJBTW
         n6wZOJdmMmmLh+D3HxmQyIIFUalI/wlpc1DMFvMhmvQFzO/SXJfuyIglKj6X1uscZVgh
         l85D9gwyAZpelqHauwrSt40MeVDeg6FQZ/Kunj/yELJZ9HOGiywxN5C0+I3RmiCqO0XH
         PqIiVl8djrHmkLT6OjMtPe2A5wX7ORlhK2kBeSQQg+HemMWACE/Bx+ihib8Z6mHsaEgR
         ffvA==
X-Gm-Message-State: APjAAAVzeqB6MjHXFuUFMbKUaBFeoz0CuWmAVmsB4wObifptFYij4lXz
        oyWsT/TPfrov8ZFnudQpnGSmmnDHxdDtKkzuuJwxzA==
X-Google-Smtp-Source: APXvYqwwhalYg1gkdWHBSUYpiMBn2jlMbmYeChap2T/TdG7wET5CNRCJsY+zpTjC++ovSDZtLKJFVXKNvAPiA7GNsa4=
X-Received: by 2002:a05:6830:1ca:: with SMTP id r10mr204940ota.246.1572150989932;
 Sat, 26 Oct 2019 21:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191027034937.GA7401@saurav>
In-Reply-To: <20191027034937.GA7401@saurav>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Sat, 26 Oct 2019 21:36:18 -0700
Message-ID: <CACKFLi=+WNCZGC=r2c7R_fxojpEMiFf59qEkJefu2NcFgcF5Tg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: broadcom: bnxt: Fix use true/false for bool
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 8:49 PM Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Use true/false for bool type in bnxt_timer function.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
Thanks.

Acked-by: Michael Chan <michael.chan@broadcom.com>
