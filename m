Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACBA15B704
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBMCKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 21:10:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46202 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgBMCKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:10:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id e21so3244093qtp.13;
        Wed, 12 Feb 2020 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUdWWp+c0fomnydwOZuzDqMxQIhxsbRs6tTf2TPYRzA=;
        b=B4o4H9MS03jB3qy+5V0hztuGt3eAHe4/kGTzKfPzIWZrT6Y4P2LcjHeFf4TFYvd/4j
         c1VJvS86dpFeceOKyicjeG6kYeVBDsmpTaXrZ20HPUemdGubmkbA7sBEC6ahtejz3YAO
         cVaQ/gJ7T9m2ApmVqTSgj3VnjBCPXehozQsheNAbO72TPNNrMu7/PbSeLE1OlLLEzsTB
         z4uefz8/7cc19Ehm9ubSScg/EwOgQB7zT4isfIYAYKb8EVl8NR11BCDQkCjmPNd4LrUE
         biYkgKUS8ALiZ3ciyqkigVZnZldwIJ6DlBboH0IqE/3d4W/ufw9l2xwsxLZV41XTE03f
         uN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUdWWp+c0fomnydwOZuzDqMxQIhxsbRs6tTf2TPYRzA=;
        b=Ut5bqJduAhzg5CNrjB2xO6vbRtucos7MnXchK2g5le3fGH6m7yPuVwcG+XZoFsmPku
         U1Mc5sqwAY2bxxFWVEUt4Wg9+tx+0xSHkFjJExEEsooqwhloynjrSjzzSl6Z1pZf3shC
         e8ipsbVhR3j/qa5r2+HBtD/x26An1cw+JE5Kp0/0tWR7lDwY7nr9gRVoslDI596o9WAU
         5vonYRy3D7FoKxV5xLfo1awkgF6iATy+FB2HnElzjo8rfB1rjBBufnHQgenk1J8LwnKU
         AXIzHOKN88QVIEoXM6YQfHGKTT+zXTEWiplBsAcq+IUCno+v7nn4r+hHVjcPbHXswBMv
         yTMQ==
X-Gm-Message-State: APjAAAUFD4GZp6qkxR8spBVtwVQaHpiYGnmsP1H+6qY6KZaRTEP1lR4l
        suighT7vLz5GSMw42UG0jVSKbHnyZdPVt7utQ9Q=
X-Google-Smtp-Source: APXvYqxdyDijz1rGqrbYCmLrIjViy7wgwMXb68AAZ4r2pC01PDuSdhiWq9HvmosjKuHgpR9L2JZlZb6NKQE8p5vXjwU=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr21937606qte.204.1581559847782;
 Wed, 12 Feb 2020 18:10:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581475981.git.shengjiu.wang@nxp.com> <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
 <CAOMZO5Do=dzh4WXvm44mB7-PeesWuA6qRtMXwHCH9piXd1dZEw@mail.gmail.com>
In-Reply-To: <CAOMZO5Do=dzh4WXvm44mB7-PeesWuA6qRtMXwHCH9piXd1dZEw@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 13 Feb 2020 10:10:36 +0800
Message-ID: <CAA+D8ANGtnPYNA9__Zeg8MJDaiw_kVebUUgU-jPmp8GXRNX4hg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: dt-bindings: fsl_easrc: Add
 document for EASRC
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Feb 13, 2020 at 1:26 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Feb 12, 2020 at 1:35 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > IP module found on i.MX815.
>
> i.MX815 in an internal terminology. Please avoid it on the commit log.
>
Ok, will use i.MX8MN instead.
