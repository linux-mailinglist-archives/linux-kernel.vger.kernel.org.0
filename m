Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242A355108
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfFYOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 10:04:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38095 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFYOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:04:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id l10so4174237ybj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pIIC3jytWsmntojJM5beMPwkkISJ/lE+BJnG08AcnU=;
        b=mRU4gBCrfg1gioLKe8ve3oGpbXdbfnB/ITSmqUQ9RcKXPtDFqmjktz9gM9ltsUh+wg
         yUOjr6uBYr3ljB+H8Qpntj89LzaLJ8o3QlvN9SRou/ztu9mINIl4ZYYaTN4BJuuYlANb
         Ut0kJmWvQM9BgB5orcacPdtvxfMMYeSgbJvugc/6SVKkKeNPc9WXLZlNEwSzV7Jyz7dw
         D2YbmYBouyrHwbDsgfzL+et32rsvUyNbdFc2SUx5jusN9rhLxCH4jZgtjKHlro+olg7q
         B0MwiYxTbk+3sGmNj0ndHj6Tn9PKidy1jzuvBQtDn3VADbLLRGWJqFTBKEe1779CkJhT
         49Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pIIC3jytWsmntojJM5beMPwkkISJ/lE+BJnG08AcnU=;
        b=gqCwinxap4uNMALLlSRwkU30nnUkmHMWfHU0AMAF8x0TX+lImpktnfhoioorKbo1jt
         pEgUURXokIp+xwbsGc6b4zFy2ufbV8IGTDFEYKWBxX6MK0OypY3wRbcAA3fnkF5mQ38X
         IVa6MpMqVW+QzZrgdXUGm7ojawCatCAvvrV76V1q0V9HaCg1b/F+r44EGKbM7VUriKfY
         Wceje5KowVJr4NnwJFDOgtu80xHTuXZ9p46WlCxcKII0krSYyTsUgD3vXXnnLvw+PO7C
         W+uAToWvZp/o4zyQ2EUwT2gM3MQPMt0xxGSNaBvWlt8mfJctcMTDWehg9D6uvSusrB8m
         GW6g==
X-Gm-Message-State: APjAAAXn2gYY3xomVsgrKOf+RRKp9aWM84JdooFDy0pJaJSo77p/fD8y
        Nl8VE6vCsHKQBGxYETeZpGOp6AlJ
X-Google-Smtp-Source: APXvYqz3Zia/AlTKSiCbcnk/Dtpz063RM91ekQPRnvUh+AxsaEvqAK8Ok6zZm/uj/KIpbLSrLNOw0A==
X-Received: by 2002:a25:9cc4:: with SMTP id z4mr84857029ybo.187.1561471475342;
        Tue, 25 Jun 2019 07:04:35 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i84sm459189ywi.0.2019.06.25.07.04.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:04:34 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j8so5422350ybo.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:04:33 -0700 (PDT)
X-Received: by 2002:a25:99c4:: with SMTP id q4mr11512887ybo.390.1561471473136;
 Tue, 25 Jun 2019 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190625125048.28849-1-houweitaoo@gmail.com>
In-Reply-To: <20190625125048.28849-1-houweitaoo@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 Jun 2019 10:03:56 -0400
X-Gmail-Original-Message-ID: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Message-ID: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: add error check when wq alloc failed
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, sean@geanix.com,
        linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 8:51 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> add error check when workqueue alloc failed, and remove
> redundant code to make it clear
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>
