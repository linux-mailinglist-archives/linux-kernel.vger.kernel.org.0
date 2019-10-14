Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA9D639D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfJNNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:17:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36713 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfJNNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:17:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so19730644wrd.3;
        Mon, 14 Oct 2019 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNk6gqWx11OOhEP9GqPiQBYiSq/mKMHVb0ftn5rUsng=;
        b=lmyZHsUcdj2TAh2Ku7rl+sBqGSaKDTkWn8rYvnKY6lqqIsvOSW+PvmcdinS2G5QAix
         +My/z2in8mwhBB8eTT7x+n2GTQ7qibNqsrWBJvf8mT/+sSi9jO4FNa/oKtMGjSR44r4D
         kYrwqqLNJMVwfF0j/dLnCee4Oq3e+SS4RSDK8TJFUyqmhtoKJ00/qQPcD9L65sG5/Oh8
         l7EHaa6UcHP8ysuqkO4AMEMX10ec8fQYt7mNHcyuhZNjskQDVSug24kuJeZtj4FsGdwH
         Kvv/vC9dqvpf+c3sT7hd99YxZWM38YnTNOLW04oQRQ2q6DuDxXN3ceZqi/ZE1+/tLd1T
         scGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNk6gqWx11OOhEP9GqPiQBYiSq/mKMHVb0ftn5rUsng=;
        b=lhltGSjkj0N/NMGW7Wm9FBYpqXH8cMj7t3eFHdUgQu0/IuaDda/+LjY6Q8FhwrxAfw
         BSlut8VJMTwe6Ehz04stTLRMbyNyAsRVXoABYkt8wImnu5z91D+AsRXuC3aC6PTXqXzK
         cjFhLzYpiU4fB4W4tOfeW/guRlycz4nd/ClGt3oodE4L9hwvgg3osepADlFcz1wOUuKo
         /nXIdrKnD29g+hFaBsI9USdWHIYct3etPLPlybqguYfUYdUfXEGxwPljcLCStQnlXpP4
         ZMV4bNYMDSmmnlWePngzQ0OzMtjRKPjRNnPbFcPwI1YS/lXs5PZ9SUh8TKlH6UT5YZFa
         Od/w==
X-Gm-Message-State: APjAAAXiqZYTk0M028TRdNGtD1CleKo31uHubeBRiweX9TP45TNEx038
        aQFnFxIkiMKjxlLaMRzZJmXpYvX3MDinCeTWG5ZGHCl0
X-Google-Smtp-Source: APXvYqxe2p4+Y3j5MCodZuoPV/55GLoK4DLo48VukFjuDothWxik42DQe7BCSwlbtr9vj2b6iR1WdDfFZkBDVIQROVk=
X-Received: by 2002:adf:a141:: with SMTP id r1mr26206376wrr.122.1571059063332;
 Mon, 14 Oct 2019 06:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191013190014.32138-1-daniel.baluta@nxp.com> <20191013190014.32138-3-daniel.baluta@nxp.com>
 <20191014115635.GB4826@sirena.co.uk>
In-Reply-To: <20191014115635.GB4826@sirena.co.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 14 Oct 2019 16:17:31 +0300
Message-ID: <CAEnQRZDbXZUhix_aR_DCUzFn1NYz1Zh7MxW5uwnuycps9PNohw@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: simple-card: Add documentation
 for force-dpcm property
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Guido Roncarolo <guido.roncarolo@nxp.com>,
        Jerome Laclavere <jerome.laclavere@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 2:57 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Oct 13, 2019 at 10:00:14PM +0300, Daniel Baluta wrote:
>
> > This property can be global in which case all links created will be DPCM
> > or present in certian dai-link subnode in which case only that specific
> > link is forced to be DPCM.
>
> > +- force-dpcm                         : Indicates dai-link is always DPCM.
>
> DPCM is an implementation detail of Linux (and one that we want to phase
> out going forwards too), we shouldn't be putting it in the DT bindings
> where it becomes an ABI.

Hi Mark,

I see your point. This is way I marked the patch series as RFC. I need to find
another way to reuse simple-card as machine driver for SOF.

thanks,
Daniel.
