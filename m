Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D6DD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfD2Hxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 03:53:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42340 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfD2Hxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:53:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so10867424qtc.9;
        Mon, 29 Apr 2019 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5t3ha+L/fYSXvu7o0ySbyVykauyPN6EAUxnPIHb4CJ0=;
        b=bCja6QsaoKBuddwyLN7Ymwyx1swIpERjorOwhUMNvQjppCPYWWn45unKFCXWw6v8NV
         tLMMy49XYA18pN+j2THaZlgHJgmRrmkZtLeKXFb2yDOhxo0pzsV/rC6ZTN5nUPEmrvxw
         H8Inbo6e5paggfmsXww73Z3oLs2/WZaWoI3H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5t3ha+L/fYSXvu7o0ySbyVykauyPN6EAUxnPIHb4CJ0=;
        b=qQ+7vR21KfKmI0WBIDJLHVB8lA2pj6nng01elu+QWfcW6JkJg4oCbDvXdSmPzikSUZ
         MdrLeQQGO35Kj6g+dUH6e+wGx1E/Fa58/VzwDM45gfr+i4hV7x8x0aluaowl2JYlgcyn
         lweXqLjgyd6FAwBSom4Ke3zEmymM4sbeNYNLzd7Hmux5V+S38h2evnRc6WdIZlqNnFCB
         KY8yzSWdIwO//OGpJM+b5CCKWvUb4xK6U/PiwZpoIkfOfO5zJl77sKxp4q9aElJ7ypM7
         415yrMScDFG4PJg9ivxNXsvyUxLdTUG47PfU1lypSfMH0KmlhHDpC+OWR5rDXsNRR2Q0
         pE3g==
X-Gm-Message-State: APjAAAXZ6I/n/8ffJP9IHks2wJLNyBOeDrzdyL2AHewpLW5ZbBKUCPbU
        Aoo0OjGDXoy2Pik52ZSiJBPUZNgjSBkMgajFqUs=
X-Google-Smtp-Source: APXvYqx48H9AYPZuMFrqfPObYS55llABgvbLwiFiYW98pm7xlm9uxMeurzruoh/LKxJaOVfxTRXM1+nMdxblh/TRCwg=
X-Received: by 2002:ac8:169b:: with SMTP id r27mr33552179qtj.235.1556524424431;
 Mon, 29 Apr 2019 00:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190425194903.144569-1-venture@google.com>
In-Reply-To: <20190425194903.144569-1-venture@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 29 Apr 2019 07:53:31 +0000
Message-ID: <CACPK8XeDS0RfF1SSTuFbSoO9a7N6qDZShovj5yF56Pc9PA6nDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: quanta-q71: Enable p2a node
To:     Patrick Venture <venture@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 19:49, Patrick Venture <venture@google.com> wrote:
>
> Enable the aspeed-p2a-ctrl node and configure with memory-region to
> enable mmap access.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to the aspeed SoC tree.

Cheers,

Joel
