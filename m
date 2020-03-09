Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B792317E691
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCISOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:14:24 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42711 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgCISOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:14:23 -0400
Received: by mail-lj1-f182.google.com with SMTP id q19so11000367ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=koPyYPcnPETHgCvHEnnCmdmwfA+OhLOvchqTM1xprps=;
        b=hcX3nNInTx9iPg7EaR+RByFVzvo/cSttxQcApuNwRryPYcMSIWjR9EGkmg4RuaKhT4
         Dvkz7XZHPwiW2D/MPgulKgvlSOp2p1+Z6RSgpSLCSj8oQlR1KydMYFuXN2GJqA+khaaI
         n+jHxvfrvN4OZXWhrflT6H8M3bYWCmMJnNwL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=koPyYPcnPETHgCvHEnnCmdmwfA+OhLOvchqTM1xprps=;
        b=MzWT/1jCWbTVymNP9I8NugG1/wof0PCs5xqcpUmdb3Cn4IOyqKi6ERvYGgdGJidMlr
         YHU8TQe+NxJE/aL50hY45dalqt/+9z3NvnuwWO6lKmbCqsqy2Na9cL9Ot5qBaAG/7/ad
         CDivXezD+Id5q9ZJMEbu+bTo7fGSxs1BskczdSawA0L+SKZhct752d10lmTHUTq6FN4Y
         Vdv1mwXrnfeabAYUA6GzcTF7bognF7IPenlh4ExCjwuroKVaZouZM6cZ6jnAGOyNc1y3
         OAtM/TmEvpfzS/v8BujO0FNjUtcwxtPH/HMah4Z0N/kP+UOM3JPYokUhIknRhOeUwFXq
         e7iA==
X-Gm-Message-State: ANhLgQ2OEyE4sayteNWbrCUssUy1OOh62boigCmx8WXZxBRCP7XATC24
        80gLRqvXGkXm+kfKRyf+9dkBxOx+PZvfYPY7KWNpNw==
X-Google-Smtp-Source: ADFU+vtgo6olIYRoVSmwWWivdI6JJjr250gtxBwwoAJTPwO/+EsUYi98/L4RLCE5w9lBmxHiqH1H3VYw5KdKjPdM5rA=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr10292149ljg.105.1583777660196;
 Mon, 09 Mar 2020 11:14:20 -0700 (PDT)
From:   Kevin Li <kevin-ke.li@broadcom.com>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk> <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
 <20200309175205.GJ4101@sirena.org.uk>
In-Reply-To: <20200309175205.GJ4101@sirena.org.uk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK6AtPk+W1UvlC/8YJn5FlJAEq5hQGCyJpIAfJ2lUUB0s+e4qZONC5g
Date:   Mon, 9 Mar 2020 11:14:18 -0700
Message-ID: <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
Subject: RE: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't really parse what you're talking about here (perhaps some of that
context would have helped...) but it doesn't seem to be the clocking of
the I2S bus which would normally be what master and slave would be talking
about.

It is the clock setting of I2S bus master or slave.
If I am playing music only, I set TX as master. All others are slave.
If I am recording only. I set RX as master. All others are slave.
If I am playing and recording at same time, I set first coming stream as
master second coming stream as slave. If I shut down first stream before
second stream, then I will set the second stream as master, otherwise
there will be no clock/FS signal on the I2S bus to maintain the second
stream to its end.
Hope it is clearer.
