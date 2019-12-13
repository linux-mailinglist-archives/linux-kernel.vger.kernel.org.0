Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3325011E009
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLMI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 03:59:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37118 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLMI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:59:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so1785722lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neDwLTAD9jZBzNHCTpQNXqb55Q19dpVUnqxtm4qngC4=;
        b=vxcn/yQJtKa3gJABcbwws+zsCvWydlc4hiIlN9oHnNaSKTpm0zNd3gpSZO5lShK4Lz
         7ySxoBZZGyT5IiZTF3DrIFpn/9WuEgc0UolRO7BMf9GXSrO5NI07h63FPaW4jxPCtWOB
         I6SnDaSDk7AnavpFEBYYFZBUwEDPcQKoDKB3wp/iAv/UC2ql2i548auPCoNPhWAInw0I
         +tyTHKlU29ssg/GMIwqe/VMfmRUjcRPrtFbovPdBY4g84ap+mKqX6vsx2uC9nZQs0pP/
         MqyAg7GtGxi9QH3iQGXuAmmorV5vGfdgh/zqtwbWfmk9c2rI8MKy4OSuTlOREaAvuZdb
         2qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neDwLTAD9jZBzNHCTpQNXqb55Q19dpVUnqxtm4qngC4=;
        b=ZUaYdAdhuptIaigE51b2gpWtSa6ogP5wVHkYO2sh3yuo+XZJaU6/Nqm03vANNHWw1V
         7CwFgmcrteQUygDVYF+I8nF1lebe67h5gtE3Xqr2jwr5yXj9bgQVMmhvbpTvreG3BGe/
         45n2Ad5rh+wHLJ813iZ37i37lYLGg7CjAX690NwLfaChpErVw8Wt9+LVh0xbqiITu2ku
         rhzgj79Tvv0l1GOGWli04n21B0l6zsOppBAk6sWSzDOLMkNMqVNRc+cUSrj29jCP2d+V
         Ddcwt6SJFjGPaLn7jqXs/jKoXc4A06yqKiBEF+l++g9a9L8uzk5JIRgU4HUZTIYZtd5l
         hECA==
X-Gm-Message-State: APjAAAWIkxKMLR6Uye4tgIPy9O0w1Spb3y6TefyaXx+WOItLMTxwRabf
        ClRmFXzXZ7DFxLb0FxNwxoXWK6icqkSqiaTg+ca2qQ==
X-Google-Smtp-Source: APXvYqwZVnxTaJNmp0/febncjlgk6iuHq5jonrer+d7mi78Ma4GA9yOu/5k0S1c8VDfcEAJynShMKVgq8xK7fsF7R/k=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr8447089ljh.42.1576227561359;
 Fri, 13 Dec 2019 00:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20191204101042.4275-1-cleger@kalray.eu>
In-Reply-To: <20191204101042.4275-1-cleger@kalray.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 09:59:10 +0100
Message-ID: <CACRpkdbHGitYzwVEVYLUmaE+Qn0ix1O1bOSjoTJomf+h9b4+rg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add pinctrl support for dwapb gpio driver
To:     Clement Leger <cleger@kalray.eu>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 11:10 AM Clement Leger <cleger@kalray.eu> wrote:

> Synopsys DWAPB IP includes support for pin control. This control is basic
> and allows to switch between a hardware and a software function.
> Software function is when driving GPIOs from IP and hardware is controlled
> by external signals.
> This serie export necessary interface to be able to move the driver to
> pinctrl folder and then implement the pinctrl support which is based on the
> digicolor driver. The idea is to avoid hardcoding pins in driver since
> this IP is a generic one available on multiple SoC.

The overall approach is correct, just tidy up the patch series the
way indicated by Andy and we can probably proceed efficiently with
this. I will review the patch adding the pinctrl interfaces separately.

Yours,
Linus Walleij
