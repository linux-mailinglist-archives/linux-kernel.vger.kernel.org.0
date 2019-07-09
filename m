Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D463B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfGISxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGISxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:53:25 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819BB21670;
        Tue,  9 Jul 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562698404;
        bh=0ImkJUz3uR/+DVGq2bXGZLAIbe6zf2CjaYLEOlRY4ps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2hvgQEnOPWC1SvHHrf8dXGJxWxD4yWceJdhi4hloTlumiiTegaZkuaI/tFneSFCDK
         3xeoJtlqtM5pHiqMQ3Mc7kzVGgFdQQZzikumbGqCF12E+X0WA3Aj7p9WbrTWsEAv7l
         g+RCorpwnDSB1brEdg6kE1alx6PSeliKzH9aqnSI=
Received: by mail-qt1-f178.google.com with SMTP id h18so15298441qtm.9;
        Tue, 09 Jul 2019 11:53:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVoqC2G9l4l0DyZPF52x8I+Irxe75tHiF2Y6pfUk/N/jpYd19m/
        5RWG+hdtwtwdcdZEmo1OPnrOGKIBg5cSZPsJqQ==
X-Google-Smtp-Source: APXvYqylibJKKbin92OddAtVOLNyjL4xzmkeD9zXAOF4W4EKSaAZ0cVt6KqwCFYn1XAIrYpKX6ExRt5TG60yMAb0li0=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr20147515qtf.110.1562698403737;
 Tue, 09 Jul 2019 11:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Jul 2019 12:53:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0z4OZ7qbaiUva1v5xCKXpsaPBZ9tj_M4HbEihsU_MfA@mail.gmail.com>
Message-ID: <CAL_Jsq+0z4OZ7qbaiUva1v5xCKXpsaPBZ9tj_M4HbEihsU_MfA@mail.gmail.com>
Subject: Re: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 2:01 PM Hongwei Zhang <hongweiz@ami.com> wrote:
>
> Add bindings to support SGPIO on AST2400 or AST2500.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++

Is this SGPIO as in the blinky lights for HDDs in servers? If so, that
has nothing to do with Linux GPIO subsystem.

BTW, You might want to look at Calxeda highbank SATA driver. It has a
bit-banged SGPIO interface using GPIO lines in it.


Rob
